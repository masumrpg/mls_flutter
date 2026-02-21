import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';
import '../domain/entities/surah_detail_entity.dart';

// Audio player states
enum AudioStatus { idle, loading, playing, paused, error }

class AudioPlayerState extends Equatable {
  final AudioStatus status;
  final String? currentUrl;
  final String? errorMessage;
  final String playingLabel; // e.g. "Al-Fatihah • Ayat 3"
  final int? activeAyahNumber; // which ayah is highlighted
  final bool isFullSurahMode; // sequential ayah playback
  final Duration position;
  final Duration duration;

  const AudioPlayerState({
    this.status = AudioStatus.idle,
    this.currentUrl,
    this.errorMessage,
    this.playingLabel = '',
    this.activeAyahNumber,
    this.isFullSurahMode = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  AudioPlayerState copyWith({
    AudioStatus? status,
    String? currentUrl,
    String? errorMessage,
    String? playingLabel,
    int? activeAyahNumber,
    bool? isFullSurahMode,
    Duration? position,
    Duration? duration,
  }) {
    return AudioPlayerState(
      status: status ?? this.status,
      currentUrl: currentUrl ?? this.currentUrl,
      errorMessage: errorMessage,
      playingLabel: playingLabel ?? this.playingLabel,
      activeAyahNumber: activeAyahNumber ?? this.activeAyahNumber,
      isFullSurahMode: isFullSurahMode ?? this.isFullSurahMode,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
    status,
    currentUrl,
    errorMessage,
    playingLabel,
    activeAyahNumber,
    isFullSurahMode,
    position,
    duration,
  ];
}

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<PlayerState>? _completionSub;

  // For sequential playback
  List<AyahEntity> _ayahQueue = [];
  int _currentQueueIndex = 0;
  String _surahName = '';

  AudioPlayerCubit() : super(const AudioPlayerState()) {
    _player.onPositionChanged.listen((pos) {
      if (!isClosed) {
        emit(state.copyWith(position: pos));
      }
    });

    _player.onDurationChanged.listen((dur) {
      if (!isClosed) {
        emit(state.copyWith(duration: dur));
      }
    });

    _completionSub = _player.onPlayerStateChanged.listen((playerState) {
      if (isClosed) return;
      if (playerState == PlayerState.completed) {
        if (state.isFullSurahMode) {
          _playNextInQueue();
        } else {
          emit(AudioPlayerState(playingLabel: state.playingLabel));
        }
      }
    });
  }

  /// Play a single ayah
  Future<void> playAyah({
    required String url,
    required String surahName,
    required int ayahNumber,
  }) async {
    try {
      // Stop any sequential playback
      _ayahQueue = [];
      _currentQueueIndex = 0;

      if (state.currentUrl == url && state.status == AudioStatus.paused) {
        await _player.resume();
        emit(state.copyWith(status: AudioStatus.playing));
        return;
      }

      final label = '$surahName • Ayat $ayahNumber';
      emit(
        AudioPlayerState(
          status: AudioStatus.loading,
          currentUrl: url,
          playingLabel: label,
          activeAyahNumber: ayahNumber,
          isFullSurahMode: false,
        ),
      );

      await _player.play(UrlSource(url));
      emit(state.copyWith(status: AudioStatus.playing));
    } catch (e) {
      emit(
        state.copyWith(status: AudioStatus.error, errorMessage: e.toString()),
      );
    }
  }

  /// Play all ayahs sequentially (full surah mode)
  Future<void> playFullSurah({
    required String surahName,
    required List<AyahEntity> ayahs,
    int startFromIndex = 0,
  }) async {
    try {
      _ayahQueue = ayahs;
      _currentQueueIndex = startFromIndex;
      _surahName = surahName;

      final ayah = _ayahQueue[_currentQueueIndex];
      final url = ayah.audioUrl;
      if (url == null || url.isEmpty) {
        _playNextInQueue();
        return;
      }

      final label = '$surahName • Ayat ${ayah.ayahNumber}';
      emit(
        AudioPlayerState(
          status: AudioStatus.loading,
          currentUrl: url,
          playingLabel: label,
          activeAyahNumber: ayah.ayahNumber,
          isFullSurahMode: true,
        ),
      );

      await _player.play(UrlSource(url));
      emit(state.copyWith(status: AudioStatus.playing));
    } catch (e) {
      emit(state.copyWith(
        status: AudioStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Play next ayah in the queue
  Future<void> _playNextInQueue() async {
    _currentQueueIndex++;
    if (_currentQueueIndex >= _ayahQueue.length) {
      // All ayahs played
      _ayahQueue = [];
      _currentQueueIndex = 0;
      emit(const AudioPlayerState());
      return;
    }

    final ayah = _ayahQueue[_currentQueueIndex];
    final url = ayah.audioUrl;
    if (url == null || url.isEmpty) {
      _playNextInQueue();
      return;
    }

    try {
      final label = '$_surahName • Ayat ${ayah.ayahNumber}';
      emit(
        AudioPlayerState(
          status: AudioStatus.loading,
          currentUrl: url,
          playingLabel: label,
          activeAyahNumber: ayah.ayahNumber,
          isFullSurahMode: true,
        ),
      );

      await _player.play(UrlSource(url));
      emit(state.copyWith(status: AudioStatus.playing));
    } catch (e) {
      // Skip failed ayah
      _playNextInQueue();
    }
  }

  Future<void> pause() async {
    await _player.pause();
    emit(state.copyWith(status: AudioStatus.paused));
  }

  Future<void> resume() async {
    await _player.resume();
    emit(state.copyWith(status: AudioStatus.playing));
  }

  Future<void> stop() async {
    _ayahQueue = [];
    _currentQueueIndex = 0;
    await _player.stop();
    emit(const AudioPlayerState());
  }

  @override
  Future<void> close() {
    _completionSub?.cancel();
    _player.dispose();
    return super.close();
  }
}

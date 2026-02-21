import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:audioplayers/audioplayers.dart';

// Audio player states
enum AudioStatus { idle, loading, playing, paused, error }

class AudioPlayerState extends Equatable {
  final AudioStatus status;
  final String? currentUrl;
  final String? errorMessage;
  final Duration position;
  final Duration duration;

  const AudioPlayerState({
    this.status = AudioStatus.idle,
    this.currentUrl,
    this.errorMessage,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  AudioPlayerState copyWith({
    AudioStatus? status,
    String? currentUrl,
    String? errorMessage,
    Duration? position,
    Duration? duration,
  }) {
    return AudioPlayerState(
      status: status ?? this.status,
      currentUrl: currentUrl ?? this.currentUrl,
      errorMessage: errorMessage,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props =>
      [status, currentUrl, errorMessage, position, duration];
}

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();

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

    _player.onPlayerStateChanged.listen((playerState) {
      if (isClosed) return;
      if (playerState == PlayerState.completed) {
        emit(state.copyWith(
          status: AudioStatus.idle,
          position: Duration.zero,
        ));
      }
    });
  }

  Future<void> play(String url) async {
    try {
      if (state.currentUrl == url && state.status == AudioStatus.paused) {
        await _player.resume();
        emit(state.copyWith(status: AudioStatus.playing));
        return;
      }

      emit(state.copyWith(status: AudioStatus.loading, currentUrl: url));
      await _player.play(UrlSource(url));
      emit(state.copyWith(status: AudioStatus.playing));
    } catch (e) {
      emit(state.copyWith(
        status: AudioStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> pause() async {
    await _player.pause();
    emit(state.copyWith(status: AudioStatus.paused));
  }

  Future<void> stop() async {
    await _player.stop();
    emit(state.copyWith(
      status: AudioStatus.idle,
      currentUrl: null,
      position: Duration.zero,
    ));
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/surah_detail_bloc.dart';
import '../../cubit/audio_player_cubit.dart';
import '../../cubit/bookmark_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../domain/entities/surah_detail_entity.dart';

class QuranSurahDetailPage extends StatefulWidget {
  final int surahNumber;
  final int? initialAyah;

  const QuranSurahDetailPage({
    super.key,
    required this.surahNumber,
    this.initialAyah,
  });

  @override
  State<QuranSurahDetailPage> createState() => _QuranSurahDetailPageState();
}

class _QuranSurahDetailPageState extends State<QuranSurahDetailPage> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();
  bool _hasScrolledToInitial = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToAyah(int ayahNumber, [List<dynamic>? ayahs]) {
    if (_itemScrollController.isAttached) {
      int index = ayahNumber;
      if (ayahs != null) {
        final ayahIndex = ayahs.indexWhere((a) => a.ayahNumber == ayahNumber);
        if (ayahIndex != -1) {
          index = ayahIndex + 1; // +1 because index 0 is Surah Header
        }
      }
      _itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.1, // Aligns to the top
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.lightGrey;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<SurahDetailBloc>()..add(FetchSurahDetail(widget.surahNumber)),
        ),
        BlocProvider(create: (context) => AudioPlayerCubit()),
      ],
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () => context.pop(),
          ),
          title: BlocBuilder<SurahDetailBloc, SurahDetailState>(
            builder: (context, state) {
              if (state is SurahDetailLoaded) {
                return Column(
                  children: [
                    Text(
                      state.surahDetail.nameLatin,
                      style: AppTypography.textTheme.titleLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${state.surahDetail.revelation} • ${state.surahDetail.numberOfAyahs} Ayat',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: subTextColor,
                      ),
                    ),
                  ],
                );
              }
              return Text(
                'Surah ${widget.surahNumber}',
                style: AppTypography.textTheme.titleLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: textColor),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<SurahDetailBloc, SurahDetailState>(
          builder: (context, state) {
            if (state is SurahDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state is SurahDetailError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(
                        'Gagal Memuat Surah',
                        style: AppTypography.textTheme.titleLarge?.copyWith(
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: subTextColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => context.read<SurahDetailBloc>().add(
                          FetchSurahDetail(widget.surahNumber),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Coba Lagi',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SurahDetailLoaded) {
              final surah = state.surahDetail;

              // Handle initial auto-scroll when page loads
              if (widget.initialAyah != null && !_hasScrolledToInitial) {
                _hasScrolledToInitial = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(const Duration(milliseconds: 300), () {
                    if (mounted) {
                      _scrollToAyah(widget.initialAyah!, surah.ayahs);
                    }
                  });
                });
              }

              return Stack(
                children: [
                  // Ayah list (full height)
                  BlocListener<AudioPlayerCubit, AudioPlayerState>(
                    listenWhen: (prev, curr) =>
                        prev.activeAyahNumber != curr.activeAyahNumber &&
                        curr.isFullSurahMode &&
                        curr.activeAyahNumber != null,
                    listener: (context, audioState) {
                      _scrollToAyah(audioState.activeAyahNumber!, surah.ayahs);

                      // Auto-save bookmark when playing continuously
                      context.read<BookmarkCubit>().saveBookmark(
                        surahNumber: surah.number,
                        ayahNumber: audioState.activeAyahNumber!,
                        surahName: surah.nameLatin,
                      );
                    },
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _itemScrollController,
                      itemPositionsListener: _itemPositionsListener,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 80,
                      ),
                      itemCount: surah.ayahs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return _buildSurahHeader(context, surah);
                        }
                        final ayah = surah.ayahs[index - 1];

                        return _buildAyahCard(
                          context,
                          surah.nameLatin,
                          ayah,
                          textColor,
                          subTextColor,
                          cardBg,
                        );
                      },
                    ),
                  ),
                  // Audio player bar overlay at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _buildAudioPlayerBar(),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<SurahDetailBloc, SurahDetailState>(
          builder: (context, state) {
            if (state is SurahDetailLoaded) {
              return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                builder: (context, audioState) {
                  // Hide FAB when audio is active (playing or paused etc.)
                  if (audioState.status != AudioStatus.idle) {
                    return const SizedBox.shrink();
                  }

                  final surah = state.surahDetail;
                  return BlocBuilder<BookmarkCubit, BookmarkState>(
                    builder: (context, bookmarkState) {
                      int startIndex = 0;
                      if (bookmarkState.surahNumber == surah.number &&
                          bookmarkState.ayahNumber != null) {
                        startIndex = bookmarkState.ayahNumber! - 1;
                        if (startIndex < 0) startIndex = 0;
                      }

                      return FloatingActionButton.extended(
                        onPressed: () {
                          context.read<AudioPlayerCubit>().playFullSurah(
                            surahName: surah.nameLatin,
                            ayahs: surah.ayahs,
                            startFromIndex: startIndex,
                          );
                        },
                        icon: const Icon(Icons.play_arrow),
                        label: Text(
                          startIndex == 0
                              ? 'Play Full Surah'
                              : 'Lanjut Ayat ${startIndex + 1}',
                        ),
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildAudioPlayerBar() {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, audioState) {
        if (audioState.status == AudioStatus.idle) {
          return const SizedBox.shrink();
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final barBg = isDark ? AppColors.darkSurface : AppColors.primary;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: barBg,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                // Play/Pause button
                if (audioState.status == AudioStatus.loading)
                  const SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                else
                  IconButton(
                    icon: Icon(
                      audioState.status == AudioStatus.playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: AppColors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      final cubit = context.read<AudioPlayerCubit>();
                      if (audioState.status == AudioStatus.playing) {
                        cubit.pause();
                      } else {
                        cubit.resume();
                      }
                    },
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                const SizedBox(width: 12),
                // Label + progress
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        audioState.playingLabel,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: audioState.duration.inMilliseconds > 0
                            ? audioState.position.inMilliseconds /
                                audioState.duration.inMilliseconds
                            : 0,
                        backgroundColor: AppColors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                        minHeight: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Duration
                Text(
                  _formatDuration(audioState.position),
                  style: const TextStyle(color: AppColors.white, fontSize: 11),
                ),
                const SizedBox(width: 8),
                // Stop
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 20,
                  ),
                  onPressed: () => context.read<AudioPlayerCubit>().stop(),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _buildSurahHeader(BuildContext context, SurahDetailEntity surah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            surah.translation,
            style: AppTypography.textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${surah.revelation} • ${surah.numberOfAyahs} Ayat',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          // Play full surah (sequential ayahs)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                builder: (context, audioState) {
                  final isPlaying =
                      audioState.isFullSurahMode &&
                      audioState.status == AudioStatus.playing;
                  return GestureDetector(
                    onTap: () {
                      final cubit = context.read<AudioPlayerCubit>();
                      if (isPlaying) {
                        cubit.pause();
                      } else if (audioState.isFullSurahMode &&
                          audioState.status == AudioStatus.paused) {
                        cubit.resume();
                      } else {
                        cubit.playFullSurah(
                          surahName: surah.nameLatin,
                          ayahs: surah.ayahs,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: AppColors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isPlaying ? 'Pause' : 'Play Full Surah',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Toggle row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildToggleChip(Icons.text_fields, 'Size'),
                _buildToggleChip(Icons.translate, 'Terjemah', selected: true),
                _buildToggleChip(Icons.abc, 'Latin'),
                _buildToggleChip(Icons.menu_book_outlined, 'Tafsir'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleChip(
    IconData icon,
    String label, {
    bool selected = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Column(
        children: [
          Icon(
            icon,
            size: 18,
            color: selected
                ? AppColors.secondary
                : AppColors.white.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selected
                  ? AppColors.secondary
                  : AppColors.white.withValues(alpha: 0.6),
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAyahCard(
    BuildContext context,
    String surahName,
    AyahEntity ayah,
    Color textColor,
    Color subTextColor,
    Color cardBg,
  ) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      buildWhen: (prev, curr) =>
          prev.activeAyahNumber != curr.activeAyahNumber ||
          prev.isFullSurahMode != curr.isFullSurahMode ||
          prev.status != curr.status ||
          prev.currentUrl != curr.currentUrl,
      builder: (context, audioState) {
        final isActiveAyah =
            audioState.activeAyahNumber == ayah.ayahNumber &&
            (audioState.status == AudioStatus.playing ||
                audioState.status == AudioStatus.loading ||
                audioState.status == AudioStatus.paused);

        final isFullMode = audioState.isFullSurahMode;
        final isGrayed =
            isFullMode &&
            audioState.status != AudioStatus.idle &&
            !isActiveAyah;

        // Colors based on active/inactive state
        final arabColor = isActiveAyah
            ? AppColors.primary
            : isGrayed
            ? textColor.withValues(alpha: 0.3)
            : textColor;
        final translationColor = isActiveAyah
            ? subTextColor
            : isGrayed
            ? subTextColor.withValues(alpha: 0.3)
            : subTextColor;
        final ayahCardBg = isActiveAyah
            ? AppColors.primary.withValues(alpha: 0.08)
            : cardBg;
        final borderColor = isActiveAyah
            ? AppColors.primary.withValues(alpha: 0.3)
            : null;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ayahCardBg,
            borderRadius: BorderRadius.circular(12),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Arabic text
              Text(
                ayah.arab,
                textAlign: TextAlign.right,
                style: AppTypography.arabicFont.copyWith(
                  color: arabColor,
                  fontSize: 26,
                  height: 2.0,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),
              // Translation
              Text(
                ayah.translation,
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  color: translationColor,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              // Bottom action row
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActiveAyah
                          ? AppColors.primary.withValues(alpha: 0.2)
                          : AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        ayah.ayahNumber.toString(),
                        style: TextStyle(
                          color: isActiveAyah
                              ? AppColors.primary
                              : AppColors.primary.withValues(
                                  alpha: isGrayed ? 0.3 : 1.0,
                                ),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<BookmarkCubit, BookmarkState>(
                    builder: (context, bmState) {
                      final isBookmarked =
                          bmState.surahNumber == ayah.surahNumber &&
                          bmState.ayahNumber == ayah.ayahNumber;
                      return IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked
                              ? AppColors.secondary
                              : isGrayed
                              ? subTextColor.withValues(alpha: 0.2)
                              : subTextColor,
                          size: 20,
                        ),
                        onPressed: () {
                          context.read<BookmarkCubit>().saveBookmark(
                            surahNumber: ayah.surahNumber,
                            ayahNumber: ayah.ayahNumber,
                            surahName: surahName,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '🔖 Bookmark: $surahName Ayat ${ayah.ayahNumber}',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: isGrayed
                          ? subTextColor.withValues(alpha: 0.2)
                          : subTextColor,
                      size: 20,
                    ),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  // Per-ayah play button
                  Builder(
                    builder: (context) {
                      final audioUrl = ayah.audioUrl;
                      if (audioUrl == null || audioUrl.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final isPlayingThis =
                          audioState.currentUrl == audioUrl &&
                          audioState.status == AudioStatus.playing;
                      final isLoadingThis =
                          audioState.currentUrl == audioUrl &&
                          audioState.status == AudioStatus.loading;

                      return IconButton(
                        icon: isLoadingThis
                            ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: isGrayed
                                      ? subTextColor.withValues(alpha: 0.2)
                                      : subTextColor,
                                ),
                              )
                            : Icon(
                                isPlayingThis
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_outline,
                                color: isPlayingThis
                                    ? AppColors.primary
                                    : isGrayed
                                    ? subTextColor.withValues(alpha: 0.2)
                                    : subTextColor,
                                size: 22,
                              ),
                        onPressed: () {
                          final cubit = context.read<AudioPlayerCubit>();
                          if (isPlayingThis) {
                            cubit.pause();
                          } else {
                            cubit.playAyah(
                              url: audioUrl,
                              surahName: surahName,
                              ayahNumber: ayah.ayahNumber,
                            );
                          }
                        },
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

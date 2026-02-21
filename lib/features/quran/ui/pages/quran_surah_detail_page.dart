import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/surah_detail_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/surah_detail_entity.dart';

class QuranSurahDetailPage extends StatelessWidget {
  final int surahNumber;

  const QuranSurahDetailPage({
    super.key,
    required this.surahNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.lightGrey;

    return BlocProvider(
      create: (context) => sl<SurahDetailBloc>()..add(FetchSurahDetail(surahNumber)),
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
                      'Juz 1 • Page 1',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: subTextColor,
                      ),
                    ),
                  ],
                );
              }
              return Text(
                'Surah $surahNumber',
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
                        onPressed: () {
                          context.read<SurahDetailBloc>().add(
                            FetchSurahDetail(surahNumber),
                          );
                        },
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
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: surah.ayahs.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildSurahHeader(surah);
                  }
                  final ayah = surah.ayahs[index - 1];
                  return _buildAyahCard(ayah, textColor, subTextColor, cardBg);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSurahHeader(SurahDetailEntity surah) {
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
            '${surah.revelation} • ${surah.numberOfAyahs} Ayahs',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          // Play Audio & Download buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionButton(Icons.play_arrow, 'Play Audio', filled: true),
              const SizedBox(width: 12),
              _buildActionButton(
                Icons.download_outlined,
                'Download',
                filled: false,
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
                _buildToggleChip(Icons.translate, 'English', selected: true),
                _buildToggleChip(Icons.abc, 'Latin'),
                _buildToggleChip(Icons.menu_book_outlined, 'Tafsir'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    required bool filled,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: filled
            ? AppColors.white.withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
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
    AyahEntity ayah,
    Color textColor,
    Color subTextColor,
    Color cardBg,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Arabic text
          Text(
            ayah.arab,
            textAlign: TextAlign.right,
            style: AppTypography.arabicFont.copyWith(
              color: textColor,
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
              color: subTextColor,
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
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    ayah.ayahNumber.toString(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.bookmark_border,
                  color: subTextColor,
                  size: 20,
                ),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              IconButton(
                icon: Icon(Icons.share_outlined, color: subTextColor, size: 20),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_circle_outline,
                  color: subTextColor,
                  size: 20,
                ),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

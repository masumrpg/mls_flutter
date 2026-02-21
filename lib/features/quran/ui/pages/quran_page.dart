import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/quran_bloc.dart';
import '../../cubit/bookmark_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;
    final cardBg = isDark ? AppColors.darkSurface : AppColors.white;

    return BlocProvider(
      create: (context) => sl<QuranBloc>()..add(FetchSurahs()),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leadingWidth: 48,
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.menu, color: textColor),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              },
            ),
          ),
          title: Text(
            'Al-Quran',
            style: AppTypography.textTheme.titleLarge?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (ctx) => IconButton(
                icon: Icon(Icons.refresh, color: textColor),
                tooltip: 'Refresh dari server',
                onPressed: () {
                  ctx.read<QuranBloc>().add(RefreshSurahs());
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    const SnackBar(
                      content: Text('Memperbarui data dari server...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: textColor),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<QuranBloc, QuranState>(
          builder: (context, state) {
            if (state is QuranLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (state is QuranError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
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
                          context.read<QuranBloc>().add(FetchSurahs());
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
            } else if (state is QuranLoaded) {
              return RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  context.read<QuranBloc>().add(RefreshSurahs());
                  // Wait slightly to let the bloc process it before dismissing the spinner
                  await Future.delayed(const Duration(milliseconds: 1500));
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildGreetingAndLastRead(
                        context,
                        textColor,
                        subTextColor,
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildTabBar(subTextColor)),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final surah = state.surahs[index];
                        return _buildSurahTile(
                          context,
                          surah,
                          textColor,
                          subTextColor,
                          cardBg,
                        );
                      }, childCount: state.surahs.length),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildGreetingAndLastRead(
    BuildContext context,
    Color textColor,
    Color subTextColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assalamu alaikum,',
            style: AppTypography.textTheme.bodyLarge?.copyWith(
              color: subTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Ahmad',
            style: AppTypography.textTheme.headlineMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<BookmarkCubit, BookmarkState>(
            builder: (context, bookmarkState) {
              return GestureDetector(
                onTap: bookmarkState.hasBookmark
                    ? () => context.push(
                        '/quran/detail/${bookmarkState.surahNumber}?ayah=${bookmarkState.ayahNumber}',
                      )
                    : null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withValues(alpha: 0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark,
                            color: AppColors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'TERAKHIR DIBACA',
                            style: AppTypography.textTheme.labelMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.2,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (bookmarkState.hasBookmark) ...[
                        Text(
                          bookmarkState.surahName ?? '',
                          style: AppTypography.textTheme.headlineSmall
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ayat ${bookmarkState.ayahNumber}',
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Lanjut Membaca →',
                            style: AppTypography.textTheme.labelLarge?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Belum ada bookmark',
                          style: AppTypography.textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tandai ayat yang sedang dibaca\ndengan menekan ikon bookmark 🔖',
                          style: AppTypography.textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Row(
        children: [
          _buildTab('Surah', subTextColor, selected: true),
          _buildTab('Juz', subTextColor),
          _buildTab('Bookmark', subTextColor),
        ],
      ),
    );
  }

  Widget _buildTab(String label, Color subTextColor, {bool selected = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.secondary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTypography.textTheme.titleSmall?.copyWith(
            color: selected ? AppColors.secondary : subTextColor,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSurahTile(
    BuildContext context,
    dynamic surah,
    Color textColor,
    Color subTextColor,
    Color cardBg,
  ) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          'surah_detail',
          pathParameters: {'id': surah.number.toString()},
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: subTextColor.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  surah.number.toString(),
                  style: AppTypography.textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameLatin,
                    style: AppTypography.textTheme.titleMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${surah.revelation.toUpperCase()} • ${surah.numberOfAyahs} Verses',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              surah.name,
              style: AppTypography.arabicFont.copyWith(
                color: AppColors.primary,
                fontSize: 22,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

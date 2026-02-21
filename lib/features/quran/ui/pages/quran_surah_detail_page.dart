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
    return BlocProvider(
      create: (context) => sl<SurahDetailBloc>()..add(FetchSurahDetail(surahNumber)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => context.pop(),
          ),
          title: BlocBuilder<SurahDetailBloc, SurahDetailState>(
            builder: (context, state) {
              if (state is SurahDetailLoaded) {
                return Text(
                  state.surahDetail.nameLatin,
                  style: AppTypography.textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return Text(
                'Surah $surahNumber',
                style: AppTypography.textTheme.headlineMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          elevation: 0,
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
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        state.message,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SurahDetailBloc>().add(FetchSurahDetail(surahNumber));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is SurahDetailLoaded) {
              final surah = state.surahDetail;
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: surah.ayahs.length + 1, // +1 for the header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildSurahHeader(surah);
                  }

                  final ayah = surah.ayahs[index - 1];
                  return Card(
                    color: AppColors.white,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.lightGrey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    ayah.ayahNumber.toString(),
                                    style: AppTypography.textTheme.titleMedium
                                        ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Optional: Add play audio button here
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            ayah.arab,
                            textAlign: TextAlign.right,
                            style: AppTypography.arabicFont.copyWith(
                              color: AppColors.primary,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            ayah.translation,
                            style: AppTypography.textTheme.bodyLarge?.copyWith(
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
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
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            surah.nameLatin,
            style: AppTypography.textTheme.headlineLarge?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            surah.translation,
            style: AppTypography.textTheme.titleMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white30),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${surah.revelation} • ${surah.numberOfAyahs} Ayat',
                style: AppTypography.textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/hadis_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class HadisHadisHomePage extends StatelessWidget {
  const HadisHadisHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HadisBloc>()..add(const FetchHadisExplore(page: 1)),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'Kumpulan Hadis',
            style: AppTypography.textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
        body: SafeArea(
          child: BlocBuilder<HadisBloc, HadisState>(
            builder: (context, state) {
              if (state is HadisLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is HadisError) {
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
                          'Gagal Memuat Hadis',
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
                            context.read<HadisBloc>().add(const FetchHadisExplore(page: 1));
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
              } else if (state is HadisLoaded) {
                final hadisList = state.exploreData.hadis;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: hadisList.length,
                  itemBuilder: (context, index) {
                    final hadis = hadisList[index];
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    '${hadis.id}',
                                    style: AppTypography.textTheme.titleSmall
                                        ?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (hadis.grade != null && hadis.grade!.isNotEmpty)
                                  Text(
                                    hadis.grade!,
                                    style: AppTypography.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              hadis.text.ar,
                              textAlign: TextAlign.right,
                              style: AppTypography.arabicFont.copyWith(
                                color: AppColors.primary,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              hadis.text.id,
                              style: AppTypography.textTheme.bodyLarge?.copyWith(
                                color: AppColors.black,
                                height: 1.5,
                              ),
                            ),
                            if (hadis.takhrij != null && hadis.takhrij!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  'Takhrij: ${hadis.takhrij}',
                                  style: AppTypography.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: AppColors.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
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
      ),
    );
  }
}

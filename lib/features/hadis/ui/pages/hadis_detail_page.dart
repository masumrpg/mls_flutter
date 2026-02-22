import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/hadis_detail_bloc.dart';
import 'package:flutter/services.dart';

class HadisDetailPage extends StatelessWidget {
  final int hadisId;

  const HadisDetailPage({
    super.key,
    required this.hadisId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HadisDetailBloc>()..add(LoadHadisDetail(hadisId)),
      child: const _HadisDetailPageContent(),
    );
  }
}

class _HadisDetailPageContent extends StatelessWidget {
  const _HadisDetailPageContent();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Hadis'),
      ),
      body: BlocBuilder<HadisDetailBloc, HadisDetailState>(
        builder: (context, state) {
          if (state is HadisDetailLoading || state is HadisDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HadisDetailError) {
            return Center(child: Text(state.message, style: const TextStyle(color: AppColors.error)));
          } else if (state is HadisDetailLoaded) {
            final hadis = state.hadis;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Hadis No. ${hadis.id}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.copy, color: textSecondary, size: 20),
                                  onPressed: () {
                                    final copyText = '${hadis.textAr}\n\n${hadis.textId}';
                                    Clipboard.setData(ClipboardData(text: copyText));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Teks disalin')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Arabic Text
                        Text(
                          hadis.textAr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'LPMQ', // Same font as Quran
                            fontSize: 26,
                            height: 2.0,
                            color: AppColors.secondary,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),
                        // Indonesian Translation
                        Text(
                          'Terjemahan',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hadis.textId,
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            height: 1.6,
                          ),
                        ),

                        // Grade/Status
                        if (hadis.grade != null && hadis.grade!.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Status Hadis',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              hadis.grade!,
                              style: const TextStyle(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],

                        // Takhrij
                        if (hadis.takhrij != null && hadis.takhrij!.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Takhrij',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hadis.takhrij!,
                            style: TextStyle(
                              fontSize: 15,
                              color: textColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],

                        // Hikmah / Explanation
                        if (hadis.hikmah != null && hadis.hikmah!.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          Text(
                            'Hikmah Kandungan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.darkBackground : AppColors.lightGrey.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDark ? AppColors.darkCard : AppColors.lightGrey,
                              ),
                            ),
                            child: Text(
                              hadis.hikmah!,
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

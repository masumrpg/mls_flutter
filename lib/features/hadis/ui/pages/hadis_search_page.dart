import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/route_names.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/hadis_search_bloc.dart';
import '../../data/models/hadis_model.dart';
import '../../../../shared/widgets/error_view.dart';

class HadisSearchPage extends StatelessWidget {
  const HadisSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HadisSearchBloc>(),
      child: const _HadisSearchPageContent(),
    );
  }
}

class _HadisSearchPageContent extends StatefulWidget {
  const _HadisSearchPageContent();

  @override
  State<_HadisSearchPageContent> createState() => _HadisSearchPageContentState();
}

class _HadisSearchPageContentState extends State<_HadisSearchPageContent> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  Timer? _debouncer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HadisSearchBloc>().add(LoadNextHadisSearch());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  void _onSearchChanged(String query) {
    if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    _debouncer = Timer(const Duration(milliseconds: 500), () {
      context.read<HadisSearchBloc>().add(LoadHadisSearch(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Cari Hadis...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: isDark ? AppColors.darkTextSecondary : AppColors.grey.withValues(alpha: 0.7)),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<HadisSearchBloc>().add(const LoadHadisSearch(''));
              },
            ),
          ),
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: BlocBuilder<HadisSearchBloc, HadisSearchState>(
        builder: (context, state) {
          if (state is HadisSearchInitial) {
            return _buildEmptyState(isDark);
          } else if (state is HadisSearchLoading && state is! HadisSearchLoaded) {
            return _buildSkeletonLoader();
          } else if (state is HadisSearchError && state is! HadisSearchLoaded) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<HadisSearchBloc>().add(LoadHadisSearch(_searchController.text));
              },
            );
          } else if (state is HadisSearchLoaded) {
            final hadisList = state.hadis;
            if (hadisList.isEmpty) {
              return Center(child: Text("Tidak ada hasil untuk '${state.query}'"));
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.hasReachedMax ? hadisList.length : hadisList.length + 1,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index >= hadisList.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }
                return _buildHadisCard(hadisList[index], state.query, surfaceColor, textColor, textSecondary);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: isDark ? AppColors.darkTextSecondary.withValues(alpha: 0.5) : AppColors.grey.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Ketik minimal 4 huruf untuk mencari hadis',
            style: TextStyle(
              color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query, Color textColor) {
    if (query.isEmpty) {
      return Text(
        text,
        style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
    }

    final regex = RegExp(query, caseSensitive: false);
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return Text(
        text,
        style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      );
    }

    List<TextSpan> spans = [];
    int start = 0;

    for (final match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          backgroundColor: AppColors.primary.withValues(alpha: 0.2),
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ));
      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
        children: spans,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHadisCard(HadisModel hadis, String query, Color surfaceColor, Color textColor, Color textSecondary) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No. ${hadis.id}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (hadis.grade != null && hadis.grade!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    hadis.grade!,
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          if (hadis.textAr.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              hadis.textAr,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'LPMQ',
                fontSize: 22,
                height: 1.8,
                color: AppColors.secondary,
              ),
              textDirection: TextDirection.rtl,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 12),
          _buildHighlightedText(hadis.textId, query, textColor),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.push('${RouteNames.hadisDetail}/${hadis.id}');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Read Full', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkSurface
                : AppColors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 50, height: 16, color: Colors.grey.withValues(alpha: 0.2)),
                  Container(width: 40, height: 20, decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8))),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Container(width: 200, height: 20, color: Colors.grey.withValues(alpha: 0.2)),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Container(width: 150, height: 20, color: Colors.grey.withValues(alpha: 0.2)),
              ),
              const SizedBox(height: 16),
              Container(width: double.infinity, height: 14, color: Colors.grey.withValues(alpha: 0.2)),
              const SizedBox(height: 4),
              Container(width: double.infinity, height: 14, color: Colors.grey.withValues(alpha: 0.2)),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/route_names.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/hadis_explore_bloc.dart';
import '../../data/models/hadis_model.dart';

class HadisPage extends StatelessWidget {
  const HadisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<HadisExploreBloc>()..add(const LoadHadisExplore()),
      child: const _HadisPageContent(),
    );
  }
}

class _HadisPageContent extends StatefulWidget {
  const _HadisPageContent();

  @override
  State<_HadisPageContent> createState() => _HadisPageContentState();
}

class _HadisPageContentState extends State<_HadisPageContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HadisExploreBloc>().add(LoadNextHadisExplore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.white;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadis'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push(RouteNames.hadisSearch);
            },
          ),
        ],
      ),
      body: BlocBuilder<HadisExploreBloc, HadisExploreState>(
        builder: (context, state) {
          if (state is HadisExploreInitial ||
              (state is HadisExploreLoading && state is! HadisExploreLoaded)) {
            return _buildSkeletonLoader();
          } else if (state is HadisExploreError &&
              state is! HadisExploreLoaded) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: AppColors.error),
              ),
            );
          } else if (state is HadisExploreLoaded) {
            final hadisList = state.hadis;
            if (hadisList.isEmpty) {
              return const Center(child: Text('No Hadis available'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<HadisExploreBloc>().add(
                  const LoadHadisExplore(isRefresh: true),
                );
              },
              color: AppColors.primary,
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: state.hasReachedMax
                    ? hadisList.length
                    : hadisList.length + 1,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index >= hadisList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return _buildHadisCard(
                    hadisList[index],
                    surfaceColor,
                    textColor,
                    textSecondary,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHadisCard(
    HadisModel hadis,
    Color surfaceColor,
    Color textColor,
    Color textSecondary,
  ) {
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
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (hadis.grade != null && hadis.grade!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    hadis.grade!,
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
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
          const SizedBox(height: 12),
          Text(
            hadis.textId,
            style: TextStyle(fontSize: 14, color: textColor, height: 1.5),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.push('${RouteNames.hadisDetail}/${hadis.id}');
              },
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Read Full',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                  Container(
                    width: 50,
                    height: 16,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                  Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 150,
                  height: 20,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                height: 14,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              const SizedBox(height: 4),
              Container(
                width: 100,
                height: 14,
                color: Colors.grey.withValues(alpha: 0.2),
              ),
            ],
          ),
        );
      },
    );
  }
}

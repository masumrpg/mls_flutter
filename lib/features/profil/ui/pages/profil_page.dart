import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_header.dart';
import '../../../../core/di/service_locator.dart';
import '../../bloc/profil_bloc.dart';
import '../../bloc/profil_event.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool get _isDark => Theme.of(context).brightness == Brightness.dark;
  Color get _textColor => _isDark ? AppColors.darkText : AppColors.black;
  Color get _subTextColor =>
      _isDark ? AppColors.darkTextSecondary : AppColors.grey;
  Color get _cardBg => _isDark ? AppColors.darkSurface : AppColors.white;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTopProfile() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?u=masum',
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Ma\'sum',
          style: AppTypography.textTheme.headlineMedium?.copyWith(
            color: _textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'masum@example.com',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: _subTextColor,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildReadingProgress() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _subTextColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reading Progress',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.menu_book, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 32),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: 0.45,
                    strokeWidth: 12,
                    backgroundColor: Colors.indigo.shade800,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '45%',
                      style: AppTypography.textTheme.headlineLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Completed',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: _subTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Juz 14 of 30',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: _subTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyActivity() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _subTextColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weekly Activity',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, color: AppColors.primary, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '+12%',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total 4.5 hours this week',
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: _subTextColor,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayLabel('MON', false),
              _buildDayLabel('TUE', false),
              _buildDayLabel('WED', false),
              _buildDayLabel('THU', false),
              _buildDayLabel('FRI', true),
              _buildDayLabel('SAT', false),
              _buildDayLabel('SUN', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabel(String day, bool isHighlighted) {
    return Text(
      day,
      style: TextStyle(
        color: isHighlighted
            ? AppColors.primary
            : _subTextColor.withValues(alpha: 0.5),
        fontSize: 10,
        fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(Icons.menu_book, 'Total Verses', '135', ''),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            Icons.access_time_filled,
            'Daily Avg',
            '19',
            'verses',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String title,
    String value,
    String unit,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _subTextColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: _subTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.textTheme.headlineMedium?.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    unit,
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: _subTextColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Achievements',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                color: _textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildAchievementBadge(
                Icons.star,
                'First Juz',
                'Completed',
                true,
                AppColors.primary,
              ),
              const SizedBox(width: 16),
              _buildAchievementBadge(
                Icons.local_fire_department,
                '7 Day Streak',
                'Active',
                true,
                Colors.deepOrange,
              ),
              const SizedBox(width: 16),
              _buildAchievementBadge(
                Icons.lock,
                'Surah Yasin',
                'Locked',
                false,
                _subTextColor.withValues(alpha: 0.2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(
    IconData icon,
    String title,
    String subtitle,
    bool isUnlocked,
    Color color,
  ) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _subTextColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUnlocked
                  ? color.withValues(alpha: 0.15)
                  : _subTextColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isUnlocked ? color : _subTextColor.withValues(alpha: 0.5),
              size: 28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: AppTypography.textTheme.titleSmall?.copyWith(
              color: isUnlocked
                  ? _textColor
                  : _subTextColor.withValues(alpha: 0.5),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: _subTextColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfilBloc>()..add(const FetchProfilStats()),
      child: AppScaffold(
        header: AppHeader.classic(
          title: 'My Profile',
          onMenuPressed: () => Scaffold.of(context).openDrawer(),
          actions: [
            IconButton(
              icon: Icon(Icons.settings_outlined, color: _textColor),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            children: [
              _buildTopProfile(),
              _buildReadingProgress(),
              const SizedBox(height: 16),
              _buildWeeklyActivity(),
              const SizedBox(height: 16),
              _buildStatsRow(),
              const SizedBox(height: 32),
              _buildAchievements(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

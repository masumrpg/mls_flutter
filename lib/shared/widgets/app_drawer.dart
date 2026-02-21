import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_cubit.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Adapt background to theme but keep premium feel in dark mode using existing AppColors
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : (theme.drawerTheme.backgroundColor ?? theme.scaffoldBackgroundColor);

    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white.withValues(alpha: 0.5) : Colors.black54;
    final accentColor = isDark ? const Color(0xFF2DD4BF) : theme.primaryColor;

    return Drawer(
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          _buildHeader(context, backgroundColor, textColor, subTextColor, accentColor),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildSectionTitle('CORE FEATURES', subTextColor),
                  _buildDrawerItem(
                    index: 0,
                    icon: Icons.menu_book,
                    label: 'Al-Quran',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 1,
                    icon: Icons.access_time_filled,
                    label: 'Prayer Times',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 2,
                    icon: Icons.library_books,
                    label: 'Hadith',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 3,
                    icon: Icons.calendar_month,
                    label: 'Islamic Calendar',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 10, // Not in main bottom nav
                    icon: Icons.explore,
                    label: 'Qibla Finder',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),

                  const SizedBox(height: 24),
                  _buildSectionTitle('MY ACTIVITIES', subTextColor),
                  _buildDrawerItem(
                    index: 11,
                    icon: Icons.bar_chart,
                    label: 'My Statistics',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 12,
                    icon: Icons.bookmark,
                    label: 'Bookmarks',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 13,
                    icon: Icons.download_rounded,
                    label: 'Downloads',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),

                  Divider(color: textColor.withValues(alpha: 0.1), height: 32),

                  _buildDrawerItem(
                    index: 14,
                    icon: Icons.settings,
                    label: 'Settings',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 15,
                    icon: Icons.info_outline,
                    label: 'About MyQuran',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),
                  _buildDrawerItem(
                    index: 16,
                    icon: Icons.star_border,
                    label: 'Rate App',
                    textColor: textColor,
                    accentColor: accentColor,
                  ),

                  // Dark Mode Toggle integrated here
                  const SizedBox(height: 8),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        leading: Icon(
                          themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                          color: textColor.withValues(alpha: 0.7),
                          size: 22,
                        ),
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 15),
                        ),
                        trailing: Switch(
                          value: themeMode == ThemeMode.dark,
                          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                          activeThumbColor: accentColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildLogoutButton(context, textColor),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    Color backgroundColor,
    Color textColor,
    Color subTextColor,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: textColor.withValues(alpha: 0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?u=ahmad'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: backgroundColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ahmad Zulfikar',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ahmad.zulfikar@email.com',
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color subTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: subTextColor.withValues(alpha: 0.6),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String label,
    required Color textColor,
    required Color accentColor,
  }) {
    final isSelected = currentIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isSelected ? textColor.withValues(alpha: 0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () => onItemSelected(index),
        leading: Icon(
          icon,
          color: isSelected ? accentColor : textColor.withValues(alpha: 0.7),
          size: 22,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? accentColor : textColor.withValues(alpha: 0.7),
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        dense: true,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 16),
      child: Container(
        decoration: BoxDecoration(
          color: textColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          onTap: () {
            // Logout logic
          },
          leading: const Icon(Icons.logout, color: Color(0xFFFF5252), size: 22),
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Color(0xFFFF5252),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

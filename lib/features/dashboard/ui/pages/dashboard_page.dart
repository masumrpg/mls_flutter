import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../quran/ui/pages/quran_page.dart';
import '../../../sholat/ui/pages/sholat_sholat_home_page.dart';
import '../../../hadis/ui/pages/hadis_hadis_home_page.dart';
import '../../../kalender/ui/pages/kalender_page.dart';
import '../../../profil/ui/pages/profil_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    QuranPage(),
    SholatSholatHomePage(),
    HadisHadisHomePage(),
    KalenderPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: const ValueKey('dashboard_scaffold'),
      drawer: _buildDrawer(context, isDark),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: theme.navigationBarTheme.backgroundColor,
        indicatorColor: theme.navigationBarTheme.indicatorColor,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Quran',
          ),
          NavigationDestination(
            icon: Icon(Icons.access_time_outlined),
            selectedIcon: Icon(Icons.access_time_filled),
            label: 'Sholat',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            selectedIcon: Icon(Icons.library_books),
            label: 'Hadis',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Kalender',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isDark) {
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Moslem Life Style',
                    style: AppTypography.textTheme.titleLarge?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Assalamu alaikum',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Navigation Items
            _buildDrawerItem(Icons.menu_book, 'Al-Quran', textColor, 0),
            _buildDrawerItem(Icons.access_time, 'Sholat', textColor, 1),
            _buildDrawerItem(Icons.library_books, 'Hadis', textColor, 2),
            _buildDrawerItem(Icons.calendar_month, 'Kalender', textColor, 3),
            _buildDrawerItem(Icons.person, 'Profil', textColor, 4),

            const Divider(),

            // Dark Mode Toggle
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return SwitchListTile(
                  secondary: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: AppColors.secondary,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: AppTypography.textTheme.titleSmall?.copyWith(
                      color: textColor,
                    ),
                  ),
                  subtitle: Text(
                    themeMode == ThemeMode.dark ? 'On' : 'Off',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: subTextColor,
                    ),
                  ),
                  value: themeMode == ThemeMode.dark,
                  activeThumbColor: AppColors.secondary,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),

            const Spacer(),

            // App version
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'v1.0.0',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: subTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String label,
    Color textColor,
    int index,
  ) {
    final isSelected = _currentIndex == index;
    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.primary : textColor),
      title: Text(
        label,
        style: AppTypography.textTheme.titleSmall?.copyWith(
          color: isSelected ? AppColors.primary : textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        Navigator.of(context).pop(); // Close drawer
      },
    );
  }
}

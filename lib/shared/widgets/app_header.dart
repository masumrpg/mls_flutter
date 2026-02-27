import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum AppHeaderVariant { greetings, classic, location }

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final AppHeaderVariant variant;
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onBackPressed;
  final Widget? locationContent;

  const AppHeader({
    super.key,
    required this.variant,
    this.title = '',
    this.subtitle,
    this.actions,
    this.onMenuPressed,
    this.onBackPressed,
    this.locationContent,
  });

  factory AppHeader.greetings({
    required String name,
    required String greeting,
    List<Widget>? actions,
    VoidCallback? onMenuPressed,
  }) {
    return AppHeader(
      variant: AppHeaderVariant.greetings,
      title: greeting,
      subtitle: name,
      actions: actions,
      onMenuPressed: onMenuPressed,
    );
  }

  factory AppHeader.classic({
    required String title,
    List<Widget>? actions,
    VoidCallback? onMenuPressed,
    VoidCallback? onBackPressed,
  }) {
    return AppHeader(
      variant: AppHeaderVariant.classic,
      title: title,
      actions: actions,
      onMenuPressed: onMenuPressed,
      onBackPressed: onBackPressed,
    );
  }

  factory AppHeader.location({
    required Widget locationWidget,
    List<Widget>? actions,
    VoidCallback? onMenuPressed,
  }) {
    return AppHeader(
      variant: AppHeaderVariant.location,
      locationContent: locationWidget,
      actions: actions,
      onMenuPressed: onMenuPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;

    if (variant == AppHeaderVariant.classic) {
      return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: onBackPressed != null
            ? IconButton(
                icon: Icon(Icons.chevron_left, color: textColor),
                onPressed: onBackPressed,
              )
            : onMenuPressed != null
                ? IconButton(
                    icon: Icon(Icons.menu, color: textColor),
                    onPressed: onMenuPressed,
                  )
                : null,
        title: Text(
          title,
          style: AppTypography.textTheme.titleLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actions,
      );
    }

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: _buildVariantContent(context, textColor, subTextColor),
      ),
    );
  }

  Widget _buildVariantContent(BuildContext context, Color textColor, Color subTextColor) {
    if (variant == AppHeaderVariant.greetings) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onMenuPressed != null) ...[
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.menu, color: textColor, size: 28),
              onPressed: onMenuPressed,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle ?? '',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=masum'),
          ),
        ],
      );
    }

    if (variant == AppHeaderVariant.location) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (onMenuPressed != null) ...[
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.topLeft,
              icon: Icon(Icons.menu, color: textColor, size: 28),
              onPressed: onMenuPressed,
            ),
            const SizedBox(width: 8),
          ],
          Expanded(child: locationContent ?? const SizedBox()),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=masum'),
          ),
        ],
      );
    }

    return const SizedBox();
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

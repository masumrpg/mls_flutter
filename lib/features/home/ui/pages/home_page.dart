import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Avatar
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/75865642?v=4',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Name
              Text(
                "Ma'sum",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '@masumrpg',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Fullstack Web & Mobile Developer',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Indonesia',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Stats row
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? theme.colorScheme.surface
                      : theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(label: 'Repos', value: '25'),
                    _StatItem(label: 'Followers', value: '7'),
                    _StatItem(label: 'Following', value: '17'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // About card
              _InfoCard(
                title: 'About',
                icon: Icons.person_outline,
                theme: theme,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _AboutItem(
                      icon: Icons.rocket_launch_outlined,
                      text: 'Becoming a Mobile Engineer',
                    ),
                    SizedBox(height: 8),
                    _AboutItem(
                      icon: Icons.code,
                      text: 'Ask me about React Native & Expo',
                    ),
                    SizedBox(height: 8),
                    _AboutItem(
                      icon: Icons.language,
                      text: 'masumdev.my.id',
                    ),
                    SizedBox(height: 8),
                    _AboutItem(
                      icon: Icons.email_outlined,
                      text: 'mclasix@gmail.com',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Skills card
              _InfoCard(
                title: 'Skills',
                icon: Icons.build_outlined,
                theme: theme,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    'Flutter',
                    'React Native',
                    'Expo',
                    'Dart',
                    'TypeScript',
                    'Kotlin',
                    'Rust',
                    'Go',
                    'Node.js',
                    'PostgreSQL',
                  ]
                      .map(
                        (skill) => Chip(
                          label: Text(skill),
                          backgroundColor:
                              theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
                          side: BorderSide.none,
                          padding: EdgeInsets.zero,
                          labelStyle: theme.textTheme.bodySmall,
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 32),
              // Footer
              Text(
                'Built with Flutter BLoC Generator \u2764\ufe0f',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ThemeData theme;
  final Widget child;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.theme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AboutItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

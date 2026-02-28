import 'package:flutter/material.dart';
import '../../../../routes/route_names.dart';
import 'package:go_router/go_router.dart';

class MenuSection extends StatelessWidget {
  final Color textColor;
  final Color cardBg;

  const MenuSection({
    super.key,
    required this.textColor,
    required this.cardBg,
  });

  @override
  Widget build(BuildContext context) {
    final menus = [
      {'title': 'Al-Qur\'an', 'icon': Icons.menu_book, 'route': RouteNames.quran},
      {
        'title': 'Hadis',
        'icon': Icons.library_books,
        'route': RouteNames.hadis,
      },
      {'title': 'Dzikir & Doa', 'icon': Icons.auto_stories, 'route': RouteNames.quran},
      {
        'title': 'Kalender Islam',
        'icon': Icons.calendar_month,
        'route': RouteNames.kalender,
      },
      {
        'title': 'Arah Kiblat',
        'icon': Icons.explore,
        'route': RouteNames.qibla,
      },
      {
        'title': 'Jadwal Sholat',
        'icon': Icons.access_time_filled,
        'route': RouteNames.sholat,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 20, color: Colors.orange),
              const SizedBox(width: 8),
              Text('Menu Utama', style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: menus.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.pushNamed(menus[index]['route'] as String);
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(menus[index]['icon'] as IconData, color: Colors.orange, size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      menus[index]['title'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textColor, fontSize: 12),
                      maxLines: 2,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PrayerNotificationBottomSheet extends StatefulWidget {
  final String prayerName;
  final int initialAlertType; // 0: Mute, 1: Notification, 2: Adhan
  final int initialPreReminder; // minutes
  final Function(int alertType, int preReminder) onSave;

  const PrayerNotificationBottomSheet({
    super.key,
    required this.prayerName,
    required this.initialAlertType,
    required this.initialPreReminder,
    required this.onSave,
  });

  @override
  State<PrayerNotificationBottomSheet> createState() => _PrayerNotificationBottomSheetState();
}

class _PrayerNotificationBottomSheetState extends State<PrayerNotificationBottomSheet> {
  late int _selectedAlertType;
  late int _selectedPreReminder;

  @override
  void initState() {
    super.initState();
    _selectedAlertType = widget.initialAlertType;
    _selectedPreReminder = widget.initialPreReminder;
  }

  Widget _buildAlertTypeOption(String title, IconData icon, int value) {
    final isSelected = _selectedAlertType == value;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        setState(() {
          _selectedAlertType = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF2DD4BF) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2DD4BF)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.darkBackground
                    : Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2DD4BF)
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2DD4BF),
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderChips() {
    final options = [0, 5, 10, 15, 20];
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: options.map((minutes) {
          final isSelected = _selectedPreReminder == minutes;
          final label = minutes == 0 ? 'Off' : '$minutes min';
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedPreReminder = minutes;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF2DD4BF).withOpacity(0.1)
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF2DD4BF)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? const Color(0xFF2DD4BF)
                        : Colors.white.withOpacity(0.5),
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF072A24), // Even deeper teal for modal
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.prayerName} Notification',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'ALERT TYPE',
            style: theme.textTheme.labelMedium?.copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          _buildAlertTypeOption('Mute', Icons.notifications_off_rounded, 0),
          const SizedBox(height: 12),
          _buildAlertTypeOption(
            'Notification Only',
            Icons.notifications_active_rounded,
            1,
          ),
          const SizedBox(height: 12),
          _buildAlertTypeOption('Adhan Sound', Icons.volume_up_rounded, 2),
          const SizedBox(height: 32),
          Text(
            'PRE-PRAYER REMINDER',
            style: theme.textTheme.labelMedium?.copyWith(
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          const SizedBox(height: 16),
          _buildReminderChips(),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                widget.onSave(_selectedAlertType, _selectedPreReminder);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2DD4BF),
                foregroundColor: AppColors.darkBackground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Save Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

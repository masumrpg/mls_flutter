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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : theme.dividerColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : theme.iconTheme.color,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : null,
                ),
              ),
            ),
            if (isSelected) ...[
              const Icon(Icons.check_circle, color: AppColors.primary),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildReminderChips() {
    final options = [0, 5, 10, 15, 20];
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      children: options.map((minutes) {
        final isSelected = _selectedPreReminder == minutes;
        final label = minutes == 0 ? 'Off' : '$minutes m';
        return ChoiceChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedPreReminder = minutes;
              });
            }
          },
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          backgroundColor: theme.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.primary : theme.dividerColor,
            ),
          ),
        );
      }).toList(),
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
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Pengaturan Notifikasi ${widget.prayerName}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Jenis Peringatan',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildAlertTypeOption('Suara Adzan', Icons.volume_up_rounded, 2),
          const SizedBox(height: 8),
          _buildAlertTypeOption('Notifikasi Saja', Icons.notifications_active_outlined, 1),
          const SizedBox(height: 8),
          _buildAlertTypeOption('Bisukan', Icons.notifications_off_outlined, 0),
          const SizedBox(height: 24),
          Text(
            'Pengingat Pra-waktu',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildReminderChips(),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                widget.onSave(_selectedAlertType, _selectedPreReminder);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

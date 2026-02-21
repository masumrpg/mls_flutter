import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../domain/entities/surah_detail_entity.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

class ShareAyahBottomSheet extends StatefulWidget {
  final AyahEntity ayah;
  final String surahName;

  const ShareAyahBottomSheet({
    super.key,
    required this.ayah,
    required this.surahName,
  });

  static Future<void> show(
    BuildContext context, {
    required AyahEntity ayah,
    required String surahName,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareAyahBottomSheet(
        ayah: ayah,
        surahName: surahName,
      ),
    );
  }

  @override
  State<ShareAyahBottomSheet> createState() => _ShareAyahBottomSheetState();
}

class _ShareAyahBottomSheetState extends State<ShareAyahBottomSheet> {
  final GlobalKey _cardKey = GlobalKey();
  bool _isProcessing = false;

  Future<String?> _captureImage() async {
    try {
      RenderRepaintBoundary? boundary = _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      // High pixel ratio for sharp images
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/ayah_${widget.surahName}_${widget.ayah.ayahNumber}.png';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(pngBytes);

      return imagePath;
    } catch (e) {
      debugPrint('Error capturing image: $e');
      return null;
    }
  }

  Future<void> _shareImage() async {
    setState(() => _isProcessing = true);
    final imagePath = await _captureImage();
    setState(() => _isProcessing = false);

    if (imagePath != null) {
      try {
        await Share.shareXFiles(
          [XFile(imagePath)],
          text: 'Q.S ${widget.surahName} Ayat ${widget.ayah.ayahNumber}',
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sistem OS ini belum mendukung fitur berbagi gambar secara langsung.'),
              backgroundColor: AppColors.error,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  Future<void> _saveImage() async {
    setState(() => _isProcessing = true);
    final imagePath = await _captureImage();

    if (imagePath != null) {
      try {
        final hasAccess = await Gal.hasAccess();
        if (!hasAccess) {
          await Gal.requestAccess();
        }
        await Gal.putImage(imagePath);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gambar berhasil disimpan ke galeri!'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal menyimpan gambar.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.9;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.darkBackground : AppColors.white;
    final topBarColor = isDark ? AppColors.darkSurface : AppColors.background;
    final textColor = isDark ? AppColors.darkText : AppColors.black;
    final subTextColor = isDark ? AppColors.darkTextSecondary : AppColors.grey;
    final cardStartColor = AppColors.primary;
    final cardEndColor = AppColors.primary.withValues(alpha: 0.8);
    final accentColor = AppColors.secondary;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle and top bar
          _buildTopBar(context, topBarColor, textColor, accentColor),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // The Share Card wrapped in RepaintBoundary for screenshot
                  RepaintBoundary(
                    key: _cardKey,
                    child: _buildShareCard(cardStartColor, cardEndColor, accentColor),
                  ),

                  const SizedBox(height: 32),

                  // Share To section
                  _buildShareOptionsSection(textColor, subTextColor),
                ],
              ),
            ),
          ),

          // Bottom button
          Padding(
            padding: EdgeInsets.fromLTRB(
              24, 16, 24, MediaQuery.of(context).padding.bottom + 24,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isProcessing ? null : _saveImage,
                icon: _isProcessing
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2)
                      )
                    : const Icon(Icons.download_rounded),
                label: Text(
                  _isProcessing ? 'Menyimpan...' : 'Save Image',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, Color bgColor, Color textColor, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: textColor.withValues(alpha: 0.05),
                  shape: const CircleBorder(),
                ),
                icon: Icon(Icons.close, color: textColor, size: 20),
                onPressed: () => context.pop(),
              ),
              Visibility(
                visible: false, // Hidden since preview is already shown below
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Preview',
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Share Ayah',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareCard(Color startColor, Color endColor, Color accentColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gold Star
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accentColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.star,
              color: accentColor,
              size: 24,
            ),
          ),

          const SizedBox(height: 32),

          // Arabic Text
          Text(
            widget.ayah.arab,
            style: AppTypography.arabicFont.copyWith(
              color: AppColors.white,
              fontSize: 28,
              height: 2.0,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),

          const SizedBox(height: 32),

          // Divider
          Container(
            height: 1,
            width: 40,
            color: accentColor.withValues(alpha: 0.5),
          ),

          const SizedBox(height: 32),

          // Translation Text
          Text(
            '"${widget.ayah.translation}"',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Pill Info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${widget.surahName.toUpperCase()} ${widget.ayah.surahNumber}:${widget.ayah.ayahNumber}',
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOptionsSection(Color textColor, Color subTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SHARE TO',
              style: TextStyle(
                color: subTextColor,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                height: 1,
                color: subTextColor.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildShareOption(
              icon: Icons.camera_alt_outlined,
              label: 'Stories',
              color: const Color(0xFF8B2846),
              iconColor: AppColors.white,
              textColor: textColor,
              onTap: _shareImage,
            ),
            _buildShareOption(
              icon: Icons.chat_bubble_outline,
              label: 'WhatsApp',
              color: const Color(0xFF144D31),
              iconColor: AppColors.white,
              textColor: textColor,
              onTap: _shareImage,
            ),
            _buildShareOption(
              icon: Icons.facebook,
              label: 'Facebook',
              color: const Color(0xFF1C345C),
              iconColor: AppColors.white,
              textColor: textColor,
              onTap: _shareImage,
            ),
            _buildShareOption(
              icon: Icons.copy_rounded,
              label: 'Copy Image',
              color: AppColors.grey,
              iconColor: AppColors.white,
              textColor: textColor,
              onTap: _shareImage,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: _isProcessing ? null : onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: textColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: textColor.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

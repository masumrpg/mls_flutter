import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/location_service.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  Position? _currentPosition;
  double? _qiblaDirection; // degrees from true north

  Color get _bgColor => Theme.of(context).scaffoldBackgroundColor;
  Color get _textColor => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkText
      : AppColors.black;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final locService = sl<LocationService>();
    final pos = await locService.getCurrentPosition();
    if (pos != null) {
      _calculateQibla(pos);
    }
    if (mounted) {
      setState(() {
        _currentPosition = pos;
      });
    }
  }

  void _calculateQibla(Position pos) {
    const kaabaLat = 21.422487;
    const kaabaLng = 39.826206;

    final latK = kaabaLat * math.pi / 180.0;
    final lngK = kaabaLng * math.pi / 180.0;
    final latU = pos.latitude * math.pi / 180.0;
    final lngU = pos.longitude * math.pi / 180.0;

    final dLng = lngK - lngU;

    final y = math.sin(dLng) * math.cos(latK);
    final x = math.cos(latU) * math.sin(latK) -
        math.sin(latU) * math.cos(latK) * math.cos(dLng);

    var direction = math.atan2(y, x) * 180.0 / math.pi;
    if (direction < 0) {
      direction += 360.0;
    }

    _qiblaDirection = direction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: Text('Arah Kiblat', style: TextStyle(color: _textColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: _textColor),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_currentPosition == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.orange),
            const SizedBox(height: 16),
            Text('Mendapatkan lokasi...', style: TextStyle(color: _textColor)),
          ],
        ),
      );
    }

    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}', style: TextStyle(color: _textColor)));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange));
        }

        double? direction = snapshot.data?.heading;

        // if direction is null, device doesn't have a sensor
        if (direction == null) {
          return Center(
            child: Text(
              'Perangkat ini tidak memiliki sensor kompas.',
              style: TextStyle(color: _textColor),
            ),
          );
        }

        return _buildCompass(direction);
      },
    );
  }

  Widget _buildCompass(double heading) {
    // Qibla direction relative to the device heading
    // To rotate the compass so North is up, we rotate by -heading
    // To rotate the Qibla needle, we rotate by QiblaDirection - heading

    final angleRotationForCompass = -1 * heading * (math.pi / 180);
    // if _qiblaDirection is known, we can place an indicator for it
    final qiblaAngle = (_qiblaDirection ?? 0) * (math.pi / 180);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${heading.toStringAsFixed(0)}°',
          style: TextStyle(
            color: _textColor,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _qiblaDirection != null
              ? 'Kiblat: ${_qiblaDirection!.toStringAsFixed(0)}° dari Utara'
              : 'Menghitung kiblat...',
          style: TextStyle(color: _textColor.withValues(alpha: 0.7), fontSize: 16),
        ),
        const SizedBox(height: 48),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Ring
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withValues(alpha: 0.1),
                  border: Border.all(color: Colors.orange.withValues(alpha: 0.5), width: 2),
                ),
              ),
              // Compass Dial
              Transform.rotate(
                angle: angleRotationForCompass,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildCompassMarkings(),
                    if (_qiblaDirection != null)
                      Transform.rotate(
                        angle: qiblaAngle,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Center Dot
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E3A8A).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1E3A8A).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.orange),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Jauhkan perangkat dari benda bermagnet untuk hasil yang lebih akurat.',
                  style: TextStyle(color: _textColor, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompassMarkings() {
    return SizedBox(
      width: 250,
      height: 250,
      child: CustomPaint(
        painter: CompassMarkingPainter(
          textColor: _textColor,
        ),
      ),
    );
  }
}

class CompassMarkingPainter extends CustomPainter {
  final Color textColor;
  CompassMarkingPainter({required this.textColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);

    final paintTick = Paint()
      ..color = textColor.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintBoldTick = Paint()
      ..color = textColor.withValues(alpha: 0.7)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < 360; i += 15) {
      final isCardinal = i % 90 == 0;
      final angle = i * math.pi / 180;
      final innerRadius = isCardinal ? radius - 20 : radius - 10;

      final outerPt = Offset(
        center.dx + radius * math.sin(angle),
        center.dy - radius * math.cos(angle), // -cos because y points down
      );
      final innerPt = Offset(
        center.dx + innerRadius * math.sin(angle),
        center.dy - innerRadius * math.cos(angle),
      );

      canvas.drawLine(innerPt, outerPt, isCardinal ? paintBoldTick : paintTick);

      if (isCardinal) {
        String label = 'U';
        if (i == 90) label = 'T';
        if (i == 180) label = 'S';
        if (i == 270) label = 'B';

        textPainter.text = TextSpan(
          text: label,
          style: TextStyle(
            color: i == 0 ? Colors.red : textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();

        final textRadius = radius - 35;
        final textPt = Offset(
          center.dx + textRadius * math.sin(angle) - textPainter.width / 2,
          center.dy - textRadius * math.cos(angle) - textPainter.height / 2,
        );
        textPainter.paint(canvas, textPt);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

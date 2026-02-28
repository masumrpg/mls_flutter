import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../routes/route_names.dart';
import '../../../../core/di/service_locator.dart';
import '../../../sholat/bloc/sholat_schedule_bloc.dart';
import '../../../../shared/widgets/app_scaffold.dart';
import '../../../../shared/widgets/app_header.dart';
import '../widgets/status_card.dart';
import '../widgets/date_cards.dart';
import '../widgets/menu_section.dart';
import '../widgets/quote_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color get _textColor => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkText
      : AppColors.black;
  Color get _cardBg => Theme.of(context).brightness == Brightness.dark
      ? AppColors.darkSurface
      : AppColors.white;

  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  String _getGreetingTitle() {
    final hour = _now.hour;
    if (hour < 11) return 'Sabahul Khair';
    if (hour < 15) return "Naharun Sa'id";
    if (hour < 18) return "Masa'ul Khair";
    return "Lailatun Sa'idah";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SholatScheduleBloc>()..add(FetchSholatSchedule()),
      child: AppScaffold(
        header: AppHeader.greetings(
          name: "Ma'sum",
          greeting: _getGreetingTitle(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              BlocBuilder<SholatScheduleBloc, SholatScheduleState>(
                builder: (context, state) {
                  if (state is SholatScheduleLoaded) {
                    return StatusCard(
                      schedule: state.schedule,
                      now: _now,
                      onQiblaTap: () => context.pushNamed(RouteNames.qibla),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 16),
              DateCards(now: _now, cardBg: _cardBg, textColor: _textColor),
              const SizedBox(height: 32),
              MenuSection(textColor: _textColor, cardBg: _cardBg),
              const SizedBox(height: 32),
              QuoteSection(textColor: _textColor),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

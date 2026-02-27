import 'package:flutter/material.dart';
import 'app_header.dart';

class AppScaffold extends StatelessWidget {
  final AppHeader? header;
  final Widget body;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;

  const AppScaffold({
    super.key,
    this.header,
    required this.body,
    this.drawer,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: (header != null && header!.variant == AppHeaderVariant.classic)
          ? header
          : null,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Column(
        children: [
          if (header != null && header!.variant != AppHeaderVariant.classic)
            header!,
          Expanded(child: body),
        ],
      ),
    );
  }
}

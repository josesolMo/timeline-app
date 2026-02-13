import 'package:flutter/material.dart';
import '../features/timeline/presentation/timeline_page.dart';
import '../theme/app_theme.dart';

class TimelineApp extends StatelessWidget {
  const TimelineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nuestra Historia',
      theme: AppTheme.light,
      home: const TimelinePage(),
    );
  }
}

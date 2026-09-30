import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';

class RepoMindApp extends StatelessWidget {
  const RepoMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RepoMind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}

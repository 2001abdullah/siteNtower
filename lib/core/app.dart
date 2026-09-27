import 'package:flutter/material.dart';

import 'router.dart';
import 'app_theme.dart';

class TmsApp extends StatelessWidget {
  const TmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TMS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}

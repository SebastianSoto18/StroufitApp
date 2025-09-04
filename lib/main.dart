import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/presentation/views/home.dart';
import 'package:stroufitapp/theme/theme.dart';
import 'package:stroufitapp/core/services/background_cleanup_service.dart';

void main() {
  // Inicializar el servicio de limpieza en segundo plano
  BackgroundCleanupService.instance.initialize();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroufit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Home(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/presentation/views/home.dart';
import 'package:stroufitapp/theme/theme.dart';
import 'package:stroufitapp/core/services/background_cleanup_service.dart';

void main() {
  // Inicializar el servicio de limpieza en segundo plano
  BackgroundCleanupService.instance.initialize();

  // Configurar el estilo de la barra de estado para que siempre sea visible
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Barra de estado transparente
      statusBarIconBrightness: Brightness.dark, // Iconos oscuros
      statusBarBrightness: Brightness.light, // Para iOS
      systemNavigationBarColor: Colors.white, // Barra de navegación blanca
      systemNavigationBarIconBrightness:
          Brightness.dark, // Iconos de navegación oscuros
    ),
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Asegurar que la barra de estado siempre sea visible cuando la app se active
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stroufit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const Home(),
      builder: (context, child) {
        // Asegurar que la barra de estado siempre sea visible
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
        );
        return child!;
      },
    );
  }
}

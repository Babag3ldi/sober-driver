import 'package:driver_app/hive_helper/register_adapters.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'providers/baha_provider.dart';
import 'providers/baza_provider.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerAdapters();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BahaProvider()),
        ChangeNotifierProvider(create: (_) => BazaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Taxi App",
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}

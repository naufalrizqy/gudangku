import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'providers/keranjang_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KeranjangProvider()),
      ],
      child: const GudangkuApp(),
    ),
  );
}

class GudangkuApp extends StatelessWidget {
  const GudangkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gudangku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}

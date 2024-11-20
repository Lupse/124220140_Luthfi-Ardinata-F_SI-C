import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsi_124220140/auth/login.dart';
import 'package:responsi_124220140/hive/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hive Init
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  // OpenBox
  await Hive.openBox('user');
  await Hive.openBox('favorites');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

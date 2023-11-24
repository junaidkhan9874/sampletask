import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_task/home_screen.dart';
import 'package:turing_task/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:turing_task/utilis/provider_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProviderNotifier()),
      ],
      child: MaterialApp(
        title: 'Test Task',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          platform: TargetPlatform.iOS,
        ),
        home: FirebaseAuth.instance.currentUser == null ? const LoginScreen() : const HomeScreen(),
      ),
    );
  }
}

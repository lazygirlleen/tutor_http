import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/providers/auth_provider.dart' as ap;
import 'package:tutor_http/screens/login_screen.dart';
import '/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //untuk memastikan seluruh widget yang nanti akan masuk ke project flutter sudah tersedia

  await Firebase.initializeApp(
  //supaya tunggu dulu sampai beres
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<ap.AuthProvider>(
          create: (_) => ap.AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const AuthGuard(),
    );
  }
}


class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //user? datangnya dari provider kita
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
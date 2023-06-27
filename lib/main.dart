import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'data/repositories/login_auth_repository.dart';
import 'firebase_options.dart';
import 'presentation/screens/LoginScreen/home_screen.dart';
import 'presentation/screens/LoginScreen/log_in_screen.dart';
import 'presentation/screens/LoginScreen/register_screen.dart';
import 'presentation/screens/NewsScreeen/news_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await dotenv.load(fileName: 'lib/.env');
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
          routes: {
            '/news': (context) => const NewsScreen(),
            '/login': (context) => const EmailPasswordLogin(),
            '/register': (context) => const RegisterScreen()
          },
          home: const AuthWrapper(),
        ),
    );
  }
}



class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key?key}):super(key: key);

  @override
  Widget build(BuildContext context) {

    final fireBaseUser = context.watch<User?>();
    // print(fireBaseUser);
    if (fireBaseUser != null) {
      return const NewsScreen();
    }
    return const HomeScreen();

  }
}

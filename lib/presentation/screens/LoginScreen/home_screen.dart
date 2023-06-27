import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/login_auth_repository.dart';
import '../widgets/custom_button_widget.dart';
import 'log_in_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
            'https://images.unsplash.com/photo-1566378246598-5b11a0d486cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network('https://blog.releasemyad.com/wp-content/uploads/2014/02/hindustan-times-logo.jpg'),
            ),
            const Spacer(),
            CustomButton(
                buttonName: 'Login',
                onTapFunction: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const EmailPasswordLogin())
                  );
                },
              width: 300,
                ),
            const SizedBox(height: 20,),
            CustomButton(
                buttonName: 'Login With Google',
                onTapFunction: () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context: context);
                  // FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle(context: context);
                },
                width: 300,
            ),

            const SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}

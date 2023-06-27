import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mdgnews2/presentation/screens/LoginScreen/register_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/login_auth_repository.dart';
import '../NewsScreeen/news_screen.dart';
import '../widgets/custom_button_widget.dart';

class EmailPasswordLogin extends StatefulWidget {
  const EmailPasswordLogin({super.key});

  @override
  State<EmailPasswordLogin> createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(email: emailController.text, password: passwordController.text, context: context);
    final fireBaseUser = FirebaseAuth.instance.currentUser;
    // print(fireBaseUser);
    if (fireBaseUser != null ) {
      // return const NewsScreen();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const NewsScreen())
      );
    }
    // FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(email: emailController.text, password: passwordController.text, context: context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          color: const Color.fromRGBO(0, 32, 63, 1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    color: Color.fromRGBO(172, 239, 208, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height *0.08,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<String>(
                        // stream: bloc.loginEmail,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return TextField(
                            // onChanged: (value)=>bloc.changeLoginEmail,
                            cursorColor: const Color.fromRGBO(172, 239, 208, 1),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,

                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              hintText: 'Enter Your Email',
                              labelText: "Email",
                              hintStyle: const TextStyle(
                                  color:  Color.fromRGBO(172, 239, 208, 1)
                              ),

                              labelStyle: const TextStyle(
                                  color:  Color.fromRGBO(172, 239, 208, 1)
                              ),

                            ),
                            style: const TextStyle(
                                color: Color.fromRGBO(172, 239, 208, 1),
                                fontSize: 18
                            ),
                          );
                        }
                      ),
                      const SizedBox(height: 30,),
                      StreamBuilder<String>(
                        // stream: bloc.loginPassword,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return TextField(
                            // onChanged: (value)=>bloc.changeLoginPassword,
                            cursorColor: const Color.fromRGBO(172, 239, 208, 1),
                            obscureText: true,
                            controller: passwordController,

                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: ('Enter Your Password'),
                              labelText: "Password",
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(172, 239, 208, 1)
                                ),

                              labelStyle: const TextStyle(
                                  color: Color.fromRGBO(172, 239, 208, 1)
                              ),

                            ),
                            style: const TextStyle(
                                color: Color.fromRGBO(172, 239, 208, 1),
                                fontSize: 18
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 20,),
                CustomButton(buttonName: "Login", onTapFunction: loginUser,width: 100,),
                const SizedBox(height: 50,),

                RichText(
                    text:  TextSpan(children:[
                      const TextSpan(
                        text: "Need a account?",
                        style: TextStyle(color: Color.fromRGBO(172, 239, 208, 1))
                      ),
                      const WidgetSpan(child: SizedBox(width: 10,)),
                      TextSpan(
                        text: "Register Here",
                        style: const TextStyle(color: Color.fromRGBO(172, 239, 208, 1)),
                        recognizer: TapGestureRecognizer() ..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterScreen())
                          );
                        }
                      )
                    ])
                )


              ],
            ),
          ),
        ),
      ),
    );
  }


}


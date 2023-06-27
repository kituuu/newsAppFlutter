import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mdgnews2/presentation/screens/LoginScreen/log_in_screen.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/login_auth_repository.dart';
import '../widgets/custom_button_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void registerUser() async{
    context.read<FirebaseAuthMethods>().signUpWithEmail(email: emailController.text, password: passwordController.text, context: context);
    // FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(email: emailController.text, password: passwordController.text, context: context);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  "Register",
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
                      TextField(
                        cursorColor: const Color.fromRGBO(172, 239, 208, 1),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                            labelText: "Email",
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
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

),
                      const SizedBox(height: 30,),
                      TextField(
                        cursorColor: const Color.fromRGBO(172, 239, 208, 1),
                        obscureText: true,
                        controller: passwordController,

                        decoration: InputDecoration(
                            hintText: 'Enter Your Password',
                            labelText: "Password",
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color:  Color.fromRGBO(172, 239, 208, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
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
),
                    ],
                  ),
                ),


                const SizedBox(height: 20,),
                CustomButton(
                  buttonName: "Register",
                  onTapFunction: registerUser,
                  width: 120,

),
                const SizedBox(height: 50,),
                RichText(
                    text:  TextSpan(children:[
                      const TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: Color.fromRGBO(172, 239, 208, 1))
                      ),
                      const WidgetSpan(child: SizedBox(width: 10,)),
                      TextSpan(
                          text: "Login Here",
                          style: const TextStyle(color: Color.fromRGBO(172, 239, 208, 1)),
                          recognizer: TapGestureRecognizer() ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EmailPasswordLogin())
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

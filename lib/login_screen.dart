import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_task/home_screen.dart';
import 'package:turing_task/utilis/provider_notifier.dart';

import 'signup_screen.dart';
import 'utilis/app_utils.dart';
import 'utilis/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  var formKey = GlobalKey<FormState>();

  ProviderNotifier? providerNotifier;

  Color blueColor = const Color(0XFF3c3ccd);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    providerNotifier = Provider.of<ProviderNotifier>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(toolbarHeight: 0.0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.close, size: 20.0, color: Colors.black),
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _textUtils.txt16(text: "Login With Email", color: Colors.blueAccent),
                    const SizedBox(height: 30.0),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.sizeOf(context).width,
                      child: TextFormField(
                        controller: emailController,
                        decoration: _appUtils.inputDecorationWithLabel("Email", Colors.white, borderRadius: 10.0),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }

                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Consumer<ProviderNotifier>(builder: (context, build, child) {
                      return SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: _appUtils.inputDecorationWithLabel("Password", Colors.white,
                              borderRadius: 10.0,
                              image: !providerNotifier!.isVisible ? Icons.visibility : Icons.visibility_off,
                              onTap: () => providerNotifier!.checkVisible()),
                          obscureText: !providerNotifier!.isVisible,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),
                      );
                    }),
                    const SizedBox(height: 30.0),
                    _textUtils.txt16(text: "Forgot Password?", color: blueColor, fontWeight: FontWeight.bold),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: 100.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        child: _textUtils.txt14(text: "Login", color: blueColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    _textUtils.txt16(text: "Don't have an account", color: Colors.blueAccent),
                    const SizedBox(height: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                      },
                      child: _textUtils.txt16(text: "Sign Up", color: blueColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      _appUtils.showLoaderDialog(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (mounted) Navigator.pop(context);
      if (credential.user != null) {
        if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'invalid-credential') {
        if (mounted) Navigator.pop(context);
        _appUtils.showToast('No user found for that email.');
      } else if (e.code == 'user-not-found') {
        if (mounted) Navigator.pop(context);
        _appUtils.showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        if (mounted) Navigator.pop(context);
        _appUtils.showToast('Wrong password provided for that user.');
      }
    } catch (e) {
      _appUtils.showToast(e);
    }
  }
}

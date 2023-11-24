import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:turing_task/login_screen.dart';
import 'package:turing_task/utilis/provider_notifier.dart';

import 'utilis/app_utils.dart';
import 'utilis/text_utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextUtils _textUtils = TextUtils();
  final AppUtils _appUtils = AppUtils();
  var formKey = GlobalKey<FormState>();

  ProviderNotifier? providerNotifier;

  Color blueColor = const Color(0XFF3c3ccd);

  TextEditingController nameController = TextEditingController();
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
    return Consumer<ProviderNotifier>(builder: (context, build, child) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(toolbarHeight: 0.0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                _textUtils.txt16(text: "Sign up With Email", color: Colors.blueAccent),
                const SizedBox(height: 30.0),
                InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 50);
                    if (pickedFile != null) {
                      providerNotifier!.setImage(pickedFile.path);
                    }
                  },
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50),
                          child: Container(
                            child: providerNotifier!.selectedImage.path == ""
                                ? Image.asset("assets/profile_placeholder.png", fit: BoxFit.cover)
                                : Image(
                                    image: FileImage(providerNotifier!.selectedImage),
                                    alignment: Alignment.topCenter,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: TextFormField(
                    controller: nameController,
                    decoration: _appUtils.inputDecorationWithLabel("Name", Colors.white, borderRadius: 10.0),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
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
                const SizedBox(height: 10.0),
                SizedBox(
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
                ),
                const SizedBox(height: 30.0),
                SizedBox(
                  width: 100.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (providerNotifier!.selectedImage.path.isNotEmpty) {
                          signUp(providerNotifier!.selectedImage);
                        } else {
                          _appUtils.showToast("Please Select Image");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    child: _textUtils.txt14(text: "Sign Up", color: blueColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30.0),
                _textUtils.txt16(text: "Already have an account", color: Colors.blueAccent),
                const SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: _textUtils.txt16(text: "Login", color: blueColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> signUp(File profileImage) async {
    try {
      _appUtils.showLoaderDialog(context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (credential.user != null) {
        saveInFirebase(profileImage);
      } else {
        if (mounted) Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      if (e.code == 'weak-password') {
        if (mounted) Navigator.pop(context);
        _appUtils.showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        if (mounted) Navigator.pop(context);
        _appUtils.showToast('The account already exists for that email.');
      }
    } catch (e) {
      _appUtils.showToast(e);
    }
  }

  Future<void> saveInFirebase(profileImage) async {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    var ref = FirebaseStorage.instance.ref().child('userImages').child(uId).child("$uId.png");
    var uploadImage = await ref.putFile(profileImage);
    String imageUrl = await uploadImage.ref.getDownloadURL();

    Map<String, String> saveModel = {
      "name": nameController.text,
      "email": emailController.text,
      "userId": uId,
      "userImage": imageUrl,
    };

    FirebaseFirestore.instance.collection('Users').doc().set(saveModel).then((value) {
      _appUtils.showToast("User Created Successfully");
      if (mounted) {
        Navigator.pop(context);
        providerNotifier!.setImage("");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }
}

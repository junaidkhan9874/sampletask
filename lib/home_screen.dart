import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turing_task/login_screen.dart';
import 'package:turing_task/utilis/provider_notifier.dart';

import 'utilis/dialog_with_input_field_widget.dart';
import 'utilis/text_utils.dart';
import 'utilis/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextUtils _textUtils = TextUtils();
  ProviderNotifier? providerNotifier;
  Color blueColor = const Color(0XFF3c3ccd);
  List<UserModel> userList = [];

  late StreamSubscription realTimeUserList;

  @override
  void initState() {
    providerNotifier = Provider.of<ProviderNotifier>(context, listen: false);
    super.initState();
    providerNotifier!.userList.clear();
    providerNotifier!.getUsers();
    providerNotifier!.getRealTimeUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderNotifier>(builder: (context, build, child) {
      userList = providerNotifier!.userList;
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: _textUtils.txt20(text: "Users", color: Colors.black, fontWeight: FontWeight.bold),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0))),
          child: const Icon(Icons.logout, color: Colors.white, size: 24.0),
        ),
        body: userList.isEmpty
            ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white, color: blueColor))
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  children: [
                    for (int i = 0; i < userList.length; i++)
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(50),
                                    child: userList[i].userImage != null
                                        ? Image.network(userList[i].userImage!, fit: BoxFit.cover)
                                        : Image.asset("assets/profile_placeholder.png", fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if(userList[i].email == FirebaseAuth.instance.currentUser!.email){
                                      showDialog(
                                        context: context,
                                        builder: (_) => DialogWithInputFieldWidget(
                                            title: userList[i].name!,
                                            function: (text) async {
                                              Navigator.pop(context);
                                              providerNotifier!.updateUserName(userList[i].id!, text);
                                            }),
                                      );
                                    }
                                  },
                                  child: _textUtils.txt16(text: userList[i].name!),
                                ),
                              ),
                            ],
                          ),
                          if (i < userList.length - 1) const Divider(color: Colors.grey)
                        ],
                      ),
                    const SizedBox(height: 100.0),
                  ],
                ),
              ),
      );
    });
  }
}

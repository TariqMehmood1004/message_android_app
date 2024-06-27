// ignore_for_file: prefer_final_locals, always_specify_types

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../services/services.dart';
import 'auth.dart';
import 'chats_list.dart';
import '../utils/colors.dart';
import 'video_call_page.dart';
import 'voice_call_page.dart';
import 'package:flutter_share/flutter_share.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController callID = TextEditingController();
  late String randomCallID;
  String? savedUserID;
  String? savedUserName;

  @override
  void initState() {
    super.initState();
    generateRandomCallID();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedUserID = prefs.getString('userID');
    savedUserName = prefs.getString('userName');

    if (savedUserID != null && savedUserName != null) {
      setState(() {
        callID.text = savedUserID!;
      });
    }
  }

  void generateRandomCallID() {
    const int length = 16;
    var random = Random.secure();
    var codeUnits = List.generate(length, (index) {
      return random.nextInt(33) + 89;
    });

    setState(() {
      randomCallID = String.fromCharCodes(codeUnits);
      callID.text = randomCallID;
    });
  }

  Future<void> shareCallID(String callID) async {
    String message = callID;

    try {
      await FlutterShare.share(
        title: 'Share via WhatsApp',
        text: message,
        chooserTitle: 'Share via',
      );
    } catch (e) {
      print('Error sharing via WhatsApp: $e');
    }
  }

  void routeToVideoCall() {
    setState(() {
      if (mounted) {
        Get.to(
          () => VideoCallPage(callID: callID.text),
          fullscreenDialog: true,
          opaque: false,
          transition: Transition.circularReveal,
        );
      }
    });
  }

  void routeToVoiceCall() {
    setState(() {
      if (mounted) {
        Get.to(
          () => VoiceCallPage(callID: callID.text),
          fullscreenDialog: true,
          opaque: false,
          transition: Transition.circularReveal,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorBlue,
          title: Text(
            '${widget.title} - ${savedUserName ?? 'Anonymous'}',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: false,
          actions: [
            // beautiful Logout
            IconButton(
              onPressed: () async {
                await _logout(context);
              },
              icon: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          scrollDirection: Axis.vertical,
          reverse: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Column(
                  children: [
                    TextFormField(
                      controller: callID,
                      decoration: InputDecoration(
                        labelText: 'Call ID',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                            onPressed: () {
                              shareCallID(callID.text);
                            },
                            icon: Icon(Icons.content_copy)),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "The Call ID is used to join the call. It must be same for both parties (you and the next user).",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: colorGray,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height * 0.9,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      MediaQuery.of(context).size.height * 0.1),
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(
                                      MediaQuery.of(context).size.height * 0.1),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  "https://img.freepik.com/free-vector/online-training-concept-illustration_114360-24616.jpg?t=st=1719399312~exp=1719402912~hmac=de9523f5e0aea08a0b1c2101621de53549ed2600ecde97b37992e074d2cfbd73&w=600",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.height * 0.6,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: GestureDetector(
                                onTap: routeToVideoCall,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: colorDark.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                    ),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.2,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  transform: Matrix4.translationValues(0, 0, 0),
                                  transformAlignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: colorDark,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "Video Call",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: colorOffWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.height * 0.9,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(
                                    MediaQuery.of(context).size.height * 0.1),
                              ),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      MediaQuery.of(context).size.height * 0.1),
                                  topRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(
                                      MediaQuery.of(context).size.height * 0.1),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  "https://img.freepik.com/free-vector/podcast-audience-concept-illustration_114360-2753.jpg?t=st=1719400485~exp=1719404085~hmac=f8daf79c56448540528c914b38ea215dae755929ac4796000d57f6416cfed76d&w=600",
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.height * 0.6,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: GestureDetector(
                                onTap: routeToVideoCall,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: colorDark.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(
                                          MediaQuery.of(context).size.height *
                                              0.1),
                                    ),
                                  ),
                                  constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.2,
                                    maxWidth:
                                        MediaQuery.of(context).size.width * 0.9,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  transform: Matrix4.translationValues(0, 0, 0),
                                  transformAlignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: colorDark,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Text(
                                      "Voice Call",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: colorOffWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    try {
      // Disconnect user from Zego cloud
      await ZIMKit().disconnectUser();
      clearCredentials();

      // Navigate to login page
      Get.offAll(() => LoginPage());
    } catch (e) {
      print('Logout failed: $e');
      // Handle logout failure, if necessary
    }
  }

  // Method to clear credentials
  static Future<void> clearCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("userID");
    await prefs.remove("userName");
  }
}

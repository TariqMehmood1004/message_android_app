import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../services/services.dart';
import 'auth.dart';
import 'chats_list.dart';
import '../utils/colors.dart';
import 'video_call_page.dart';
import 'voice_call_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.cameras});

  final String title;
  final List<CameraDescription> cameras;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController callID = TextEditingController();
  void routeToVideoCall() {
    setState(() {
      if (mounted) {
        if (callID.text == "") {
          if (ZIMKit().currentUser == null) {
            // Show Scaffold Messenger
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login first'),
              ),
            );
          }
          // Show Scaffold Messenger
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter call ID'),
            ),
          );
        } else {
          if (ZIMKit().currentUser == null) {
            // Show Scaffold Messenger
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login first'),
              ),
            );
          } else {
            // show dialog to get input from user
            Get.to(
              () => VideoCallPage(callID: callID.text, cameras: widget.cameras),
              fullscreenDialog: true,
              opaque: false,
              transition: Transition.circularReveal,
            );
          }
        }
      }
    });
  }

  void routeToVoiceCall() {
    setState(() {
      if (mounted) {
        if (callID.text == "") {
          if (ZIMKit().currentUser == null) {
            // Show Scaffold Messenger
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login first'),
              ),
            );
          }
          // Show Scaffold Messenger
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter call ID'),
            ),
          );
        } else {
          if (ZIMKit().currentUser == null) {
            // Show Scaffold Messenger
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please login first'),
              ),
            );
          } else {
            Get.to(
              () => VoiceCallPage(callID: callID.text),
              fullscreenDialog: true,
              opaque: false,
              transition: Transition.circularReveal,
            );
          }
        }
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
          title: Text(widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            // beautiful Logout
            IconButton(
              onPressed: () async {
                await Auth.logout();
                Get.offAll(() => LoginPage(cameras: widget.cameras));
              },
              icon: const Icon(Icons.logout, color: Colors.white),
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
                    TextField(
                      controller: callID,
                      decoration: InputDecoration(
                        labelText: 'Call ID',
                        border: OutlineInputBorder(),
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
}

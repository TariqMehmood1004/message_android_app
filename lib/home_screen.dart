import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'auth.dart';
import 'chats_list.dart';
import 'utils/colors.dart';
import 'video_call_page.dart';
import 'voice_call_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
              () => VideoCallPage(callID: callID.text),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          // beautiful Logout
          IconButton(
            onPressed: () {
              Get.to(() => const LoginPage());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              TextField(
                controller: callID,
                decoration: InputDecoration(
                  labelText: 'Call ID',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: routeToVideoCall,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: colorBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Video Call",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    // color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: routeToVoiceCall,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        decoration: BoxDecoration(
                          color: colorOffBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Voice Call",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    // color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Chats",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: colorBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
              ),
              Expanded(child: ChatsList()),
            ],
          ),
        ),
      ),
    );
  }
}

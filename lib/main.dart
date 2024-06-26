// ignore_for_file: unreachable_from_main

import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'screens/auth.dart';
import 'screens/home_screen.dart';
import 'utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  ZIMKit().init(
    appID: appID,
    appSign: appSign,
  );
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    if (ZIMKit().currentUser != null) {
      log("Current User: ${ZIMKit().currentUser()}");
    } else {
      log("Current User: Not Available...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zedo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ZIMKit().currentUser() != null
          ? MyHomePage(title: "Zedo", cameras: widget.cameras)
          : LoginPage(cameras: widget.cameras),
    );
  }
}

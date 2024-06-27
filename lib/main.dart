import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'screens/auth.dart';
import 'screens/home_screen.dart';
import 'utils/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ZIMKit().init(
    appID: appID,
    appSign: appSign,
  );

  // Check if user credentials are stored in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedUserID = prefs.getString('userID');
  String? savedUserName = prefs.getString('userName');

  runApp(MyApp(
    savedUserID: savedUserID,
    savedUserName: savedUserName,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.savedUserID,
    required this.savedUserName,
  });

  final String? savedUserID;
  final String? savedUserName;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zedo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: savedUserID != null && savedUserName != null
          ? MyHomePage(title: "Zedo")
          : LoginPage(),
    );
  }
}

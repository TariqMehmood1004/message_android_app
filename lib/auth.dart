import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'config.dart';
import 'home_screen.dart';
import 'services/services.dart';
import 'utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<void> connectUser() async {
    String userID = _userIDController.text.trim();
    String userName = _userNameController.text.trim();

    if (userID.isEmpty || userName.isEmpty) {
      Get.snackbar('Error', 'User ID and User Name cannot be empty',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      await Auth.login(userID, userName);
      Get.off(() => MyHomePage(title: "Zedo"));
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: colorBlue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: _userIDController,
                decoration: InputDecoration(
                  labelText: 'User ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: connectUser,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: colorBlue,
                  ),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: colorWhite,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

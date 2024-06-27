import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/services.dart';
import '../utils/colors.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials(); // Load saved credentials on app start
  }

  Future<void> connectUser() async {
    String userID = _userIDController.text.trim();
    String userName = _userNameController.text.trim();

    try {
      if (userID.isEmpty || userName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User ID and User Name cannot be empty'),
          ),
        );
        return;
      } else {
        if (userID.length != 11) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Phone number must be 11 characters long'),
            ),
          );
        } else {
          await Auth.login(userID, userName);

          // Save credentials to shared preferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userID', userID);
          await prefs.setString('userName', userName);

          Get.off(
            () => MyHomePage(title: "Zedo", cameras: widget.cameras),
            transition: Transition.circularReveal,
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserID = prefs.getString('userID');
    String? savedUserName = prefs.getString('userName');

    if (savedUserID != null && savedUserName != null) {
      _userIDController.text = savedUserID;
      _userNameController.text = savedUserName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://img.freepik.com/free-vector/romantic-date-abstract-concept-vector-illustration-first-date-romantic-relationship-love-story-valentine-day-give-flower-couple-fine-dinning-celebrate-dating-anniversary-abstract-metaphor_335657-6204.jpg?t=st=1719344779~exp=1719348379~hmac=de9a591cfbc73b2e0dc9cdbf436931b4e354cd73dd9313ae71b706630564939e&w=1380', // Replace with your image asset
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Login',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: colorBlue,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(height: 32),
                    TextFormField(
                      controller: _userIDController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        // Check if value is not empty
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }

                        // Check if value is exactly 11 digits
                        if (value.length != 11) {
                          return 'Please enter a valid 11-digit phone number';
                        }

                        // Check if value contains only digits
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter only numeric digits';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Profile Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your user name';
                        }
                        return null;
                      },
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
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: colorWhite,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

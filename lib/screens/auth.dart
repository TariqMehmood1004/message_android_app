// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import '../services/services.dart';
import '../utils/colors.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  Future<void> connectUser() async {
    String userID = _userIDController.text.trim();
    String userName = _userNameController.text.trim();

    if (userID.isEmpty || userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID and User Name cannot be empty'),
        ),
      );
      return;
    }

    try {
      await Auth.login(userID, userName);
      Get.off(() => MyHomePage(title: "Zedo"));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
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
                    TextField(
                      controller: _userIDController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'User ID (e.g. 123456)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _userNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'User Name (e.g. Tariq Mehmood)',
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

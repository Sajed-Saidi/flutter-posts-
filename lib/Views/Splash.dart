import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/Controllers/AuthController.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

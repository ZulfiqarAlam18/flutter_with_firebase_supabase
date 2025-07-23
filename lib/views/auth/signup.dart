// lib/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sign Up", style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 30.h),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: () {
                AuthController.instance.register(
                    emailController.text.trim(), passwordController.text.trim());
              },
              child: Text("Sign Up", style: TextStyle(fontSize: 16.sp)),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/login'),
              child: Text("Already have an account? Login"),
            )
          ],
        ),
      ),
    );
  }
}

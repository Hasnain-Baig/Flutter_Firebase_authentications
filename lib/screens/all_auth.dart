import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentications/controllers/email_password_auth_controller.dart';
import 'package:flutter_firebase_authentications/controllers/home_controller.dart';
import 'package:flutter_firebase_authentications/screens/email_password_auth.dart';
import 'package:flutter_firebase_authentications/screens/fb_auth.dart';
import 'package:flutter_firebase_authentications/screens/google_auth.dart';
import 'package:flutter_firebase_authentications/screens/home.dart';
import 'package:get/get.dart';

import 'phone_auth.dart';

class AllAuth extends StatelessWidget {
  AllAuth({Key? key}) : super(key: key);

  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildButton(context, "Email Password Signin"),
          const SizedBox(
            height: 10,
          ),
          buildButton(context, "Google Signin"),
          const SizedBox(
            height: 10,
          ),
          buildButton(context, "Facebook Signin"),
          const SizedBox(
            height: 10,
          ),
          buildButton(context, "Phone Number Signin"),
        ]),
      ),
    );
  }

  Widget buildButton(context, val) {
    return GetBuilder<HomeController>(builder: (_) {
      print(_homeController.user);
      return ElevatedButton(
          onPressed: () {
            if (_homeController.user['uid'] != null) {
              Get.to(Home());
            } else {
              val == "Email Password Signin"
                  ? Get.to(EmailPasswordAuth())
                  : val == "Google Signin"
                      ? Get.to(GoogleAuth())
                      : val == "Facebook Signin"
                          ? Get.to(FBAuth())
                          : val == "Phone Number Signin"
                              ? Get.to(PhoneAuth())
                              // ignore: avoid_print
                              : print("none");
            }
          },
          child: Text(val));
    });
  }
}

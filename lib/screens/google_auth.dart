import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/google_auth_controller.dart';

class GoogleAuth extends StatelessWidget {
  GoogleAuth({Key? key}) : super(key: key);

  GoogleAuthController _googleAuthController = Get.put(GoogleAuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleAuthController>(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _googleAuthController.isLoad
                  ? CircularProgressIndicator()
                  : buildGoogleLoginButton(context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildGoogleLoginButton(context) {
    return ElevatedButton.icon(
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 211, 66, 55)),
      onPressed: () {
        _googleAuthController.login(context);
      },
      icon: const FaIcon(FontAwesomeIcons.google),
      label: const Text("Google Signin"),
    );
  }
}

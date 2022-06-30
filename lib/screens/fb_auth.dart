import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/fb_auth_controller.dart';

class FBAuth extends StatelessWidget {
  FBAuth({Key? key}) : super(key: key);

  FBAuthController _fbAuthController = Get.put(FBAuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FBAuthController>(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _fbAuthController.isLoad
                  ? CircularProgressIndicator()
                  : buildFBLoginButton(context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildFBLoginButton(context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 0, 66, 121)),
      onPressed: () {
        _fbAuthController.login(context);
      },
      icon: const FaIcon(FontAwesomeIcons.facebook),
      label: const Text("Facebook Signin"),
    );
  }
}

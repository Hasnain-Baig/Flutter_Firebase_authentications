import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../components/dialog_box/my_dialog_box.dart';
import '../screens/home.dart';
import 'home_controller.dart';

class FBAuthController extends GetxController {
  bool _isLoad = false;
  bool get isLoad => _isLoad;

  HomeController _homeController = Get.put(HomeController());

  login(context) async {
    if (_homeController.user['uid'] != null) {
      Get.to(Home());
    } else {
      try {
        _isLoad = true;
        update();
        FirebaseAuth auth = FirebaseAuth.instance;

        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        var credentials =
            await auth.signInWithCredential(facebookAuthCredential);
        _isLoad = false;
        update();

        var uid = credentials.user!.uid;
        var name = credentials.user!.displayName;
        var email = credentials.user!.email;

        _homeController.setUser(uid, name, email);
        Get.to(Home());

        print("credentials=======>${credentials}");
      } catch (e) {
        _isLoad = false;
        update();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", e);
            });
      }
    }
  }
}

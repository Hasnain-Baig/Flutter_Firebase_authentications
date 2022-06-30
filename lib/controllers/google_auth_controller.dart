import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentications/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../components/dialog_box/my_dialog_box.dart';
import '../screens/home.dart';

class GoogleAuthController extends GetxController {
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

        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        var credentials = await auth.signInWithCredential(credential);
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

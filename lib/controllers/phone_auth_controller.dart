import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/dialog_box/my_dialog_box.dart';
import '../screens/home.dart';
import 'home_controller.dart';

class PhoneAuthController extends GetxController {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  TextEditingController _OTPCodeController = TextEditingController();
  TextEditingController get OTPCodeController => _OTPCodeController;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  var credentials;
  HomeController _homeController = Get.put(HomeController());

  login(context) async {
    if (_homeController.user['uid'] != null) {
      Get.to(Home());
    } else {
      try {
        _isLoad = true;
        update();
        FirebaseAuth auth = FirebaseAuth.instance;

        await auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // ANDROID ONLY!

            print("vc");
            // Sign the user in (or link) with the auto-generated credential
            credentials = await auth.signInWithCredential(credential);
            _isLoad = false;
            _OTPCodeController.text = "";
            update();
            print("completed======>${credentials}");

            var uid = credentials.user!.uid;
            var name = credentials.user!.displayName;
            var email = credentials.user!.email;

            _homeController.setUser(uid, name, email);
            Get.to(Home());
          },
          verificationFailed: (FirebaseAuthException e) {
            print("vf");

            _isLoad = false;
            update();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyDialogBox("Error", e);
                });
          },
          codeSent: (String verificationId, int? resendToken) async {
            print("cs");
            await otpDialoagBox(context, () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: _OTPCodeController.text.trim());

              // Sign the user in (or link) with the auto-generated credential
              credentials = await auth.signInWithCredential(credential);
              _isLoad = false;
              _OTPCodeController.text = "";
              update();
              print("custom completed======>${credentials}");

              var uid = credentials.user!.uid;
              var name = credentials.user!.displayName;
              var email = credentials.user!.email;

              _homeController.setUser(uid, name, email);
              Get.to(Home());
            });
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            print("cart");
            // Auto-resolution timed out...
          },
        );

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

  otpDialoagBox(context, VoidCallback onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: _OTPCodeController,
                    decoration: InputDecoration(hintText: "Enter OTP"))
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  onPressed();
                },
                child: Text("done"),
              )
            ],
          );
        });
  }
}

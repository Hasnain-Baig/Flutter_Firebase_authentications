import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentications/controllers/home_controller.dart';
import 'package:flutter_firebase_authentications/screens/home.dart';
import 'package:get/get.dart';

import '../components/dialog_box/my_dialog_box.dart';

class EmailPasswordAuthController extends GetxController {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool _hidePass = true;
  bool get hidePass => _hidePass;

  bool _isLoad = false;
  bool get isLoad => _isLoad;

  Map _userData = {};
  Map get userData => _userData;

  hidePassword() {
    _hidePass = !_hidePass;
    update();
  }

  HomeController _homeController = Get.put(HomeController());

  login(context) async {
    if (_homeController.user['uid'] != null) {
      Get.to(Home());
    } else {
      print(
          "\nEmail:${_emailController.text}\nPass:${_passwordController.text}");
      update();

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore db = FirebaseFirestore.instance;
      var email = emailController.text;
      var password = passwordController.text;

      if (email != "" && password != "") {
        try {
          _isLoad = true;
          update();

          final UserCredential user = await auth.signInWithEmailAndPassword(
              email: email, password: password);
          final DocumentSnapshot snapshot =
              await db.collection("users").doc(user.user!.uid).get();
          _isLoad = false;
          update();

          _userData = snapshot.data() as Map;
          print("Snapshot : ${userData}");
          _userData["uid"] = user.user!.uid;
          print("User logged in");

          _emailController.clear();
          _passwordController.clear();

          Object e = "Logged In Successfully";

          var uid = _userData["uid"];
          var name = _userData["name"];
          var user_email = _userData["email"];

          _homeController.setUser(uid, name, user_email);
          Get.to(Home());
        } catch (e) {
          _isLoad = false;
          update();

          int errIndex = e.toString().indexOf(']');
          String error =
              e.toString().substring((errIndex + 1), e.toString().length - 1);

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialogBox("Error", error);
              });
        }
      } else {
        Object e = "Some Fields are Empty";
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", e);
            });
      }
      update();
    }
  }

  forgotPassword(context) async {
    if (emailController.text != "") {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyDialogBox("Success",
                          "Password Reset link has been sent to your email!!");
                    })
              })
          .catchError((e) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MyDialogBox("Error", e.toString());
            });
      });
    } else {
      Object e = "Email is Empty! Kindly Type your email!!";
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyDialogBox("Error", e);
          });
    }
  }
}

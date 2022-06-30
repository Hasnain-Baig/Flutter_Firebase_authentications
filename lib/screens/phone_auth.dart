import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentications/controllers/phone_auth_controller.dart';
import 'package:get/get.dart';

class PhoneAuth extends StatelessWidget {
  PhoneAuth({Key? key}) : super(key: key);

  PhoneAuthController _phoneAuthController = Get.put(PhoneAuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneAuthController>(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(context),
              const SizedBox(
                height: 10,
              ),
              _phoneAuthController.isLoad
                  ? CircularProgressIndicator()
                  : buildPhoneLoginButton(context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildTextField(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      child: TextField(
        controller: _phoneAuthController.phoneNumberController,
        decoration: InputDecoration(hintText: "Enter Phone Number"),
      ),
    );
  }

  Widget buildPhoneLoginButton(context) {
    return ElevatedButton.icon(
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 103, 184, 250)),
      onPressed: () {
        _phoneAuthController.login(context);
      },
      icon: const Icon(Icons.phone),
      label: const Text("Send OTP"),
    );
  }
}

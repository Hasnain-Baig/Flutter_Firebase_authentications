import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentications/controllers/email_password_auth_controller.dart';
import 'package:get/get.dart';

class EmailPasswordAuth extends StatelessWidget {
  EmailPasswordAuth({Key? key}) : super(key: key);

  EmailPasswordAuthController _emailPasswordAuthController =
      Get.put(EmailPasswordAuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailPasswordAuthController>(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(context, "Email", false),
              SizedBox(
                height: 5,
              ),
              buildTextField(context, "Password", true),
              SizedBox(
                height: 5,
              ),
              buildForgotPasswordButton(context),
              SizedBox(
                height: 10,
              ),
              _emailPasswordAuthController.isLoad
                  ? CircularProgressIndicator()
                  : buildEmailPasswordLoginButton(context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildTextField(context, val, isPassword) {
    return Container(
      width: MediaQuery.of(context).size.width * .7,
      child: TextField(
        obscureText: isPassword && _emailPasswordAuthController.hidePass,
        controller: isPassword
            ? _emailPasswordAuthController.passwordController
            : _emailPasswordAuthController.emailController,
        decoration: InputDecoration(
            hintText: val,
            prefixIcon: Icon(isPassword ? Icons.password : Icons.email),
            suffixIcon: isPassword
                ? InkWell(
                    onTap: () {
                      _emailPasswordAuthController.hidePassword();
                    },
                    child: Icon(_emailPasswordAuthController.hidePass
                        ? Icons.visibility
                        : Icons.visibility_off))
                : Text("")),
      ),
    );
  }

  Widget buildForgotPasswordButton(context) {
    return TextButton(
        onPressed: () {
          _emailPasswordAuthController.forgotPassword(context);
        },
        child: Text("Forgot Password"));
  }

  Widget buildEmailPasswordLoginButton(context) {
    return ElevatedButton.icon(
      onPressed: () {
        _emailPasswordAuthController.login(context);
      },
      icon: const Icon(Icons.email),
      label: const Text("Login"),
    );
  }
}

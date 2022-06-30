import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("UID: ${_homeController.user['uid']}"),
              SizedBox(
                height: 10,
              ),
              Text("Name: ${_homeController.user['name']}"),
              SizedBox(
                height: 10,
              ),
              Text("Email: ${_homeController.user['email']}"),
              SizedBox(
                height: 30,
              ),
              buildLogOutButton(context)
            ],
          ),
        ),
      );
    });
  }

  Widget buildLogOutButton(context) {
    return ElevatedButton.icon(
      onPressed: () {
        _homeController.logout();
      },
      icon: const Icon(Icons.logout),
      label: const Text("Log Out"),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogBox extends StatelessWidget {
  String title;
  Object value;
  MyDialogBox(
    this.title,
    this.value,
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          "${title}",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text("${value}"),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Ok"),
          ),
        )
      ],
    );
  }
}

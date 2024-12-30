import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // This defines the size of the app bar.

  MyAppBar(
      {Key? key, this.preferredSize = const Size.fromHeight(kToolbarHeight)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        "Socially",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).primaryColor,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black38,
      actions: [
        Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Transform.rotate(
                angle: -45 * 3.14159 / 180, // Rotates the icon 45 degrees
                child: Icon(Icons.send),
              ),
              onPressed: () {
                Get.toNamed("/messages");
              },
            ))
      ],
    );
  }
}

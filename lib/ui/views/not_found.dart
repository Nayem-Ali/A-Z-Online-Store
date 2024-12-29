import 'package:flutter/material.dart';

class Unknown extends StatelessWidget {
  const Unknown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Not Found",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

import 'package:api_practice/example_five.dart';
import 'package:api_practice/example_one.dart';
import 'package:api_practice/example_three.dart';
import 'package:api_practice/signup.dart';
import 'package:api_practice/upload_image.dart';
import 'package:flutter/material.dart';

import 'example_four.dart';
import 'example_two.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageUploadScreen(),
    );
  }
}

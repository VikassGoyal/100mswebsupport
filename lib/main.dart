import 'package:flutter/material.dart';
import 'package:testflutterapp/app.dart';
import 'package:testflutterapp/create_user_screen.dart';
import 'package:testflutterapp/iframe_screen.dart';
import 'package:testflutterapp/livestream/live_stream_login.dart';
import 'package:testflutterapp/livestreammobile/live_stream_mobile_create.dart';
import 'package:testflutterapp/livestreammobile/live_stream_mobile_login.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const CreateUserScreen()
    );
  }
}


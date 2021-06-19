import 'package:ferryapp/presantation/widget/checkinpage.dart';
import 'package:ferryapp/presantation/widget/login.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ferry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginscreen(),
    );
  }
}

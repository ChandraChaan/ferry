import 'dart:convert';

import 'package:ferryapp/network/network_layer.dart';
import 'package:ferryapp/presantation/common/body_theme.dart';
import 'package:ferryapp/presantation/common/button.dart';
import 'package:ferryapp/presantation/common/inputfeildcc.dart';
import 'package:ferryapp/presantation/widget/scaning_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginscreen extends StatelessWidget {
  double height = 34;
  TextEditingController username_c = TextEditingController();
  TextEditingController password_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return themeBody(
      body: Padding(
        padding: const EdgeInsets.only(left: 28, top: 52, right: 28),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 53,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Text(
                'Login',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: height),
            Container(
              child: formText(
                  'Enter username here', 'User Name', username_c, 'd', false),
              height: 58,
              width: MediaQuery.of(context).size.width,
              // color: Colors.yellowAccent,
            ),
            SizedBox(height: height),
            Container(
              child: formText('At least 6 characters password', 'Password',
                  password_c, 'd', false),
              height: 58,
              width: MediaQuery.of(context).size.width,
              // color: Colors.grey,
            ),
            SizedBox(height: height),
            themeButton(
              name: 'Login',
              onClick: () {
                if (username_c.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Please fill username'),
                  ));
                }
                else if (password_c.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Please fill password'),
                  ));
                }
                else if (username_c.text.isNotEmpty &&
                    password_c.text.isNotEmpty) {
                  HttpserviceC().getUserdata(
                    name: username_c.text,
                    pw: password_c.text,
                    ctx: context,
                  );
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor:Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text('Please fill details and try again'),
                  ));
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}

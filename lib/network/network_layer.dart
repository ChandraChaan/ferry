import 'dart:convert';
import 'package:ferryapp/presantation/widget/scaning_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpserviceC {
  Future<String> getUserdata({String name, String pw, var ctx}) async {
    print('Network layer arrived');
    var url = Uri.parse('https://jayacoastal.com/staging/api_login');
    final boDy = jsonEncode({
      'username': '${name}', /*'ANKG',*/
      'password': '${pw}', /*'123456'*/
    });
    print(url);
    print(boDy);
    print('just entered to hit URL');
    final res = await http.post(url, body: boDy);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('Good');
      // return true;
      //   print(jsonDecode(res.body));
      Map<String, dynamic> data =
          new Map<String, dynamic>.from(json.decode(res.body));
      print(data);
      Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
              builder: (BuildContext context) => scaningPage(
                    useriD: data['id'],
                    username: data['username'],
                    member_group: data['member_group'],
                  )));
    } else {
      print('Bad');
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor:Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text('Username or password wrong try again'),
      ));
    }
  }
}

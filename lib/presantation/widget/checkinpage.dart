import 'dart:convert';

import 'package:ferryapp/presantation/common/body_theme.dart';
import 'package:ferryapp/presantation/common/button.dart';
import 'package:ferryapp/presantation/common/inputfeildcc.dart';
import 'package:ferryapp/presantation/widget/scaning_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class checkInPage extends StatefulWidget {
  final String useriD;
  final String checkUrL;
  final String member_group;
  final String username;

  checkInPage({this.useriD, this.member_group, this.username, this.checkUrL});

  @override
  _checkInPageState createState() => _checkInPageState();
}

class _checkInPageState extends State<checkInPage> {
  double height = 34;

  double Heighty = 23;

  double smHeighty = 4;

  final Style = TextStyle(fontWeight: FontWeight.bold);

  final tickid = TextEditingController(text: '');

  final remaerk = TextEditingController(text: '');

  final journy = TextEditingController(text: '');

  final paymentid = TextEditingController(text: '');
 bool checkin = false;
  String barcodeurl = "mt";
  Future<String> getUserCheckdata() async {
    print('entered user checking data');
    var url = Uri.parse('${widget.checkUrL}' +
        '&mgroup=' +
        '${widget.member_group}' +
        '&msid=' +
        '${widget.useriD}' +
        '&api_token=@McQfTjWnZr4u7x!A%D' +
        '*G-KaNdRgUkXp');
    print(url);
    print('just entered to hit URL');
    final res = await http.get(url);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('Good');
      Map<String, dynamic> data =
      new Map<String, dynamic>.from(json.decode(res.body));
      print(data);
      setState(() {
        tickid.text = data['depart_ticket'];
        remaerk.text = data['0']['check_in'] == '1' ? 'Your already checked in ' : 'Not checked in Yet';
        journy.text = '${data['0']['depart_departure']}'+' to '+'${data['0']['depart_destination']}';
        paymentid.text = data['0']['depart_payment_date'];
        checkin = data['0']['check_in'] == '1' ? true : false;
      });
    } else {
      print('Bad');
    }
  }

  Future<String> getagainUserCheckdata() async {
    print('entered user checking data');
    var url = Uri.parse('${barcodeurl}' +
        '&mgroup=' +
        '${widget.member_group}' +
        '&msid=' +
        '${widget.useriD}' +
        '&api_token=@McQfTjWnZr4u7x!A%D' +
        '*G-KaNdRgUkXp');
    print(url);
    print('just entered to hit URL');
    final res = await http.get(url);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print('Good');
      Map<String, dynamic> data =
      new Map<String, dynamic>.from(json.decode(res.body));
      print(data);
      setState(() {
        tickid.text = data['depart_ticket'];
        remaerk.text = data['0']['check_in'] == '1' ? 'Your already checked in ' : 'Not checked in Yet';
        journy.text = '${data['0']['depart_departure']}'+' to '+'${data['0']['depart_destination']}';
        paymentid.text = data['0']['depart_payment_date'];
        checkin = data['0']['check_in'] == '1' ? true : false;
      });
    } else {
      print('Bad');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserCheckdata();
  }

  @override
  Widget build(BuildContext context) {
    return themeBody(
      body: Padding(
        padding: const EdgeInsets.only(left: 28, top: 52, right: 28),
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ticket ID',
                  style: Style,
                ),
                SizedBox(
                  height: smHeighty,
                ),
                Container(
                  child:
                      formText('Enter username here', 'User Name', tickid, 'n', true),
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellowAccent,
                ),
              ],
            ),
            SizedBox(
              height: Heighty,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Check In Remark',
                  style: Style,
                ),
                SizedBox(
                  height: smHeighty,
                ),
                Container(
                  child: formText(
                      'Enter username here', 'User Name', remaerk, 'n', true),
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellowAccent,
                ),
              ],
            ),
            SizedBox(
              height: Heighty,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Journey',
                  style: Style,
                ),
                SizedBox(
                  height: smHeighty,
                ),
                Container(
                  child:
                      formText('Enter username here', 'User Name', journy, 'n', true),
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellowAccent,
                ),
              ],
            ),
            SizedBox(
              height: Heighty,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Date',
                  style: Style,
                ),
                SizedBox(
                  height: smHeighty,
                ),
                Container(
                  child: formText(
                      'Enter username here', 'User Name', paymentid, 'n', true),
                  height: 38,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.yellowAccent,
                ),
              ],
            ),
            SizedBox(
              height: Heighty + Heighty,
            ),
            Container(
              height: 42,
              child: themeButton(
                name: checkin == false ? 'Check In' : 'Go back',
                onClick: () {
                  checkin == false ? checkinUser() :
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => scaningPage()));
                },
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Container(
              height: 42,
              child: themeButton(
                name: 'Scan Ticket',
                onClick: () {
                  // scanBarcodeagain();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: new Icon(Icons.check, color: Colors.green, size: 100,),
                        content: new Text("Check-in Successfully", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                        actions: <Widget>[
                          CupertinoDialogAction(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => scaningPage()));
                            },
                            child: Text("Go Back", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                          ),
                          CupertinoDialogAction(
                            onPressed: (){
                              Navigator.pop(context);
                              scanBarcodeagain();
                            },
                            child: Text("Scan again", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                          )
                        ],
                      )
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

Future <String> checkinUser() async {

  print('entered user checking url');
  var url = Uri.parse('${widget.checkUrL}' +'&check_in=true'+
      '&mgroup=' +
      '${widget.member_group}' +
      '&msid=' +
      '${widget.useriD}' +
      '&api_token=@McQfTjWnZr4u7x!A%D' +
      '*G-KaNdRgUkXp');
  print(url);
  print('just entered to hit URL');
  final res = await http.get(url);
  print(res.statusCode);
  if (res.statusCode == 200) {
    print('Good');
    Map<String, dynamic> data =
    new Map<String, dynamic>.from(json.decode(res.body));
    print(data);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: new Icon(Icons.check, color: Colors.green, size: 100,),
          content: new Text("Check-in Successfully", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: (){
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => scaningPage()));
              },
              child: Text("Go Back", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            ),
            CupertinoDialogAction(
              onPressed: (){
                Navigator.pop(context);
                scanBarcodeagain();
              },
              child: Text("Scan again", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            )
          ],
        )
    );
  } else {
    print('Bad');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:Colors.red,
      behavior: SnackBarBehavior.floating,
      content: Text('Something went rong try again'),
    ));
  }


}

Future<void> scanBarcodeagain() async {
    print('scanning start');
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (!mounted) return;

      setState(() {
        barcodeurl = barcode;
      });
      print(barcodeurl);
      if (barcodeurl != "-1") {
        print(barcodeurl);
        getagainUserCheckdata();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:Colors.red,
          behavior: SnackBarBehavior.floating,
          content: Text('Please scan properly'),
        ));
      }
    } on PlatformException {
      barcodeurl = 'Failed to get platform version.';
    }
  }

}

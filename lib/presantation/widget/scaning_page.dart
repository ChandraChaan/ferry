import 'package:ferryapp/presantation/common/body_theme.dart';
import 'package:ferryapp/presantation/common/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'checkinpage.dart';

class scaningPage extends StatefulWidget {
  final String useriD;
  final String member_group;
  final String username;

  scaningPage({this.useriD, this.member_group, this.username});

  @override
  _scaningPageState createState() => _scaningPageState();
}

class _scaningPageState extends State<scaningPage> {
  String barcodeurl = "mt";
  bool Scandone = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return themeBody(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 79, bottom: 27, left: 32, right: 32),
              child: Container(
                height: 262,
                // color: Colors.red,
                child: Image.asset(
                  'assets/images/ScanningTemplate.png',
                  width: 292,
                  height: 262,
                ),
                width: 292,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Container(
                  width: 352,
                  height: 57,
                  child: themeButton(
                    name: 'Scan Ticket',
                    onClick: () {
                      print('going to scan');
                      scanBarcode();
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcode() async {
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => checkInPage(
                      checkUrL: barcodeurl,
                      useriD: widget.useriD,
                      username: widget.username,
                      member_group: widget.member_group,
                    )));
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

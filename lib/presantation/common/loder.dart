import 'package:flutter/material.dart';

class loder extends StatefulWidget {
  final String loDer;

  loder({this.loDer});

  @override
  _loderState createState() => _loderState();
}

class _loderState extends State<loder> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          new CircularProgressIndicator(),
          new Text("Loading"),
        ],
      ),
    ));
  }
}

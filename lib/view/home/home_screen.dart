import 'package:flutter/material.dart';
import 'package:web_flutter/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.push(context, MaterialPageRoute(builder: (context) => new MyHomePage())),
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.black,
        ),
      ),
    );
  }
}

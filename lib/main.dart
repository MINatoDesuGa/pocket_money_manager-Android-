import 'package:flutter/material.dart';
import 'dart:async';
import 'new.dart';
import 'existing.dart';

void main() {
  runApp(MaterialApp(
    home: splash_screen(),
  )
  );
}

double h, w;

class splash_screen extends StatefulWidget {
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  bool _done = false;
  @override
  void initState() {
    getcreated().then(updateDone);
    super.initState();
    Timer(
          Duration(seconds: 2),
    () {
        if(!_done) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => New()));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Exist()),);
        }
          }
    );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.orange,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: h * 0.2,
          ),

          Center(
            child: Container(
                child: Text('  POCKET\n   MONEY\nMANAGER',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Staatliches',
                      fontSize: w * 0.2
                  ),
                )
            ),
          ),

          Container(
            child: Text('      by\n MINato',
              style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: w * 0.1
              ),
            ),
          )
        ],
      )
    );
  }

  void updateDone(bool done) {
    if(done != null) {
      this._done = done;
    }
  }
}




import 'dart:async';

import 'package:flutter/material.dart';
import 'main.dart';
import 'existing.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> created() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('acc_created', true);
}

Future<void> setname() async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('name', entered_name.text);
}

Future<void> setamount() async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('amount', int.parse(entered_amount.text));
}

Future<String> getname() async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  return (prefs.getString('name'));
}

Future<int> getamount() async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  return (prefs.getInt('amount'));
}

Future<bool> getcreated() async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  return (prefs.getBool('acc_created'));
}

class New extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: first(),
    );
  }
}

TextEditingController entered_name = new TextEditingController();
TextEditingController entered_amount = new TextEditingController();

class first extends StatefulWidget {
  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: h * 0.3,
          ),

          Container(
            child: Text('WELCOME!',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 40.0
              ),
            ),
          ),

          SizedBox(
            height: h * 0.05,
      ),

          Row(
            children: <Widget>[
              SizedBox(
                width: w * 0.1,
      ),

              Container(
                width: w * 0.8,
                child: TextField(
                  controller: entered_name,
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(),
                      hintText: 'enter your name'
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: h * 0.02,
      ),

          Row(
            children: <Widget>[
              SizedBox(
                width: w * 0.1,
              ),

              Container(
                width: w * 0.8,
                child: TextField(
                  controller: entered_amount,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(),
                      hintText: 'enter total amount'
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: h * 0.02,
          ),

          RaisedButton(
            color: Colors.grey[600],
            onPressed: () {
              setname();
              setamount();
              created();

              final snackBar = SnackBar(content: Text('Preparing...'));

              Scaffold.of(context).showSnackBar(snackBar);

              Timer(
                  Duration(seconds: 2),
                      () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Exist())));
            },
            child: Text('OK',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
          )

        ],

      ),
    );
  }
}


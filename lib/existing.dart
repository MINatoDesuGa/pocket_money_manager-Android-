import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'new.dart';

Future<void> editamount(int x) async { // Async func to handle Futures easier; or use Future.then
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('amount', x);
}

class Exist extends StatefulWidget {
  @override
  _ExistState createState() => _ExistState();
}

class _ExistState extends State<Exist> {
  Future<bool> _willPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: second(),
      ),
    );
  }
}

class second extends StatefulWidget {
  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> {
  String _name = "";
  int _amount = 0;

  @override
  void initState() {
    getname().then(updateName);
    getamount().then(updateAmount);
    super.initState();
  }

  //Edit Amount Dialog
  Future<String> editDialog(BuildContext context) {
    TextEditingController customcontroller = TextEditingController();

    return showDialog(context: context, barrierDismissible: false ,builder: (context) {
      return AlertDialog(
        title: Text('Enter new amount:'),
        content: TextField(
            controller: customcontroller
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(customcontroller.text.toString());
            },
          ),

          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('CANCEL'),
          )
        ],
      );
    });
  }

  //Spent and Earned Amount Dialog
  Future<String> spent_earnedDialog(BuildContext context) {
    TextEditingController customcontroller = TextEditingController();

    return showDialog(context: context, barrierDismissible: false ,builder: (context) {
      return AlertDialog(
        title: Text('Enter amount:'),
        content: TextField(
            controller: customcontroller
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(customcontroller.text.toString());
            },
          ),

          MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            elevation: 5.0,
            child: Text('CANCEL'),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: h * 0.06,
        ),
        
        Row(
          children: <Widget>[
            SizedBox(
              width: w * 0.04,
            ),
            
            Text('Hello ' + _name + '!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0
              ),
            ),
          ],
        ),

        SizedBox(height: h * 0.04,),

        Container(
          child: Divider(thickness: 5.0,
            color: Colors.orange,
          ),
        ),

        Row(
          children: <Widget>[
            SizedBox(width: w * 0.05,),

            Text('Current Amount = $_amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0
              ),
            ),

            SizedBox(width: w * 0.04,),

            //Edit Amount Button
            RaisedButton(
              elevation: 10.0,
              color: Colors.green[700],
              onPressed: () {
                editDialog(context).then((onValue) {
                  setState(() {
                    _amount = int.parse(onValue);
                  });
                  editamount(_amount);
                });
              },

              child: Text('EDIT',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),

        SizedBox(height: h * 0.01,),

        Container(
          child: Divider(thickness: 5.0,
            color: Colors.orange,
          ),
        ),

        SizedBox(height: h * 0.1,),

        Container(
          width: w * 0.9,
          child: Card(
            color: Colors.yellow,
            child: Column(
              children: <Widget>[
                SizedBox(height: h * 0.02,),

                Row(
                 children: <Widget>[
                   SizedBox(width: w * 0.2,),

                   Container(
                     child: Text('Spent?',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                     ),
                   ),

                   SizedBox(width: w * 0.1,),

                   ButtonTheme(
                     minWidth: 10.0,
                     child: RaisedButton(
                       elevation: 20.0,
                       color: Colors.red[700],
                       onPressed: () {
                         spent_earnedDialog(context).then((onValue) {
                           setState(() {
                             _amount -= int.parse(onValue);
                           });
                           editamount(_amount);
                         });
                       },
                      child: Icon(Icons.remove,
                        size: 40,
                      ),
                     ),
                   ),
                 ],
                ),

                SizedBox(height: h * 0.02,),

                Row(
                  children: <Widget>[
                    SizedBox(width: w * 0.2,),

                    Container(
                      child: Text('Earned?',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    SizedBox(width: w * 0.06,),

                    ButtonTheme(
                      minWidth: 10.0,
                      child: RaisedButton(
                        elevation: 20.0,
                        color: Colors.green[700],
                        onPressed: () {
                          spent_earnedDialog(context).then((onValue) {
                            setState(() {
                              _amount += int.parse(onValue);
                            });
                            editamount(_amount);
                          });
                        },
                        child: Icon(Icons.add,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.02,)
              ],
            ),
          ),
        )
      ],
    );
  }

  void updateName(String name) {
    setState(() {
      this._name = name;
    });
  }

  void updateAmount(int amount) {
    setState(() {
      this._amount = amount;
    });
  }
}




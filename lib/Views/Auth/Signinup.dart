import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zerostrix/Helpers/Helpers.dart';
import 'package:zerostrix/Helpers/session.dart';

class Signinup extends StatefulWidget {
  @override
  _SigninupState createState() => _SigninupState();
}

class _SigninupState extends State<Signinup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'ورود به حساب کاربری',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, shadows: [
                Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 1, offset: Offset.fromDirection(1, 1)),
                Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 1, offset: Offset.fromDirection(1, 2)),
                Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 1, offset: Offset.fromDirection(1, 3)),
              ]),
            ),
          ),
          width: Session().get(name: 'windowWidth'),
          decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)), color: Colors.white.withOpacity(0.05)),
          height: 200,
          padding: EdgeInsets.only(bottom: 20),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                child: roundedBigFlatButton(
                    title: 'عضویت',
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/register');
                      });
                    },
                    color: Colors.orange),
                width: Session().get(name: 'windowWidth') - 40,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: roundedBigFlatButton(
                    title: 'ورود',
                    color: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, '/login');
                      });
                    }),
                width: Session().get(name: 'windowWidth') - 40,
              ),
            ),
          ],
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

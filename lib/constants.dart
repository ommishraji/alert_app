import 'package:alert_app/addreminder.dart';
import 'package:alert_app/homescreen.dart';
import 'package:flutter/material.dart';

BottomAppBar buildBottomAppBar1(BuildContext context) {
  return BottomAppBar(
    color: Colors.pink,
    height: MediaQuery.of(context).size.height*.06,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const homescreen()));
          },
          child: const Icon(
            Icons.alarm,
            color: Colors.white,
            size: 35,
          ),
        ),
        const Flexible(
          child: VerticalDivider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const addreminder()));
          },
          child: const Icon(
            Icons.alarm_add,
            color: Colors.white70,
            size: 26,
          ),
        ),
      ],
    ),
  );
}

BottomAppBar bottombar2(BuildContext context) {
  return BottomAppBar(
    color: Colors.pink,
    height: MediaQuery.of(context).size.height*.06,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const homescreen()));
          },
          child: const Icon(
            Icons.cloud_upload,
            color: Colors.white70,
            size: 26,
          ),
        ),
        const Flexible(
          child: VerticalDivider(
            thickness: 1,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const addreminder()));
          },
          child: const Icon(
            Icons.menu_book,
            color: Colors.white,
            size: 35,
          ),
        ),
      ],
    ),
  );
}

const boxkadecoration1 = InputDecoration(
  hintText: 'Enter your ',
  hintStyle: TextStyle(
      color: Colors.grey,
    fontStyle: FontStyle.italic
  ),
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
import 'package:flutter/material.dart';

class User with ChangeNotifier{
  String uid = "";
  String type = "";

  String getType(){
    return type;
  }

  putType(String type){
    this.type = type;
  }
}
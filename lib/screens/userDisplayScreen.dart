import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/userAddScreen.dart';
import 'package:smls/screens/userDetailScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserDisplayScreen extends StatefulWidget {

  static const routeName = '/userDisplay';

  @override
  _UserDisplayScreenState createState() => _UserDisplayScreenState();
}

class _UserDisplayScreenState extends State<UserDisplayScreen> {

  List<Map<String, dynamic>> _userList = [];
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getUser.php", body: {
    });
    final jsonRespone = json.decode(response.body);
    _userList = jsonRespone['users'].cast<Map<String, dynamic>>();
    setState(() {
      isLoad = false;
    });
  }

  Widget loadWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitDoubleBounce(
          size: MediaQuery
              .of(context)
              .size
              .width * 0.2,
          color: Theme
              .of(context)
              .primaryColor,
        ),
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.05,
        ),
        Text("Please wait")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme
        .of(context)
        .primaryColor;
    final _accentColor = Theme
        .of(context)
        .accentColor;
    final _mediaQuery = MediaQuery
        .of(context)
        .size;

    Widget _getCard(String name, String type, String active, String id, Map<String,dynamic> userDetails) {
      return Card(
        margin: EdgeInsets.only(top: _mediaQuery.height*0.02),
        color: _accentColor,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: _primaryColor)),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(UserDetailScreen.routeName, arguments: userDetails);
            },
            title: Text(name,
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),),
            leading: Icon(
              FontAwesome5.user_circle, color: Color(0xffD2691E), size: 35,),
            subtitle: Text(type, style: GoogleFonts.nunitoSans(),),
            trailing: Icon(FontAwesome5.check_circle, color: Colors.green,),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: _accentColor,
        appBar: AppBar(
          backgroundColor: _primaryColor,
          title: Text(
            "Users",
            style: GoogleFonts.nunitoSans(color: Colors.white),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(UserAddScreen.routeName);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: isLoad ? loadWidget() : Container(
            padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
            child: ListView.builder(itemBuilder: (BuildContext context, index) {
              return _getCard(
                  _userList[index]["name"], _userList[index]["userAccess"],
                  _userList[index]["status"], _userList[index]["uid"], _userList[index]);
            },
              itemCount: _userList.length,
            )
        )
    );
  }
}

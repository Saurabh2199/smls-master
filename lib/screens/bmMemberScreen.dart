import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/bmMemberAddScreen.dart';
import 'package:smls/screens/bmMemberDetailScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class bmMemberScreen extends StatefulWidget {

  static const routeName = '/bmMember';

  @override
  _bmMemberScreenState createState() => _bmMemberScreenState();
}

class _bmMemberScreenState extends State<bmMemberScreen> {

  List<Map<String, dynamic>> _bmList = [];
  bool isLoad = true;
  String _mId = "";
  bool check = false;

  _getMembers()async {
    print("$_mId");
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getBhajanaMandirMembers.php", body: {
          "mandirId" :_mId
    });
    final jsonRespone = json.decode(response.body);
    _bmList = jsonRespone['bhajanamandirmembers'].cast<Map<String, dynamic>>();
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

    final _primaryColor = Theme.of(context).primaryColor;
    final _accentColor = Theme.of(context).accentColor;
    final _mediaQuery = MediaQuery.of(context).size;

    _mId = ModalRoute.of(context).settings.arguments;

    Widget _getCard(Map<String, dynamic> list){
      return Card(
        margin: EdgeInsets.only(top: _mediaQuery.height*0.02),
        color: _accentColor,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: _primaryColor)),
          child: ListTile(
            onTap: (){
              Navigator.of(context).pushNamed(bmMemberDetailScreen.routeName, arguments: list);
            },
            title: Text(list["name"], style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),),
            leading: Icon(FontAwesome5.user_circle,color: Color(0xffD2691E),size: 35,),
            subtitle: Text(list["mobileNo"],style: GoogleFonts.nunitoSans(),),
            trailing: Text("ID: ${list["memberId"]}",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500, fontSize: 18),),
          ),
        ),
      );
    }

    if(!check){
      check = true;
      _getMembers();
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Bhajana Mandali Members",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(bmMemberAddScreen.routeName, arguments: _mId);
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
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05,),
          child: ListView.builder(itemBuilder: (BuildContext context, index) {
            return _getCard(_bmList[index]);
          },
            itemCount: _bmList.length,
          )
      )
    );
  }
}

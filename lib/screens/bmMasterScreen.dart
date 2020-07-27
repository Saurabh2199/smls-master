import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/bmMasterAddScreen.dart';
import 'package:smls/screens/bmMasterDetailScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class bmMasterScreen extends StatefulWidget {

  static const routeName = '/bmMaster';

  @override
  _bmMasterScreenState createState() => _bmMasterScreenState();
}

class _bmMasterScreenState extends State<bmMasterScreen> {

  List<Map<String, dynamic>> _bmList = [];
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  _getUsers() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getBhajanaMandir.php", body: {
    });
    final jsonRespone = json.decode(response.body);
    _bmList = jsonRespone['bhajanamandir'].cast<Map<String, dynamic>>();
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

    Widget _getCard(Map<String,dynamic> bmDetails){
      return Card(
        margin: EdgeInsets.only(top: _mediaQuery.height*0.02),
        color: _accentColor,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: _primaryColor)),
          child: ListTile(
            onTap: (){
              Navigator.of(context).pushNamed(bmMasterDetailScreen.routeName, arguments: bmDetails);
            },
            title: Text(bmDetails['mandirName'], style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),),
            subtitle: Text(bmDetails['mandirAddress'].toString().toLowerCase(),style: GoogleFonts.nunitoSans(),),
            trailing: Text("ID: ${bmDetails['mandirId']}",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500, fontSize: 18),),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Bhajana Mandali Master",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(bmMasterAddScreen.routeName);
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

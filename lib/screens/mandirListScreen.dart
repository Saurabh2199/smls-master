import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smls/screens/lsDetailScreen.dart';

// ignore: camel_case_types
class mandirListScreen extends StatefulWidget {

  static const routeName = '/mandirList';

  @override
  _mandirListScreenState createState() => _mandirListScreenState();
}

class _mandirListScreenState extends State<mandirListScreen> {

  List<Map<String, dynamic>> _mandirList = [];
  bool isLoad = true;
  String mno;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getBhajanaMandir.php", body: {
    });
    final jsonRespone = json.decode(response.body);
    _mandirList = jsonRespone['bhajanamandir'].cast<Map<String, dynamic>>();
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

    Widget _getCard(Map<String,dynamic> mandirDetails){
      return Card(
        margin: EdgeInsets.only(top: _mediaQuery.height*0.02),
        color: _accentColor,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: _primaryColor)),
          child: ListTile(
            onTap: (){
              mno = mandirDetails['mandirId'];
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>lsDetailScreen(mno: mno,)));
              Navigator.pop(context,mno);
            },
            title: Text(mandirDetails['mandirName'], style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),),
            trailing: Text("ID: ${mandirDetails['mandirId']}",style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500, fontSize: 18),),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: _accentColor,
        appBar: AppBar(
          backgroundColor: _primaryColor,
          title: Text(
            "Select Mandir",
            style: GoogleFonts.nunitoSans(color: Colors.white),
          ),
        ),
        body: isLoad ? loadWidget() : Container(
            padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05,),
            child: ListView.builder(itemBuilder: (BuildContext context, index) {
              return _getCard(_mandirList[index]);
            },
              itemCount: _mandirList.length,
            )
        )
    );
  }
}

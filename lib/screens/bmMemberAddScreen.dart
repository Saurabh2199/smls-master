import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class bmMemberAddScreen extends StatefulWidget {

  static const routeName = '/bmMemberAdd';

  @override
  _bmMemberAddScreenState createState() => _bmMemberAddScreenState();
}

class _bmMemberAddScreenState extends State<bmMemberAddScreen> {

  String name = "", mobileNo = "",emailId="", address = "";
  bool _isLoad = false;
  String mId = "";

  Widget loadWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SpinKitDoubleBounce(
          size: MediaQuery.of(context).size.width * 0.2,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text("Please wait")
      ],
    );
  }

  _addMember()async{
    setState(() {
      _isLoad = true;
    });
    final response = await http.post("https://xtoinfinity.tech/sode/php/insertBhajanaMandirMember.php", body: {
      'mandirId' : mId,
      'name': name,
      'mobile': mobileNo,
      'email': emailId,
      'address': address,
    });
    print("${response.body}");
    setState(() {
      _isLoad = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
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

    mId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Add Member",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
      ),
      body: _isLoad ?loadWidget(): SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: _mediaQuery.height * 0.02,

              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                onChanged: (val){
                  name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Mobile Number"),
                onChanged: (val){
                  mobileNo = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-Mail ID"),
                onChanged: (val){
                  emailId = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  address = val;
                },
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    _addMember();
                  },
                  color: _primaryColor,
                  child: Text(
                    "ADD MEMBER",
                    style: GoogleFonts.nunitoSans(color: _accentColor),
                  ),
                ),
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

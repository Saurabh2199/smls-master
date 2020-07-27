import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smls/screens/mainScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserAddScreen extends StatefulWidget {

  static const routeName = "/userAdd";

  @override
  _UserAddScreenState createState() => _UserAddScreenState();
}

class _UserAddScreenState extends State<UserAddScreen> {

  String _accessVal = "Parayana Transaction";
  List<String> _accessList = ["Parayana Transaction", "Payment", "Prasada", "Reports", "Admin", "Zonal"];
  String _statusVal = "Active";
  List<String> _statusList = ["Active", "Inactive"];
  bool _isLoad = false;

  String _uid = "", _name = "", _pass = "", _address = "", _state = "", _district = "", _city = "", _village = "", _ward = "", _status = "", _userAccess= "";
  
  _addUser()async{
    if(_statusVal == "Active"){
      _status = "A";
    }else{
      _status = "I";
    }
    if(_accessVal == "Payment"){
      _userAccess = "PAY";
    }else if(_accessVal == "Prasada"){
      _userAccess = "PRA";
    }else if(_accessVal == "Reports"){
      _userAccess = "REP";
    }else if(_accessVal == "Admin"){
      _userAccess = "ADM";
    }else if(_accessVal == "Zonal"){
      _userAccess = "ZON";
    }else{
      _userAccess = "PAR";
    }
    setState(() {
      _isLoad = true;
    });
    await http.post("https://xtoinfinity.tech/sode/php/insertUser.php", body: {
      'uid': _uid,
      'name': _name,
      'pass':_pass,
      "address" : _address,
      'state' : _state.toUpperCase(),
      'district' : _district.toUpperCase(),
      "city" : _city.toUpperCase(),
      "village" : _village.toUpperCase(),
      "ward" : _ward.toUpperCase(),
      "status" : _status,
      "userAccess" : _userAccess,
    });
    setState(() {
      _isLoad = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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

  @override
  Widget build(BuildContext context) {

    final _primaryColor = Theme.of(context).primaryColor;
    final _accentColor = Theme.of(context).accentColor;
    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Add User",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
      ),
      body: _isLoad ?loadWidget():SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
          child: Column(
            children: [
              SizedBox(height: _mediaQuery.height*0.02,),
              TextFormField(
                decoration: InputDecoration(labelText: "User ID"),
                onChanged: (val){
                  _uid = val.toUpperCase();
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "User Name"),
                onChanged: (val){
                  _name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                onChanged: (val){
                  _pass = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  _address = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "State"),
                onChanged: (val){
                  _state = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "District"),
                onChanged: (val){
                  _district = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "City"),
                onChanged: (val){
                  _city = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Village"),
                onChanged: (val){
                  _village = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Ward"),
                onChanged: (val){
                  _ward = val;
                },
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("User Access", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _accessVal,
                onChanged: (val) {
                  setState(() {
                    _accessVal = val;
                  });
                },
                items: _accessList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("User Status", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _statusVal,
                onChanged: (val) {
                  setState(() {
                    _statusVal = val;
                  });
                },
                items: _statusList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    _addUser();
                  },
                  color: _primaryColor,
                  child: Text("ADD USER", style: GoogleFonts.nunitoSans(color: _accentColor),),
                ),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
            ],
          ),
        ),
      ),
    );
  }
}

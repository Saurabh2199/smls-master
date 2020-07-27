import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/userAddScreen.dart';
import 'package:http/http.dart' as http;
import 'package:smls/screens/mainScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserDetailScreen extends StatefulWidget {
  static const routeName = '/userDetail';

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  Map<String, dynamic> userDetails;
  bool _check = false;
  bool _isLoad = false;

  String _accessVal = "Parayana Transaction";
  List<String> _accessList = ["Parayana Transaction", "Payment", "Prasada", "Reports", "Admin", "Zonal"];
  String _statusVal = "Active";
  List<String> _statusList = ["Active", "Inactive"];
  String _uid = "", _name = "", _pass = "", _address = "", _state = "", _district = "", _city = "", _village = "", _ward = "", _status = "", _userAccess= "";

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

  _updateUser()async{
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
    final response = await http.post("https://xtoinfinity.tech/sode/php/updateUser.php", body: {
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
    print("${response.body}");
    setState(() {
      _isLoad = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  _deleteUser()async{
    setState(() {
      _isLoad = true;
    });
    final response = await http.post("https://xtoinfinity.tech/sode/php/deleteUser.php", body: {
      'uid': _uid,
    });
    print("${response.body}");
    setState(() {
      _isLoad = false;
    });
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).primaryColor;
    final _accentColor = Theme.of(context).accentColor;
    final _mediaQuery = MediaQuery.of(context).size;
    userDetails = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    if(!_check){
      _check = true;
      _uid = userDetails['uid'];
      _name = userDetails['name'];
      _pass = userDetails['password'];
      _address = userDetails['address'];
      _state = userDetails['state'];
      _district = userDetails['district'];
      _city = userDetails['city'];
      _village = userDetails['village'];
      _ward = userDetails['ward'];
      _status = userDetails['status'];
      _userAccess = userDetails['userAccess'];
      String _access = userDetails["userAccess"];
      String active = userDetails["active"];
      if(_access == "PAY"){
        _accessVal = "Payment";
      }else if(_access == "PRA"){
        _accessVal = "Prasada";
      }else if(_access == "REP"){
        _accessVal = "Reports";
      }else if(_access == "REP"){
        _accessVal = "Admin";
      }else if(_access == "REP"){
        _accessVal = "Zonal";
      }else{
        _accessVal = "Parayana Transaction";
      }
      if(active == "I"){
        _statusVal = "Inactive";
      }
      setState(() {
      });
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "User Details",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
            child: InkWell(
              onTap: () {
                _deleteUser();
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _isLoad ? loadWidget():SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
          child: Column(
            children: [
              SizedBox(height: _mediaQuery.height*0.02,),
              TextFormField(
                initialValue: userDetails["uid"],
                onChanged: (val){
                  _uid = val;
                },
                decoration: InputDecoration(labelText: "User ID"),
                enabled: false,
              ),
              TextFormField(
                initialValue: userDetails["name"],
                decoration: InputDecoration(labelText: "User Name"),
                onChanged: (val){
                  print("$val");
                  _name = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["password"],
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextFormField(
                initialValue: userDetails["address"],
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  _address = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["state"],
                decoration: InputDecoration(labelText: "State"),
                onChanged: (val){
                  _state = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["district"],
                decoration: InputDecoration(labelText: "District"),
                onChanged: (val){
                  _district = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["city"],
                decoration: InputDecoration(labelText: "City"),
                onChanged: (val){
                  _city = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["village"],
                decoration: InputDecoration(labelText: "Village"),
                onChanged: (val){
                  _village = val;
                },
              ),
              TextFormField(
                initialValue: userDetails["ward"],
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
                    _updateUser();
                  },
                  color: _primaryColor,
                  child: Text("UPDATE USER", style: GoogleFonts.nunitoSans(color: _accentColor),),
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

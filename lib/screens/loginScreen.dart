import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:smls/screens/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {

  static const routeName = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _uid = "", _password = "";
  bool _isLoad = false;

  _login() async{
    if(_uid == "" || _password == ""){

    }else {
      _uid = _uid.toUpperCase().trim();
      _password = _password.trim();
      setState(() {
        _isLoad = true;
      });
      print("$_uid, $_password");
      final response = await http.post(
          "https://xtoinfinity.tech/sode/php/login.php", body: {
        'uid': _uid,
        'password': _password,
      });
      print("${response.body}");
      setState(() {
        _isLoad = false;
      });
      if(response.body.toString() == "no"){

      }else{
        SharedPreferences _prefs =await SharedPreferences.getInstance();
        _prefs.setString("type", response.body.toString());
        _prefs.setString("uid", _uid);
        Navigator.of(context).pushNamedAndRemoveUntil(MainScreen.routeName, (route) => false);
      }
    }
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

    final _primaryColor = Theme
        .of(context)
        .primaryColor;
    final _mediaQuery = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .accentColor,
      body: _isLoad?loadWidget():Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login Screen", style: GoogleFonts.nunitoSans(fontSize: 23,
                color: _primaryColor,
                fontWeight: FontWeight.w700),),
            SizedBox(height: _mediaQuery.height * 0.05,),
            TextField(decoration: InputDecoration(hintText: "Username",),
              style: GoogleFonts.nunitoSans(color: _primaryColor),onChanged: (val){_uid = val;},),
            SizedBox(height: _mediaQuery.height * 0.02,),
            TextField(decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              onChanged: (val){
                _password = val;
              },
              style: GoogleFonts.nunitoSans(color: _primaryColor),),
            SizedBox(height: _mediaQuery.height * 0.05,),
            RaisedButton(
              color: _primaryColor,
              onPressed: () {
                _login();
              },
              child: Text("Login", style: GoogleFonts.nunito(
                  color: Colors.white, fontWeight: FontWeight.w700),),
            )
          ],
        ),
      ),
    );
  }
}

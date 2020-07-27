import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smls/screens/loginScreen.dart';
import 'package:smls/screens/mainScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {

  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkUser();
  }

  _checkUser() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_prefs.containsKey("type")){
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    }else{
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
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
      ),
    );
  }
}

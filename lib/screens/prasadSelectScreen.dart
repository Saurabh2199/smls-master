import 'package:flutter/material.dart';
import 'package:smls/screens/fPrasadDisplayScreen.dart';
import 'package:smls/screens/rPrasadDisplayScreen.dart';

class PrasadSelectScreen extends StatefulWidget {

  static const routeName = 'prasadSelect';

  @override
  _PrasadSelectScreenState createState() => _PrasadSelectScreenState();
}

class _PrasadSelectScreenState extends State<PrasadSelectScreen> {
  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Select Prasada Status', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 22, fontWeight: FontWeight.w700),),
            SizedBox(height: _mediaQuery.height*0.04,),
            Container(
              width: _mediaQuery.width*0.7,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(FPrasadDisplayScreen.routeName);
                },
                color: Theme.of(context).primaryColor,
                child: Text("First Time Prasadam", style: TextStyle(color: Theme.of(context).accentColor),),
              ),
            ),
            SizedBox(height: _mediaQuery.height*0.02,),
            Container(
              width: _mediaQuery.width*0.7,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(RPrasadDisplayScreen.routeName);
                },
                color: Theme.of(context).primaryColor,
                child: Text("Reissue Prasadam", style: TextStyle(color: Theme.of(context).accentColor),),
              ),
            )
          ],
        ),
      ),
    );
  }
}

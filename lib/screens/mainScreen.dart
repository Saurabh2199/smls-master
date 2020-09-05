import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/bmMasterScreen.dart';
import 'package:smls/screens/excelExport.dart';
import 'package:smls/screens/lsScreen.dart';
import 'package:smls/screens/prasadSelectScreen.dart';
import 'package:smls/screens/userDisplayScreen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {

    final _primaryColor = Theme.of(context).primaryColor;
    final _accentColor = Theme.of(context).accentColor;
    final _mediaQuery = MediaQuery.of(context).size;

    Widget _getCard(String title, IconData icon, Function onClick){
      return Card(
        color: _accentColor,
        elevation: 3,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){
              onClick();
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD2691E))
              ),
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width*0.05, vertical: _mediaQuery.height*0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.nunitoSans(color: _primaryColor, fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  Icon(icon, color: Color(0xffD2691E),),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Laxmi Shobhane App",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getCard("Users", FontAwesome5.user_circle, (){
              Navigator.of(context).pushNamed(UserDisplayScreen.routeName);
            }),
            _getCard("Bhajan Mandali", FontAwesome5.object_group, (){
              Navigator.of(context).pushNamed(bmMasterScreen.routeName);
            }),
            _getCard("Laxmi Shobhane Details", FontAwesome5.comment, (){
              Navigator.of(context).pushNamed(lsScreen.routeName);
            }),
            _getCard("Prasadam Update", FontAwesome5.calendar_check, (){
              Navigator.of(context).pushNamed(PrasadSelectScreen.routeName);
            }),
            _getCard("Excel Export", FontAwesome5.address_book, (){
              Navigator.of(context).pushNamed(ExcelExportScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
}

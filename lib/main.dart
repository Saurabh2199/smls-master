import 'package:flutter/material.dart';
import 'package:smls/providers/user.dart';
import 'package:smls/screens/bmMasterAddScreen.dart';
import 'package:smls/screens/bmMasterDetailScreen.dart';
import 'package:smls/screens/bmMemberAddScreen.dart';
import 'package:smls/screens/bmMemberDetailScreen.dart';
import 'package:smls/screens/bmMemberScreen.dart';
import 'package:smls/screens/bmMasterScreen.dart';
import 'package:smls/screens/controlScreen.dart';
import 'package:smls/screens/loginScreen.dart';
import 'package:smls/screens/lsAddScreen.dart';
import 'package:smls/screens/lsDetailScreen.dart';
import 'package:smls/screens/lsScreen.dart';
import 'package:smls/screens/mainScreen.dart';
import 'package:smls/screens/fPrasadDisplayScreen.dart';
import 'package:smls/screens/mandirListScreen.dart';
import 'package:smls/screens/prasadSelectScreen.dart';
import 'package:smls/screens/rPrasadDisplayScreen.dart';
import 'package:smls/screens/splashScreen.dart';
import 'package:smls/screens/userAddScreen.dart';
import 'package:smls/screens/userDetailScreen.dart';
import 'package:smls/screens/userDisplayScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => User(),
        ),
      ],
      child: MaterialApp(
        title: 'SMLS',
        theme: ThemeData(
          accentColor: Color(0xffFFF8DC),
          primaryColor: Color(0xff8B4513),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          LoginScreen.routeName:(ctx)=>LoginScreen(),
          MainScreen.routeName:(ctx)=>MainScreen(),
          ControlScreen.routeName:(ctx)=>ControlScreen(),
          bmMasterScreen.routeName:(ctx)=>bmMasterScreen(),
          bmMemberScreen.routeName:(ctx)=>bmMemberScreen(),
          UserDisplayScreen.routeName:(ctx)=>UserDisplayScreen(),
          bmMasterDetailScreen.routeName:(ctx)=>bmMasterDetailScreen(),
          bmMemberDetailScreen.routeName:(ctx)=>bmMemberDetailScreen(),
          UserDetailScreen.routeName:(ctx)=>UserDetailScreen(),
          UserAddScreen.routeName:(ctx)=>UserAddScreen(),
          bmMasterAddScreen.routeName:(ctx)=>bmMasterAddScreen(),
          bmMemberAddScreen.routeName:(ctx)=>bmMemberAddScreen(),
          lsScreen.routeName:(ctx)=>lsScreen(),
          lsDetailScreen.routeName:(ctx)=>lsDetailScreen(),
          lsAddScreen.routeName:(ctx)=>lsAddScreen(),
          PrasadSelectScreen.routeName:(ctx)=>PrasadSelectScreen(),
          FPrasadDisplayScreen.routeName:(ctx)=>FPrasadDisplayScreen(),
          RPrasadDisplayScreen.routeName:(ctx)=>RPrasadDisplayScreen(),
          mandirListScreen.routeName:(ctx)=>mandirListScreen(),
        },
      ),
    );
  }
}

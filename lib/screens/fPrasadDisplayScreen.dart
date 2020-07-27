import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FPrasadDisplayScreen extends StatefulWidget {
  static const routeName = 'fPrasadDisplay';

  @override
  _FPrasadDisplayScreenState createState() => _FPrasadDisplayScreenState();
}

class _FPrasadDisplayScreenState extends State<FPrasadDisplayScreen> {
  List<Map<String, dynamic>> _lsList = [];
  bool isLoad = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrasadam();
  }

  _getPrasadam() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getFirstPrasadam.php",
        body: {});
    final jsonRespone = json.decode(response.body);
    _lsList = jsonRespone['prasadam'].cast<Map<String, dynamic>>();
    setState(() {
      isLoad = false;
    });
  }

  _closePrasadam(String id)async {
    setState(() {
      isLoad = true;
    });
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/closePrasadam.php",
        body: {
          'trnId' : id,
        });
    setState(() {
      isLoad = false;
    });
    print(response.body);
    Navigator.of(context).pop();
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

  showAlertDialog(BuildContext context, String id) {
    AlertDialog alert = AlertDialog(
      title: Text("Close Transaction"),
      content: Text("Click on the button below to close the transaction"),
      actions: [
        FlatButton(
          child: Text("Proceed", style: TextStyle(color: Theme.of(context).primaryColor),),
          onPressed: () {
            Navigator.of(context).pop();
            _closePrasadam(id);
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).primaryColor;
    final _accentColor = Theme.of(context).accentColor;
    final _mediaQuery = MediaQuery.of(context).size;

    Widget _getCard(Map<String, dynamic> lsDetails) {
      return Card(
        margin: EdgeInsets.only(top: _mediaQuery.height * 0.02),
        color: _accentColor,
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: _primaryColor)),
          child: ListTile(
            onTap: () {
              showAlertDialog(context,lsDetails['trnId']);
            },
            title: Text(
              lsDetails['inchargeName'],
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              lsDetails['inchrageMobile'].toString().toLowerCase(),
              style: GoogleFonts.nunitoSans(),
            ),
            trailing: Text(
              "Amt: ${lsDetails['payAmt']}",
              style: GoogleFonts.nunitoSans(
                  fontWeight: FontWeight.w500, fontSize: 18),
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
          "First Time Prasadam",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
      ),
      body: isLoad
          ? loadWidget()
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: _mediaQuery.width * 0.05,
              ),
              child: ListView.builder(
                itemBuilder: (BuildContext context, index) {
                  return _getCard(_lsList[index]);
                },
                itemCount: _lsList.length,
              ),
            ),
    );
  }
}

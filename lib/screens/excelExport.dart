import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ExcelExportScreen extends StatefulWidget {
  static const routeName = '/excelExport';
  @override
  _ExcelExportScreenState createState() => _ExcelExportScreenState();
}

class _ExcelExportScreenState extends State<ExcelExportScreen> {
  List<Map<String, dynamic>> _bmList = [];
  List<Map<String, dynamic>> _lsList = [];
  bool isLoad = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
    isLoad=true;
    _getlsUsers();
  }

  _getUsers() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getBhajanaMandir.php",
        body: {});
    final jsonRespone = json.decode(response.body);
    _bmList = jsonRespone['bhajanamandir'].cast<Map<String, dynamic>>();
    setState(() {
      isLoad = false;
    });
  }

  _getlsUsers() async {
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/getLaxmiShobhane.php",
        body: {});
    final jsonRespone = json.decode(response.body);
    _lsList = jsonRespone['laxmishobhane'].cast<Map<String, dynamic>>();
    setState(() {
      isLoad = false;
    });
  }

  _export(BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    var excel = Excel.createExcel();
    Sheet sheet1 = excel['Mandir Details'];
    await excel.setDefaultSheet('Mandir Details');
    excel.delete('Sheet1');
    Sheet sheet2 = excel['Laxmi Shobhane Details'];
    sheet1.appendRow(['Mandir Id','Mandir Name','Mandir Address','Register Date','Start Date','End Date','State','District','Taluk','Area','Location','Country Code','Overseas','Pincode','MobileNo','Telephone','Email','Incharge Person 1','Incharge Address 1','Incharge Mobile 1','Incharge Email 1','Incharge Person 2','Incharge Address 2','Incharge Mobile 2','Incharge Email 2','Status','No of Renewal']);
    sheet2.appendRow(['Transaction Id','Mandir ID','Mandir Name','Pooja Date','Payment Type','Payment Amount','Incharge Name','Incharge Mobile Number','Incharge Address','Pooja Owner Name','Pooja Owner Mobile Number','Pooja Owner Address','Total Prasadam','Transaction Type','Transaction Status','Receipt Number','Pay Invoice Number','Bank Detail','Payment Date','Prasadam Count','Prasadam Date']);
    _bmList.map((e) {
      sheet1
          .appendRow([ e['mandirId'],e['mandirName'], e['mandirAddress'], e['registerDate'], e['startDate'], e['endDate'],e['state'], e['district'], e['taluk'], e['area'],e['location'], e['countryCode'], e['overSeas'], e['pincode'],e['mobileNo'], e['telephone'], e['email'], e['inchargePerson'],e['inchargeAddress'], e['inchargeMobile'], e['inchargeEmail'], e['inchargePerson1'],e['inchargeAddress1'],e['inchargeMobile1'], e['inchargeEmail1'], e['status'], e['noOfRenewal']]);
    }).toList();
    _lsList.map((e) {
      sheet2
          .appendRow([e['trnId'],e['mandirId'],e['mandirName'],e['poojaDate'], e['paymentType'], e['payAmt'],e['inchargeName'], e['inchrageMobile'], e['inchargeAddress'],e['poojaOwnerName'], e['poojaOwnerMobile'], e['poojaOwnerAddress'],e['totalPrasadam'], e['trnType'], e['status'], e['recieptNo'], e['payInvoiceNo'],e['bankDetail'], e['paymentDate'], e['prasadamReceived'],e['prasadamCount'], e['prasadamDate'] ]);
    }).toList();
    excel.encode().then((onValue) {
      File(join("${directory.path}/excel.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
    _showSnackBar(context);
  }

  _showSnackBar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Excel has been exported",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Excel Export",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
      ),
      body:
      Center(
        child: Container(
          width: 200,
          child: RaisedButton(
            onPressed: () {
              _export(context);
            },
            color: Theme.of(context).primaryColor,
            child: Text(
              "Export",
              style: GoogleFonts.nunitoSans(color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }
}

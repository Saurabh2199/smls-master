import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smls/screens/bmMemberScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class bmMasterDetailScreen extends StatefulWidget {
  static const routeName = '/bmMasterDetail';

  @override
  _bmMasterDetailScreenState createState() => _bmMasterDetailScreenState();
}

class _bmMasterDetailScreenState extends State<bmMasterDetailScreen> {

  bool check = false;
  bool _isLoad = false;

  String _typeVal = "Bhajan Mandali";
  List<String> _typeList = ["Bhajan Mandali", "Main (Sode)", "Others"];
  String _locVal = "India";
  List<String> _locList = ["India", "Overseas"];
  String _stateVal = "Karnataka";
  List<String> _stateList = ["Karnataka", "Goa"];
  String _districtVal = "Udupi";
  List<String> _districtList = ["Udupi", "Mangalore"];
  Map<String, dynamic> _bmDetails;

  String registerNo = "", mandirId = "", mandaliType = "", mandirName = "", mandirAddress = "", registerDate = "", startDate = "",
      endDate = "", state = "", district = "", taluk = "", area = "", location = "", countryCode = "", overSeas = "", pincode  ="",
      mobileNo = "", telephone = "", email = "", inchargePerson = "", inchargeAddress = "", inchargeMobile = "", inchargeEmail = "",
      inchargePerson1 = "", inchargeAddress1 = "", inchargeMobile1 = "", inchargeEmail1 = "", status = "", noOfRenewal = "",
      id = "";

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context, String date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    if (picked != null && picked != selectedDate) {
      if(date == "1"){
        registerDate = picked.day.toString() + "/" + picked.month.toString() + "/" +
            picked.year.toString();
      }else if(date == "2"){
        startDate = picked.day.toString() + "/" + picked.month.toString() + "/" +
            picked.year.toString();
      }else{
        endDate = picked.day.toString() + "/" + picked.month.toString() + "/" +
            picked.year.toString();
      }
      setState(() {

      });
    }
  }

  _updateDetails()async{
    setState(() {
      _isLoad = true;
    });
    mandaliType = _typeVal.substring(0,1);
    if(_locVal == "India"){
      overSeas = "N";
    }else{
      overSeas = "Y";
    }
    if(_stateVal == "Karnataka"){
      state = "Karnataka";
    }else{
      state = "Goa";
    }
    if(_districtVal == "Udupi"){
      district = "Udupi";
    }else{
      district = "Mangalore";
    }


    final response = await http.post("https://xtoinfinity.tech/sode/php/updateBhajanaMandir.php", body: {
      "registerNo" : registerNo,
      "mandirId" : mandirId,
      "mandaliType" : mandaliType,
      "mandirName" : mandirName,
      "mandirAddress" : mandirAddress,
      "registerDate" : registerDate,
      "startDate" : startDate,
      "endDate" : endDate,
      "state" : state,
      "district" : district,
      "taluk" : taluk,
      "area" : area,
      "location" : location,
      "countryCode" : countryCode,
      "overSeas" : overSeas,
      "pincode" : pincode,
      "mobileNo" : mobileNo,
      "telephone" : telephone,
      "email" : email,
      "inchargePerson" : inchargePerson,
      "inchargeAddress" : inchargeAddress,
      "inchargeMobile" : inchargeMobile,
      "inchargeEmail" : inchargeEmail,
      "inchargePerson1" : inchargePerson1,
      "inchargeAddress1" : inchargeAddress1,
      "inchargeMobile1" : inchargeMobile1,
      "inchargeEmail1" : inchargeEmail1,
      "status" : status,
      "noOfRenewal" : noOfRenewal,
    });
    print("${response.body}");
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

    _bmDetails = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    if(!check){
      check = true;
      registerNo = _bmDetails["registerNo"];
      mandirId = _bmDetails["mandirId"];
      mandaliType = _bmDetails["mandaliType"];
      mandirName = _bmDetails["mandirName"];
      mandirAddress = _bmDetails["mandirAddress"];
      registerDate = _bmDetails["registerDate"];
      startDate = _bmDetails["startDate"];
      endDate = _bmDetails["endDate"];
      state = _bmDetails["state"];
      district = _bmDetails["district"];
      taluk = _bmDetails["taluk"];
      area = _bmDetails["area"];
      location = _bmDetails["location"];
      countryCode = _bmDetails["countryCode"];
      overSeas = _bmDetails["overSeas"];
      pincode = _bmDetails["pincode"];
      mobileNo = _bmDetails["mobileNo"];
      telephone = _bmDetails["telephone"];
      email = _bmDetails["email"];
      inchargePerson = _bmDetails["inchargePerson"];
      inchargeAddress = _bmDetails["inchargeAddress"];
      inchargeMobile = _bmDetails["inchargeMobile"];
      inchargeEmail = _bmDetails["inchargeEmail"];
      inchargePerson1 = _bmDetails["inchargePerson1"];
      inchargeAddress1 = _bmDetails["inchargeAddress1"];
      inchargeMobile1 = _bmDetails["inchargeMobile1"];
      inchargeEmail1 = _bmDetails["inchargeEmail1"];
      status = _bmDetails["status"];
      noOfRenewal = _bmDetails["noOfRenewal"];
      id = _bmDetails['id'];
      if(mandaliType == 'O'){
        _typeVal = "Others";
      }else if(mandaliType == 'M'){
        _typeVal = "Main (Sode)";
      }

      if(overSeas == 'Y'){
        _locVal = "Overseas";
      }
      if(state == 'Goa'){
        _stateVal = "Goa";
      }
      else{
        _stateVal = "Karnataka";
      }
      if(district == 'Mangalore'){
        _districtVal = "Mangalore";
      }
      else{
        _districtVal = "Udupi";
      }
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Bhajana Mandali Details",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: _mediaQuery.width * 0.05),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(bmMemberScreen.routeName, arguments: id);
              },
              child: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _isLoad?loadWidget(): SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              TextFormField(
                initialValue: mandirId,
                decoration: InputDecoration(labelText: "ID"),
                enabled: false,
              ),
              TextFormField(
                initialValue: mandirName,
                decoration: InputDecoration(labelText: "Name"),
                onChanged: (val){
                  mandirName = val;
                },
              ),
              TextFormField(
                initialValue: mandirAddress,
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  mandirAddress = val;
                },
              ),
              TextFormField(
                initialValue: email,
                decoration: InputDecoration(labelText: "E-Mail"),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    _selectDate(context,"!");
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: _mediaQuery.width * 0.01,
                        vertical: _mediaQuery.height * 0.01),
                    decoration:
                        BoxDecoration(border: Border.all(color: _primaryColor)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Registration Date: $registerDate",
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                ),
              ),
              TextFormField(
                initialValue: registerNo,
                decoration: InputDecoration(labelText: "Reg. no."),
                onChanged: (val){
                  registerNo = val;
                },
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    _selectDate(context,"2");
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: _mediaQuery.width * 0.01,
                        vertical: _mediaQuery.height * 0.01),
                    decoration:
                    BoxDecoration(border: Border.all(color: _primaryColor)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Start Date: $startDate",
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){
                    _selectDate(context,"3");
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: _mediaQuery.width * 0.01,
                        vertical: _mediaQuery.height * 0.01),
                    decoration:
                    BoxDecoration(border: Border.all(color: _primaryColor)),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "End Date: $endDate",
                      style: GoogleFonts.nunitoSans(),
                    ),
                  ),
                ),
              ),
              TextFormField(
                initialValue: telephone,
                decoration: InputDecoration(labelText: "Telephone"),
                onChanged: (val){
                  telephone = val;
                },
              ),
              TextFormField(
                initialValue: mobileNo,
                decoration: InputDecoration(labelText: "Mobile Number"),
                onChanged: (val){
                  mobileNo = val;
                },
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("Bhajan Mandali Type", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _typeVal,
                onChanged: (val) {
                  setState(() {
                    _typeVal = val;
                  });
                },
                items: _typeList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("Overseas/India", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _locVal,
                onChanged: (val) {
                  setState(() {
                    _locVal = val;
                  });
                },
                items: _locList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("State", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _stateVal,
                onChanged: (val) {
                  setState(() {
                    _stateVal = val;
                  });
                },
                items: _stateList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("District", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              DropdownButton(
                iconEnabledColor: Color(0xffD2691E),
                isExpanded: true,
                value: _districtVal,
                onChanged: (val) {
                  setState(() {
                    _districtVal = val;
                  });
                },
                items: _districtList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("Bhajan Mandali Incharge-1", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              TextFormField(
                initialValue: inchargePerson,
                decoration: InputDecoration(labelText: "Incharge Name"),
                onChanged: (val){
                  inchargePerson = val;
                },
              ),
              TextFormField(
                initialValue: inchargeMobile,
                decoration: InputDecoration(labelText: "Mobile Number"),
                onChanged: (val){
                  inchargeMobile = val;
                },
              ),
              TextFormField(
                initialValue: inchargeEmail,
                decoration: InputDecoration(labelText: "E-Mail"),
                onChanged: (val){
                  inchargeEmail = val;
                },
              ),
              TextFormField(
                initialValue: inchargeAddress,
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  inchargeAddress = val;
                },
              ),
              SizedBox(height: _mediaQuery.height*0.02,),
              Align(alignment: Alignment.bottomLeft,child: Text("Bhajan Mandali Incharge-2", style: GoogleFonts.nunitoSans(color: Color(0xffD2691E)),)),
              TextFormField(
                initialValue: inchargePerson1,
                decoration: InputDecoration(labelText: "Incharge Name"),
                onChanged: (val){
                  inchargePerson1 = val;
                },
              ),
              TextFormField(
                initialValue: inchargeMobile1,
                decoration: InputDecoration(labelText: "Mobile Number"),
                onChanged: (val){
                  inchargeMobile1 = val;
                },
              ),
              TextFormField(
                initialValue: inchargeEmail1,
                decoration: InputDecoration(labelText: "E-Mail"),
                onChanged: (val){
                  inchargeEmail1 = val;
                },
              ),
              TextFormField(
                initialValue: inchargeAddress1,
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  inchargeAddress1 = val;
                },
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    _updateDetails();
                  },
                  color: _primaryColor,
                  child: Text(
                    "UPDATE DETAILS",
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

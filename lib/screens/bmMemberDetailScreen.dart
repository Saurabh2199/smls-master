import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class bmMemberDetailScreen extends StatefulWidget {

  static const routeName = '/bmMemberDetail';

  @override
  _bmMemberDetailScreenState createState() => _bmMemberDetailScreenState();
}

class _bmMemberDetailScreenState extends State<bmMemberDetailScreen> {

  Map<String,dynamic> _memberDetail;
  String name = "", mobileNo = "",emailId="", address = "";

  bool check = false;
  bool _isLoad = false;

  _updateMember()async{
    setState(() {
      _isLoad = true;
    });
    final response = await http.post("https://xtoinfinity.tech/sode/php/updateBhajanaMandirMember.php", body: {
      'mandirId': _memberDetail['mandirId'],
      'memberId': _memberDetail['memberId'],
      'name': name,
      'mobileNo': mobileNo,
      'dob': _memberDetail['dob'],
      'email': emailId,
      'address': address,
      'status': _memberDetail['status'],
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

  _deleteUser()async{
    setState(() {
      _isLoad = true;
    });
    final response = await http.post("https://xtoinfinity.tech/sode/php/deleteBhajanaMandirMember.php", body: {
      'memberId': _memberDetail['memberId'],
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
    _memberDetail = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;

    if(!check){
      check = true;
      name = _memberDetail['name'];
      mobileNo = _memberDetail['mobileNo'];
      emailId = _memberDetail['emailId'];
      address = _memberDetail['address'];
      setState(() {

      });
    }

    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "Bhajana Mandali Member Details",
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
          padding: EdgeInsets.symmetric(horizontal: _mediaQuery.width*0.05),
          child: Column(
            children: [
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: "Name"),
                onChanged: (val){
                  name = val;
                },
              ),
              TextFormField(
                initialValue: mobileNo,
                decoration: InputDecoration(labelText: "Mobile Number"),
                onChanged: (val){
                  mobileNo = val;
                },
              ),
              TextFormField(
                initialValue: emailId,
                decoration: InputDecoration(labelText: "E-Mail ID"),
                onChanged: (val){
                  emailId = val;
                },
              ),
              TextFormField(
                initialValue: address,
                decoration: InputDecoration(labelText: "Address"),
                onChanged: (val){
                  address = val;
                },
              ),
              SizedBox(
                height: _mediaQuery.height * 0.02,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    _updateMember();
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

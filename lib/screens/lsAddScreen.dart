import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class lsAddScreen extends StatefulWidget {
  static const routeName = '/lsAdd';

  @override
  _lsAddScreenState createState() => _lsAddScreenState();
}

class _lsAddScreenState extends State<lsAddScreen> {
  bool _isLoad = false;
  String _paytypeVal = "CASH";
  List<String> _paytypeList = ["CASH", "NEFT", "CRCARD", "UPI"];
  String _trntypeVal = "Bhajana Mandali";
  List<String> _trntypeList = [
    "Bhajana Mandali",
    "Direct (Sode)",
    "Self/Others"
  ];
  String _paystatusVal = "Donation Pending";
  List<String> _paystatusList = [
    "Donation Pending",
    "Close (Prasadam Delivered)",
    "Donation Done"
  ];
  String _prasadVal = "Y";
  List<String> _parasadList = ["Y", "N"];
  String trnId = "",
      mandirId = "",
      poojaDate = "",
      paymentType = "",
      payAmt = "",
      inchargeName = "",
      inchrageMobile = "",
      inchargeAddress = "",
      poojaOwnerName = "",
      poojaOwnerMobile = "",
      poojaOwnerAddress = "",
      totalPrasadam = "",
      trnType = "",
      status = "",
      recieptNo = "",
      payInvoiceNo = "",
      bankDetail = "",
      paymentDate = "",
      nakshatra = "",
      gotra = "",
      prasadamReceived = "",
      prasadamCount = "",
      prasadamDate = "",
      id = "";

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context, String date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      print(selectedDate);
      if (date == "1") {
        poojaDate = picked.day.toString() +
            "/" +
            picked.month.toString() +
            "/" +
            picked.year.toString();
      } else if (date == "2") {
        paymentDate = picked.day.toString() +
            "/" +
            picked.month.toString() +
            "/" +
            picked.year.toString();
      } else {
        prasadamDate = picked.day.toString() +
            "/" +
            picked.month.toString() +
            "/" +
            picked.year.toString();
      }
      setState(() {});
    }
  }

  _addParayana() async {
    setState(() {
      _isLoad = true;
    });
    if (_paystatusVal == "Donation Pending") {
      status = "A";
    } else if (_paystatusVal == "Donation Done") {
      status = "P";
    } else if (_paystatusVal == "Close (Prasadam Delivered)") {
      status = "C";
    }
    if (_trntypeVal == "Bhajana Mandali") {
      status = "M";
    } else if (_trntypeVal == "Direct (Sode)") {
      status = "D";
    } else if (_trntypeVal == "Self/Others") {
      status = "O";
    }
    final response = await http.post(
        "https://xtoinfinity.tech/sode/php/insertLaxmiShobhane.php",
        body: {
          "trnId": trnId,
          "mandirId": mandirId,
          "poojaDate": poojaDate,
          "paymentType": paymentType,
          "payAmt": payAmt,
          "inchargeName": inchargeName,
          "inchrageMobile": inchrageMobile,
          "inchargeAddress": inchargeAddress,
          "poojaOwnerName": poojaOwnerName,
          "poojaOwnerMobile": poojaOwnerMobile,
          "poojaOwnerAddress": poojaOwnerAddress,
          "totalPrasadam": totalPrasadam,
          "trnType": trnType,
          "status": status,
          "recieptNo": recieptNo,
          "payInvoiceNo": payInvoiceNo,
          "bankDetail": bankDetail,
          "paymentDate": paymentDate,
          "nakshatra": nakshatra,
          "gotra": gotra,
          "prasadamReceived": prasadamReceived,
          "prasadamCount": prasadamCount,
          "prasadamDate": prasadamDate,
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
    return Scaffold(
      backgroundColor: _accentColor,
      appBar: AppBar(
        backgroundColor: _primaryColor,
        title: Text(
          "ADD PARAYANA",
          style: GoogleFonts.nunitoSans(color: Colors.white),
        ),
      ),
      body: _isLoad
          ? loadWidget()
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: _mediaQuery.width * 0.05),
                child: Column(
                  children: [
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Transaction ID"),
                      onChanged: (val) {
                        trnId = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "ID"),
                      onChanged: (val) {
                        mandirId = val;
                      },
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _selectDate(context, "1");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: _mediaQuery.width * 0.01,
                              vertical: _mediaQuery.height * 0.01),
                          decoration: BoxDecoration(
                              border: Border.all(color: _primaryColor)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pooja Date: $poojaDate",
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Payment Type",
                          style:
                              GoogleFonts.nunitoSans(color: Color(0xffD2691E)),
                        )),
                    DropdownButton(
                      iconEnabledColor: Color(0xffD2691E),
                      isExpanded: true,
                      value: _paytypeVal,
                      onChanged: (val) {
                        setState(() {
                          _paytypeVal = val;
                        });
                      },
                      items: _paytypeList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Payment Amount"),
                      onChanged: (val) {
                        payAmt = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Incharge Name"),
                      onChanged: (val) {
                        inchargeName = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Incharge Mobile Number"),
                      onChanged: (val) {
                        inchrageMobile = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Incharge Address"),
                      onChanged: (val) {
                        inchargeAddress = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Pooja Owner Name"),
                      onChanged: (val) {
                        poojaOwnerName = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Pooja Owner Mobile Number"),
                      onChanged: (val) {
                        poojaOwnerMobile = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Pooja Owner Address"),
                      onChanged: (val) {
                        poojaOwnerAddress = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Total Prasadam"),
                      onChanged: (val) {
                        totalPrasadam = val;
                      },
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Transaction Type",
                          style:
                              GoogleFonts.nunitoSans(color: Color(0xffD2691E)),
                        )),
                    DropdownButton(
                      iconEnabledColor: Color(0xffD2691E),
                      isExpanded: true,
                      value: _trntypeVal,
                      onChanged: (val) {
                        setState(() {
                          _trntypeVal = val;
                        });
                      },
                      items: _trntypeList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Transaction Status",
                          style:
                              GoogleFonts.nunitoSans(color: Color(0xffD2691E)),
                        )),
                    DropdownButton(
                      iconEnabledColor: Color(0xffD2691E),
                      isExpanded: true,
                      value: _paystatusVal,
                      onChanged: (val) {
                        setState(() {
                          _paystatusVal = val;
                        });
                      },
                      items: _paystatusList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Receipt Number"),
                      onChanged: (val) {
                        recieptNo = val;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: "Pay Invoice Number"),
                      onChanged: (val) {
                        payInvoiceNo = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Bank Detail"),
                      onChanged: (val) {
                        bankDetail = val;
                      },
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _selectDate(context, "2");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: _mediaQuery.width * 0.01,
                              vertical: _mediaQuery.height * 0.01),
                          decoration: BoxDecoration(
                              border: Border.all(color: _primaryColor)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Payment Date: $paymentDate",
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Prasadam Count"),
                      onChanged: (val) {
                        prasadamCount = val;
                      },
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _selectDate(context, "3");
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: _mediaQuery.width * 0.01,
                              vertical: _mediaQuery.height * 0.01),
                          decoration: BoxDecoration(
                              border: Border.all(color: _primaryColor)),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Prasadam Date: $prasadamDate",
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: _mediaQuery.height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {
                          _addParayana();
                        },
                        color: _primaryColor,
                        child: Text(
                          "ADD PARAYANA",
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

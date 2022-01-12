import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/util/util.dart';
class EmployeeAddressForm extends StatefulWidget {


  @override
  _EmployeeAddressFormState createState() => _EmployeeAddressFormState();
}

class _EmployeeAddressFormState extends State<EmployeeAddressForm> {
  @override
  void initState() {
    // TODO: implement initState
    getUserToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Address"),),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}

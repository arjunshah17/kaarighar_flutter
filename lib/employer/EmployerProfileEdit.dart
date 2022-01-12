import 'dart:async';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/EmployerDashboard.dart';
import 'package:kaarighar/employer/model/EmployeeUser.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';
import 'package:location/location.dart';

class EmployerProfileEdit extends StatefulWidget {



  @override
  _EmployerProfileEditState createState() => _EmployerProfileEditState();
}

class _EmployerProfileEditState extends State<EmployerProfileEdit> {
  TextEditingController mobileEdit=TextEditingController();
  TextEditingController firstNameEdit=TextEditingController();
  TextEditingController lastNameEdit=TextEditingController();
  TextEditingController emailNameEdit=TextEditingController();
  TextEditingController companyRegisterNumberEdit=TextEditingController();
  TextEditingController companyRegisterNameEdit=TextEditingController();
  TextEditingController companyRegisterEmailEdit=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
@override
  void initState() {
    // TODO: implement initState
//  mobileEdit.text=widget._phoneNumber;
  WidgetsBinding.instance?.addPostFrameCallback((_) async {
    showLoader(context);
    getProfileData();
    dissmissLoader(context);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [IconButton(onPressed: (){
              if(_formKey.currentState!.validate())
                makeRegister();

            }, icon: Icon(Icons.check,color: Colors.white,))],
      centerTitle: true,
      title: Text("Profile",style: TextStyle(color: Colors.white),),),


      body: Container(

        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,


            children: [


              Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Form(
                  key: _formKey,

                  child: Column(
                    children: [

                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(
                          enabled: false,



                          validator: (value) {
                            if (value == null || value.isEmpty || value.length<10) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.phone,
                          controller:mobileEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter Mobile"
                          ),
                        ),
                      ),

                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(


                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.name,
                          controller:firstNameEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter first name"
                          ),
                        ),
                      ),

                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(


                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.name,
                          controller:lastNameEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter last name"
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(


                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.name,
                          controller:companyRegisterNameEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter restaurant name"
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(


                          validator: (input) => isValidEmail(input!) ? null : "Check your email",

                          keyboardType: TextInputType.emailAddress,
                          controller:companyRegisterEmailEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter restaurant email"
                          ),
                        ),
                      ),
                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextFormField(


                          validator: (value) {
                            if (value == null || value.isEmpty ) {
                              return 'Please enter some text';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.name,
                          controller:companyRegisterNumberEdit,


                          decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                              labelText: "Enter company registration number"
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
  Future<void> makeRegister() async {

    Dio dio=getDio();
    showLoader(context);
    try {
      var response = await dio.post('/api/user/profile', data:
      {
        "firstName": firstNameEdit.text,
        "lastName": lastNameEdit.text,
        "email": emailNameEdit.text,
        "role": "Recruiter",
        "company":{
          "companyName":companyRegisterNameEdit.text,
          "companyRegNo":companyRegisterNumberEdit.text,
          "companyAddress": "E-202 Shadniya Greens",
          "companyContact":emailNameEdit.text
        }
      },

      );
      print("res:" + response.toString());
      dissmissLoader(context);
      if (response.statusCode == 200) {
      //  setUser(response.data['token'], kRestaurant,response.data['user']["id"]);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => EmployerDashboard()), (
            Route<dynamic> route) => false
        );
      }

    }
    catch(ex){
      if(ex is DioError)
      {
        dissmissLoader(context);

     //   showError(context, ex.response!.data["msg"]!.toString());
      }
    }

  }

  Future<void> getProfileData() async {

    Dio dio =getDio();
    var  responseAddress = await dio.get(
        '/api/user/me',
        options:await  getHeaderOption()


    );
    var jsonaddress=responseAddress.data ;
    var item=  EmployeeUser.fromJson(jsonaddress);
    firstNameEdit.text=item.firstName!;
    mobileEdit.text=item.mobileNumber!;
    lastNameEdit.text=item.lastName!;
    companyRegisterNameEdit.text=item.company!.companyName!;
    emailNameEdit.text=item.email!;
    companyRegisterNumberEdit.text=item.company!.companyRegNo!;

    setState(() {

    });
  }


}

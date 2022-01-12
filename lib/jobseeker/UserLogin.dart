import 'dart:async';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/jobseeker/UserRegistration.dart';
import 'package:location/location.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController usernameEdit=TextEditingController();
  TextEditingController passwordEdit=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),onPressed: (){
          Navigator.pop(context);

        },),
      ),
resizeToAvoidBottomInset: false,
      body: Container(

        height:sizeScreen.height ,
        child: Stack(
          children: [
            SingleChildScrollView(

              child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,


                children: [

                  Container(
                    margin: EdgeInsets.only(top: 100),
                      height: 100,
                      child: Image.asset("assets/images/app_icon.png")),
                  Text("LOGIN",style: GoogleFonts.poppins(fontSize: 25,color:Colors.black),),
                  SizedBox(height:10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [

                            Container(
                              margin: EdgeInsets.all(10),
                              child: TextFormField(
                                keyboardType:TextInputType.phone,


                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller:usernameEdit,


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
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                controller:passwordEdit,

obscureText: _isHidden,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,

                                  suffixIcon:InkWell(
                                    onTap: (){
                                      setState(() {
                                        _isHidden=!_isHidden;
                                      });
                                    },
                                    child:_isHidden? Icon( Icons.visibility_off):Icon( Icons.visibility),
                                  ),



                                    labelText: "Enter otp"
                                ),
                              ),

                          ),
                        ],
                      ),
                    ),
                  ),




                  SizedBox(height:20),
                  Container(



                    child: Container(
                      width: 200,
                      child: TextButton(



                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                              ),


                              padding: EdgeInsets.all(12),
                              primary: Colors.white,
                              backgroundColor: Theme.of(context).primaryColor
                          ),
                          onPressed: (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => UserRegistration()),
                            // );

                          }, child: Text("Login")),
                    ),

                  ),
                  SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neumorphic(
                        child: IconButton(icon: Icon(FontAwesomeIcons.facebook,size: 25,color: Colors.blue,), onPressed:(){

                        }),
                      ),
                      SizedBox(width:20),
                      Neumorphic(
                        child: IconButton(icon: Icon(FontAwesomeIcons.google,size: 25,color: Colors.grey,), onPressed:(){

                        }),
                      )

                  ],),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  void showPassword(String email){
    final _formKey = GlobalKey<FormState>();
    bool _ispasswordHidden = true;
    bool _ispasswordConformHidden = true;
    TextEditingController passwordController=TextEditingController();
    TextEditingController confirmPasswordController=TextEditingController();

    showModalBottomSheet<void>(
      isScrollControlled: true,

      context: context,
      isDismissible: true,



      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {

        return Container(
          decoration: new BoxDecoration(
              color: HexColor("D6E3F3"),

              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(50.0),
                  topRight: const Radius.circular(50.0))),

          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
    builder: (context, setState) {
    return Container(
              margin: EdgeInsets.only(top: 20,bottom: 5,right: 10,left: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            children: [



                              Text("New password",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.bold,color:Theme.of(context).accentColor),),
                            ],
                          ),



                        ],),
                    ),
                    SizedBox(height: 20,),
                    Neumorphic(

                      style: NeumorphicStyle(
                        color: HexColor("D6E3F3"),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1,horizontal: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length<6) {
                              return 'Password must be greater then six digit';
                            }
                            return null;
                          },
                          controller:passwordController,
                          obscureText: _ispasswordHidden,

                          decoration: InputDecoration(

                                  isDense: false,

                              suffixIcon:InkWell(
                                onTap: (){
                                  setState(() {
                                    _ispasswordHidden=! _ispasswordHidden;
                                  });
                                },
                                child: _ispasswordHidden? Icon( Icons.visibility_off):Icon( Icons.visibility),
                              ),

                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              labelText: "Enter Password"
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20,),

                  ],
                ),
              ),
            );}),
          ),
        );
      },
    );

  }
}

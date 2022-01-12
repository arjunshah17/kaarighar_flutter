import 'dart:async';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/auth/OtpLogin.dart';
import 'package:kaarighar/employer/EmployerRegistration.dart';
import 'package:kaarighar/jobseeker/UserRegistration.dart';
import 'package:kaarighar/util/util.dart';
import 'package:location/location.dart';
import 'package:stretchy_header/stretchy_header.dart';

class EmployerLogin extends StatefulWidget {
  final String _userType;
  const EmployerLogin( this._userType) ;

  @override
  _EmployerLoginState createState() => _EmployerLoginState();
}

class _EmployerLoginState extends State<EmployerLogin> {
  TextEditingController numberEdit=TextEditingController();
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
                    margin: EdgeInsets.only(top: 30),
                      height: 100,
                      child: Image.asset("assets/images/app_icon.png")),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [


                        SizedBox(height:30,),

                          Column(
                            children: <Widget>[
                              Container(
                                height:30,
                                width:sizeScreen.width,
                                padding:EdgeInsets.only(left:30,right:30),
                                child:Text(
                                  'Hello, nice to meet you!',
                                  textAlign:TextAlign.left,
                                  style:TextStyle(

                                      fontSize:12
                                  ),
                                ),
                              ),
                              Container(
                                width:sizeScreen.width,
                                padding:EdgeInsets.only(left:30,right:30),
                                child:Text(
                                  'Get moving with our services',
                                  textAlign:TextAlign.left,
                                  maxLines:2,
                                  style:TextStyle(

                                      fontSize:24,
                                      fontWeight:FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:30,),
                          Container(
                            height:70,
                            padding:EdgeInsets.only(left:10,right:10),
                            child:Container(
                              decoration:BoxDecoration(
                                color:Colors.white,
                                borderRadius:BorderRadius.circular(12),
                                boxShadow:[
                                  BoxShadow(
                                    color:HexColor('#303030').withOpacity(0.15),
                                    spreadRadius:3,
                                    blurRadius:6,
                                    offset: Offset(0, 5), // changes position of shadow
                                  ),
                                ],
                              ),
                              child:Row(
                                children: <Widget>[

                                  Container(
                                    width:sizeScreen.width - 120,
                                    padding:EdgeInsets.only(left:16),
                                    child:TextField(

                                      keyboardType:TextInputType.phone,
                                      controller:numberEdit,
                                      keyboardAppearance:Brightness.light,
                                      style:TextStyle(

                                        fontSize:16,
                                      ),
                                      decoration: InputDecoration(

                                          border: InputBorder.none,
                                          hintText:'Number'
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height:20,),
                          Container(
                              width:sizeScreen.width,
                              height:40,
                              alignment:Alignment.centerRight,
                              padding:EdgeInsets.only(right:30),
                              child:CircleAvatar(

                                  child:Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: themeGradient),
                                    child: IconButton(
                                      icon:Icon(
                                        Icons.arrow_forward,
                                        color:Colors.white,
                                      ),
                                      onPressed:() {
if(isNumeric(numberEdit.value.text)) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => OtpLogin(numberEdit.text, widget._userType)),
  );
}
else{
  showError(context, "plase enter valid mobile number");
}

                                      },
                                    ),
                                  )
                              )
                          ),

                          SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                      width: sizeScreen.width - 50,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'By creating an account, you agree to our \n',
                                style:TextStyle(

                                    color:Colors.black,
                                    fontSize:12
                                )
                            ),
                            TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(

                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue,
                                    fontSize: 12),
                                recognizer: new TapGestureRecognizer()..onTap = ()async {
                                  print("ters");
                                  // openUrl(context,"http://onionservices.in/termsOfService.html");
                                }
                            ),
                            TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12)
                            ),
                            TextSpan(
                                text: 'Privacy Policy',
                                recognizer: new TapGestureRecognizer()..onTap = ()async {
                                  print("ters");
                                  // openUrl(context,"http://onionservices.in/privacy.html");
                                },
                                style: TextStyle(

                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue,
                                    fontSize:12)
                            ),
                          ],
                        ),
                      )
                  ),
                  SizedBox(height:30,),


                  SizedBox(height:20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Neumorphic(
                  //       child: IconButton(icon: Icon(FontAwesomeIcons.facebook,size: 25,color: Colors.blue,), onPressed:(){
                  //
                  //       }),
                  //     ),
                  //     SizedBox(width:20),
                  //     Neumorphic(
                  //       child: IconButton(icon: Icon(FontAwesomeIcons.google,size: 25,color: Colors.grey,), onPressed:(){
                  //
                  //       }),
                  //     )
                  //
                  // ],),

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

  bool isNumeric(String str) {
    return RegExp(r'^-?[0-9]+$').hasMatch(str);
  }
}

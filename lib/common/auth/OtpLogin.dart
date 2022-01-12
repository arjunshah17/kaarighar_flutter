import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/EmployerDashboard.dart';
import 'package:kaarighar/employer/EmployerRegistration.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/jobseeker/UserRegistration.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';


class OtpLogin extends StatefulWidget {
 final String _phoneNumber;
 final String _userType;


  const OtpLogin(this._phoneNumber, this._userType) ;

  _OtpLoginState createState() => _OtpLoginState();

}

class _OtpLoginState extends State<OtpLogin> {

  TextEditingController numberEdit=TextEditingController();
  TextEditingController passwordEdit=TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  String smsOTP="";
  late int reSendToken;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String  verificationId;
  @override
 initState() {
 verifyUser();
    super.initState();
  }

  Future<void> verifyUser() async {
   await auth.verifyPhoneNumber(
      phoneNumber: "+91 "+widget._phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
     var user=await    auth.signInWithCredential(credential);
   String userPassword= user.user!.uid;
   loginUser(widget._phoneNumber,userPassword);

        // Sign the user in (or link) with the auto-generated credential
        // await auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException error) {
        showError(context,error.message.toString());

      },
      codeSent: (String verificationId, int? forceResendingToken) {
        this.verificationId=verificationId;
        this.reSendToken=forceResendingToken!;
        showSuccess(context,"Otp sent successful");

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId=verificationId;
      },
    );
  }

  Future<void> resendUser() async {
    await auth.verifyPhoneNumber(
      forceResendingToken: reSendToken,
      phoneNumber: "+91 "+widget._phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        var user=await    auth.signInWithCredential(credential);
        String userPassword= user.user!.uid;
        loginUser(widget._phoneNumber,userPassword);

        // Sign the user in (or link) with the auto-generated credential
        // await auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException error) {
        showError(context,error.message.toString());

      },
      codeSent: (String verificationId, int? forceResendingToken) {
        this.verificationId=verificationId;
        this.reSendToken=forceResendingToken!;
        showSuccess(context,"Otp sent successful");

      },

      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId=verificationId;
      },
    );
  }
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
                                padding:EdgeInsets.only(left:15,right:30),
                                child:Text(
                                  'Phone verification',
                                  textAlign:TextAlign.left,
                                  style:TextStyle(

                                      fontSize:12
                                  ),
                                ),
                              ),
                              Container(
                                width:sizeScreen.width,
                                padding:EdgeInsets.only(left:15,right:30),
                                child:Text(
                                  'Enter your OTP code below',
                                  textAlign:TextAlign.left,
                                  maxLines:2,
                                  style:TextStyle(

                                      fontSize:20,
                                      fontWeight:FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:30,),
                          Container(
                              height:70,
                              margin:EdgeInsets.only(left:15,right:15),
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
                              child:Stack(
                                children: <Widget>[
                                  Positioned(
                                    left:10,
                                    right:70,
                                    child:OTPTextField(
                                      obscureText:true,

                                      length:6,
                                      width:MediaQuery.of(context).size.width,
                                      fieldWidth:20,
                                      style:TextStyle(
                                          fontSize: 17
                                      ),
                                      textFieldAlignment: MainAxisAlignment.spaceAround,
                                      fieldStyle:FieldStyle.underline,
                                      onChanged:(pin) {
                                        print(pin);
                                        pin.length < 4 ? circleAvtar(HexColor('D6D6D6')) : circleAvtar(HexColor('41CEA4'));
                                        setState(() {
                                           smsOTP = pin;
                                        });
                                      },
                                      onCompleted:(pin) {
                                        print("Completed: " + pin);
                                      },
                                    ),
                                  ),
                                  Positioned(
                                      top:16,
                                      right:20,
                                      child:circleAvtar(HexColor('D6D6D6'))
                                  )
                                ],
                              )
                          ),
                          SizedBox(height:10,),
                          Container(
                            alignment: Alignment.topLeft,
                            margin:EdgeInsets.only(left:30,right:30),
                            child: TextButton(
                              child: Text('Resend Code'),
                              onPressed: (){

resendUser();
                              },
                            ),
                          ),

                          SizedBox(height:10),

                        ],
                      ),
                    ),
                  ),
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

  CircleAvatar circleAvtar(Color backgroundColor) {

    print(smsOTP.length);
    return CircleAvatar(
        backgroundColor: smsOTP.length == 6 ? Theme.of(context).primaryColor : HexColor('D6D6D6'),
        child:Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
        ),
          child: IconButton(
            icon:Icon(
              Icons.arrow_forward,
              color:Colors.white,
            ),
            onPressed:() async {


    showLoader(context);



    var _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsOTP);

    auth.signInWithCredential(_credential).then((result) async {

      String userPassword= result.user!.uid;
      loginUser(widget._phoneNumber,userPassword);

    }).catchError((e){
      showError(context,"Invalid otp");
    dissmissLoader(context);
    });










              // if (smsOTP.isNotEmpty && smsOTP.length > 5) {
              //
              //   verify_OTP(smsOTP);



              }


          ),
        )
    );
  }

  Future<void> loginUser(String mobile,String userPassword) async {
 Dio dio=getDio();
 showLoader(context);
 try {
   var response = await dio.post('/api/user/login', data:
   {
     "mobileNumber": mobile,
     "password": userPassword
   },

   );
   print("res:" + response.toString());
   dissmissLoader(context);
   if (response.statusCode == 200) {
     if(widget._userType==kKaarighar)
       {setUserJob(response.data['token'], widget._userType,response.data['user']);

       }else
     setUserEmployee(response.data['token'], widget._userType,response.data['user']);
     if (widget._userType == kKaarighar) {
       Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
               builder: (context) => JobDashboard()), (
           Route<dynamic> route) => false
       );
     }
     else {
       Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
               builder: (context) => EmployerDashboard()), (
           Route<dynamic> route) => false
       );
     }
   }
   else {
     if(widget._userType == kKaarighar) {
       Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
               builder: (context) =>
                   EmployerRegistration(widget._phoneNumber, userPassword)), (
           Route<dynamic> route) => false
       );
     }
     else{
       Navigator.pushAndRemoveUntil(
           context,
           MaterialPageRoute(
               builder: (context) =>
                   UserRegistration(widget._phoneNumber, userPassword)), (
           Route<dynamic> route) => false
       );
     }
   }
 }
 catch(ex){
if(ex is DioError)
  {
    dissmissLoader(context);
    if(widget._userType==kKaarighar)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserRegistration(widget._phoneNumber,userPassword))

        );
      }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmployerRegistration(widget._phoneNumber,userPassword))

      );
    }
    //showError(context, ex.response!.toString());
  }
 }


  }
}
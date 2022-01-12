import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/choose_language.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(

          gradient:themeGradient,

        ),
        child: Stack(

          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 10,),
                  Center(child: Text("Welcome to Kaarighar",style:TextStyle(

                      color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold

                  ),)),

                  Center(

                  ),


                ],
              ),
            ),
            Center(
              child: Container(
                height: 600,

                alignment: Alignment.center,
                margin: EdgeInsets.all(10),
                child:  Container(child: Image.asset("assets/images/app_icon.png",height: 500,width: 500,)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),

                child: FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseLanguage()),
                    );



                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Theme.of(context).accentColor,

                  height: 50,
                  child: Text("GET STARTED"),
                ),
              ),

            )],

        ),
      ),

    );
  }
}

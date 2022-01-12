import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/common/auth/EmployerLogin.dart';
import 'package:kaarighar/jobseeker/UserLogin.dart';
import 'package:kaarighar/util/const.dart';
class UserSelectorScreen extends StatefulWidget {


  @override
  _UserSelectorScreenState createState() => _UserSelectorScreenState();
}

class _UserSelectorScreenState extends State<UserSelectorScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

        elevation: 0,
        centerTitle: true,
        title:Text("Choose Your Role",style: TextStyle(color: Colors.white),)),

      body: Container(
        height:height ,
        decoration: BoxDecoration(

          gradient:themeGradient,

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserLogin()),
                );
              },
              child: Column(
                children: [
                  Center(
                    child: new Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color:Theme.of(context).accentColor,
                            image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                  "assets/images/employee.png"
                                )
                            )
                        )),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    child: TextButton(



                        style: TextButton.styleFrom(


                            padding: EdgeInsets.all(10),
                            primary: Theme.of(context).primaryColor,
                            backgroundColor: Theme.of(context).accentColor
                        ),
                        onPressed: (){

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EmployerLogin(kKaarighar)),
    );

                        }, child: Text("I am a Kaarighar")),
                  ),
                ],
              ),
            ),

            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                      width: 150,
                      child: Divider(height: 2,color: Colors.white38)),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(" Or ",style: TextStyle(color: Colors.white38),)),
                    Container(
                        width: 150,
                        child: Divider(height: 2,color: Colors.white38)),

                ],),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmployerLogin(kKaarighar)),
                );
              },
              child: Column(
                children: [
                  Center(
                    child: new Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color:Theme.of(context).accentColor,
                            image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                    "assets/images/company.png"
                                )
                            )
                        )),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: 200,
                    child: TextButton(



                        style: TextButton.styleFrom(


                            padding: EdgeInsets.all(10),
                            primary: Theme.of(context).primaryColor,
                            backgroundColor: Theme.of(context).accentColor
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EmployerLogin(kRestaurant)),
                          );

                        }, child: Text("I am a Restaurant")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

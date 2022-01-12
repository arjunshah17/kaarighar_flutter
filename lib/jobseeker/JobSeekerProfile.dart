import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/SplashScreen.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/jobseeker/JobSeekerEducationScreen.dart';
import 'package:kaarighar/jobseeker/JobSeekerVerificationScreen.dart';
import 'package:kaarighar/jobseeker/JobSeekerWorkScreen.dart';
import 'package:kaarighar/jobseeker/jobSeekerProfileEdit.dart';
import 'package:kaarighar/util/util.dart';
class JobSeekarProfile extends StatefulWidget {

  @override
  _JobSeekarProfileState createState() => _JobSeekarProfileState();
}

class _JobSeekarProfileState extends State<JobSeekarProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      centerTitle: true,
      leading: Container(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text("My profile",style: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Common().matteBlack)),),

      body: ListView(children: [
        Center(
          child: new Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color:Theme.of(context).primaryColor,
                  image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(
                          "assets/images/employee.png"
                      )
                  )
              )),
        ),
        SizedBox(height: 10,),
        // Center(child: Container(
        //   child: Text("John deo",style: GoogleFonts.lato(
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //       color: Common().appColor)),
        // ),),
        SizedBox(height: 10,),
        settingsWidget("Profile",Icons.account_circle,(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobSeekerProfileEdit()),
          );

        }),
        settingsWidget("Verification",Icons.domain_verification_outlined,(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobSeekerVerificationScreen()),
          );
        }),
        settingsWidget("Education qualification",FontAwesomeIcons.school,(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobSeekerEducationScreen()),
          );

        }),
        settingsWidget("Work experience",Icons.work_rounded,(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobSeekerWorkScreen()),
          );
        }),
        settingsWidget("Language",Icons.language,(){

        }),

        settingsWidget("Privacy and Policy",Icons.security,(){

        }),
        settingsWidget("About us",Icons.security,(){

        }),
        settingsWidget("Log out",Icons.logout,(){
          makeLogout();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashScreen()), (
              Route<dynamic> route) => false
          );
        }),




      ],),
    );
  }
  Widget settingsWidget(String text, IconData icon,Function function) => InkWell(
    onTap: () {function.call();},
    child: Card(
      shadowColor: Common().appColor,
      child: Container(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Common().appColor),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    text,
                    style: GoogleFonts.lato(
                        color: Common().appColor, fontSize: 16),
                  )
                ],
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    ),
  );
}

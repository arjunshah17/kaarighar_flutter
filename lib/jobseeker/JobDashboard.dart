import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:kaarighar/jobseeker/HomeScreen.dart';
import 'package:kaarighar/jobseeker/JobSeekerProfile.dart';
import 'package:kaarighar/jobseeker/MyJobScreen.dart';
import 'package:kaarighar/jobseeker/UserRegistration.dart';
import 'package:location/location.dart';

class JobDashboard extends StatefulWidget {
  @override
  _JobDashboardState createState() => _JobDashboardState();
}

class _JobDashboardState extends State<JobDashboard> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
           HomeScreen(),
            MyJobScreen(),
            JobSeekarProfile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(


        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              activeColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('My jobs'),
              activeColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.work_rounded)
          ),
          BottomNavyBarItem(
              activeColor: Theme.of(context).primaryColor,
              title: Text('Profile'),
              icon: Icon(Icons.account_circle)

          ),
        ],
      ),
    );
  }
}


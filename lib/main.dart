import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/SplashScreen.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/EmployerDashboard.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';



import 'common/common.dart';

var userType;

Future<void> main()  async {
    WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
    userType=await getUserType();
    runApp(MyApp());
}

class MyApp extends StatefulWidget {
    // This widget is the root of your application.


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;

    StreamSubscription? iosSubscription;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
    Future onSelectNotification(String payload) async {

    }



    showNotification(String title,String message) async {
        var android = AndroidNotificationDetails(
            '1000', 'notifications',

            channelDescription: 'description',
            priority: Priority.max, importance: Importance.max);
        var iOS = IOSNotificationDetails();
        var platform = new NotificationDetails(android: android, iOS: iOS);
        await flutterLocalNotificationsPlugin.show(
            0, title, message, platform,
            payload: message);
    }
    Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
        if (message.containsKey('data')) {
            // Handle data message
            final dynamic data = message['data'];
            final dictData = Map<String, dynamic>.from(message['data']);

            await showNotification(dictData['title'],dictData["message"]);
        }

        if (message.containsKey('notification')) {
            // Handle notification message
            final dynamic notification = message['notification'];
        }

        // Or do other work.
    }

    @override
  void initState() {
    // TODO: implement initState
        var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

        final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: false,
            requestSoundPermission: true);
        var initSetttings = InitializationSettings(
            android: initializationSettingsAndroid, iOS: initializationSettingsIOS);


        FirebaseMessaging.instance.onTokenRefresh.listen((val){
            _saveDeviceToken(val);
        });
        Future.delayed(Duration(seconds: 1), () async {


            NotificationSettings settings = await _fcm.requestPermission(
                alert: true,
                announcement: true,
                badge: true,
                carPlay: true,
                criticalAlert: true,
                provisional: true,
                sound: true,
            );

            FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
                print('Got a message whilst in the foreground!');
                print('Message data: ${message.data["title"]}');



                showNotification(message.data['title'], message.data['message']);
                //   await showNotification(message.notification.title,message.notification.body);
                //  print('Message also contained a notification: ${message.notification}');

            });





        });
    super.initState();
  }
    @override
    Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarColor: Common().appColor));
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


               return ScreenUtilInit(
              designSize: Size(375, 812),
              builder: () =>  MaterialApp(
                  title: Common().appName,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(

                      primaryColor: HexColor("#FF043955"),
                      textTheme: GoogleFonts.latoTextTheme(
                          Theme.of(context).textTheme,
                      ),
                      primarySwatch: Colors.amber,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home:userType==null?SplashScreen():userType==kRestaurant?EmployerDashboard():JobDashboard(),
              ),
          );}

    }

  void _saveDeviceToken(String val) {


  }


import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaarighar/common/UserSelectorScreen.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:kaarighar/model/language_model.dart';
import 'package:kaarighar/widget/language_selector.dart';
import 'package:kaarighar/widget/primary_button.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

List<LanguageModel> languages = [

  LanguageModel(
    language: "English",
    imagePath: "assets/images/england.png",
  ),
  LanguageModel(
    language: "हिंदी",
    imagePath: "assets/images/hindi.png",
  ),
  LanguageModel(
    language: "ଓଡିଆ",
    imagePath: "assets/images/odisa.png",
  ),
  LanguageModel(
    language: "বাংলা",
    imagePath: "assets/images/bangal.png",
  ),

];

class _ChooseLanguageState extends State<ChooseLanguage> {
  int _activeIndex = -1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery. of(context). size. height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,

          elevation: 0,
          centerTitle: true,
          title:Text("Select language",style: TextStyle(color: Colors.white),)),

      body:
        Container(

          decoration: BoxDecoration(

            gradient:themeGradient,

          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [


              ...languages.map((language) {
                int _currentIndex = languages.indexOf(language);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _activeIndex = _currentIndex;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>UserSelectorScreen()),
                    );
                  },
                  child: LanguageSelector(
                    isActive: _activeIndex == _currentIndex,
                    language: language.language,
                    imagePath: language.imagePath,
                  ),
                );
              }).toList(),

            ],
          ),
        ),

    );
  }
}

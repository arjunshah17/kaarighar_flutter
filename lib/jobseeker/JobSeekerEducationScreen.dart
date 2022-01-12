import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:kaarighar/employer/model/Employee.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/jobseeker/model/JobSeekerEducation.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';

class JobSeekerEducationScreen extends StatefulWidget {


  @override
  _JobSeekerEducationScreenState createState() => _JobSeekerEducationScreenState();
}

class _JobSeekerEducationScreenState extends State<JobSeekerEducationScreen> {
  TextEditingController usernameEdit=TextEditingController();
  TextEditingController passwordEdit=TextEditingController();
  String? currentLocationState,currentLocationCity;
  String? homeLocationState,homeLocationCity;
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;


  String? selectedDegree="";

  TextEditingController collageEdit=TextEditingController();
  TextEditingController degreeEdit=TextEditingController();
  TextEditingController decriptionEdit=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showLoader(context);

    getEducationDetails();

      dissmissLoader(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).accentColor,),onPressed: (){
          Navigator.pop(context);

        },),
        centerTitle: true,
        title: Text("Education qualification",style: TextStyle(color: Theme.of(context).accentColor),),
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
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              selectedItem: selectedDegree,
                              showSelectedItems: true,
                              items: [
                                '10th pass',
                                '12th pass',
                                'Graduate',
                                'Post graduate'
                                , 'Others'],
                              label: "Select qualification",
                              hint: "Select qualification",
                              onChanged: (value){
                                setState(() {

                                });
                                selectedDegree=value;
                              },
                            ),
                          ),
selectedDegree=="Graduate" || selectedDegree=="Post graduate"?  Column(children: [
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(




                              keyboardType: TextInputType.name,
                              controller:collageEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter collage name"
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(

                              keyboardType: TextInputType.name,
                              controller:degreeEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "enter degree name"
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                      ]):Container(),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(





                              keyboardType: TextInputType.name,
                              controller:decriptionEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter description"
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

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
                            if(_formKey.currentState!.validate()){


                           if (selectedDegree==null)
                                showError(context,"Please select cuisne");
                              else{
                                makeRegister();

                              }


                            }




                          }, child: Text("Update")),
                    ),

                  ),
                  SizedBox(height:20),


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
                                  border: OutlineInputBorder(),
                                  isDense: false,

                                    suffixIcon:InkWell(
                                      onTap: (){
                                        setState(() {
                                          _ispasswordHidden=! _ispasswordHidden;
                                        });
                                      },
                                      child: _ispasswordHidden? Icon( Icons.visibility_off):Icon( Icons.visibility),
                                    ),


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


  Future<void> makeRegister() async {

    Dio dio=getDio();
    showLoader(context);
    try {
      var response = await dio.post('/api/user/profile/education',
          options:await getHeaderOption(),
          data:
      {
        "education" :[ {
          "school" : collageEdit.value.text,
          "degree" : degreeEdit.value.text,
          "fieldofstudy" : selectedDegree,
          "current" : "true",
          "from" : "10/06/2000",
          "to": "12/03/2003",
          "description" : decriptionEdit.value.text
        }]
      }

      );
      print("res:" + response.toString());
      dissmissLoader(context);
      if (response.statusCode == 200) {
        Navigator.of(context).pop();

      }

    }
    catch(ex){
      if(ex is DioError)
      {
        dissmissLoader(context);

        showError(context, ex.response!.data["msg"]!.toString());
      }
    }

  }

  Future<void> getEducationDetails() async {
Dio dio =getDio();
    var  responseAddress = await dio.get(
        '/api/user/profile/education',
        options:await  getHeaderOption()


    );
    var jsonaddress=responseAddress.data as List;
   var item=  JobSeekerEducation.fromJson(jsonaddress[0]);
   selectedDegree=item.fieldofstudy;
   collageEdit.text=item.school!;
   degreeEdit.text=item.degree!;
   decriptionEdit.text=item.description!;
   setState(() {

   });

  }
}
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as leo;
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';
import 'package:location/location.dart';

class UserRegistration extends StatefulWidget {
  String phoneNumber,pass;
  UserRegistration(this.phoneNumber,this.pass);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController usernameEdit=TextEditingController();
  TextEditingController passwordEdit=TextEditingController();
  String? currentLocationState,currentLocationCity;
  String? preferLocationState,preferLocationCity;
  String? preferTwoLocationState,preferTwoLocationCity;
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;
  List<Category>? categoryList;
  List<SubCategory>? subCategoryList;
  Category? selectedDepartment;
  SubCategory? selectedDesignation;
  String? selectedCuisne;
  String? defaultState,defaultCity;

  TextEditingController firstNameEdit=TextEditingController();
  TextEditingController lastNameEdit=TextEditingController();
  TextEditingController emailNameEdit=TextEditingController();
  TextEditingController aadharcardEdit=TextEditingController();
  TextEditingController pancardEdit=TextEditingController();
  TextEditingController salaryEdit=TextEditingController();
  TextEditingController expectedEdit=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showLoader(context);
      categoryList=await getDepartment();


     leo.Position position = await _determinePosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];

     var Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
print("Address:"+place.administrativeArea.toString()+place.subAdministrativeArea.toString());

      defaultState=place.administrativeArea;
      defaultCity=place.subAdministrativeArea;
setState(() {

  print("defaulT_state:"+defaultState.toString());
});

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
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).primaryColor,),onPressed: (){
          Navigator.pop(context);

        },),
      ),
      body: Container(

        height:sizeScreen.height ,
        child: Stack(
          children: [
            SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,


                children: [

                  Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 100,
                      child: Image.asset("assets/images/app_icon.png")),
                  Text("REGISTRATION",style: GoogleFonts.poppins(fontSize: 25,color:Colors.black),),
                  SizedBox(height:10),
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
                              enabled: false,
initialValue: widget.phoneNumber,

                              validator: (value) {
                                if (value == null || value.isEmpty || value.length<10) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.phone,



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
                                if (value == null || value.isEmpty ) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.name,
                              controller:firstNameEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter first name"
                              ),
                            ),
                          ),

                          SizedBox(height:10),

                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(


                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.name,
                              controller:lastNameEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter last name"
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(


                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.emailAddress,
                              controller:emailNameEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter email"
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Select current location",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: SelectState(
                                    selectedState: defaultState,
                                    selectedCity: defaultCity,
                                    onCountryChanged: (value) {
                                      setState(() {


                                      });
                                    },
                                    onStateChanged:(value) {
                                      setState(() {
currentLocationState=value!;
                                      });
                                    },
                                    onCityChanged:(value) {
                                      setState(() {
                                        currentLocationCity=value!;
                                      });
                                    },

                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:10),
                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Select prefer location",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: SelectState(
                                    onCountryChanged: (value) {
                                      setState(() {

                                      });
                                    },
                                    onStateChanged:(value) {
                                      setState(() {
                                        preferLocationState=value!;
                                      });
                                    },
                                    onCityChanged:(value) {
                                      setState(() {
                                        preferLocationCity=value!;
                                      });
                                    },

                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:10),
                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Select second prefer location",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: SelectState(
                                    onCountryChanged: (value) {
                                      setState(() {

                                      });
                                    },
                                    onStateChanged:(value) {
                                      setState(() {
                                        preferTwoLocationState=value;

                                      });
                                    },
                                    onCityChanged:(value) {
                                      setState(() {
                                        preferTwoLocationCity=value!;
                                      });
                                    },

                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child:categoryList!=null? DropdownSearch<Category>(
                              mode: Mode.MENU,
                              showSelectedItems: false,
                              itemAsString: (val)=>val!.title!,
                              items: categoryList,
                              label: "Select department",
                              hint: "Select department",
                              onChanged:(value) async {
                                showLoader(context);
                                subCategoryList=await getdesgination(value!.sId!);
                                selectedDepartment=value;
                                setState(() {

                                });
                                dissmissLoader(context);
                              },
                            ):Container(),
                          ),
                          SizedBox(height:10),
                    subCategoryList!=null?   Container(
                            margin: EdgeInsets.all(10),
                            child: DropdownSearch<SubCategory>(
                              mode: Mode.MENU,
                              showSelectedItems: false,
                              itemAsString: (val)=>val!.title!,
                              items: subCategoryList,
                              label: "Select designation",
                              hint: "Select designation",
                              onChanged:(value) async {
                                selectedDesignation=value;
                                // showLoader(context);
                                // subCategoryList=await getdesgination(value!.sId!);
                                // setState(() {
                                //
                                // });
                                // dissmissLoader(context);
                              },
                            ),
                          ):Container(),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: [
                                  'North Indian',
                                  'Indo Chinese',
                                  'Asian',
                                  'Mexican',
                                  'Italian',
                                  'Greek',
                                  'Mediterranean',
                                  'Continental',
                                  'Tandoor',
                                  'Modern Indian',
                                  'Japanese'
                                  , 'Others'],
                                label: "Select cuisine",
                                hint: "select cuisine",
                                onChanged: (value){
                                  selectedCuisne=value;
                                },
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(




                              keyboardType: TextInputType.name,
                              controller:aadharcardEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter aadhar card"
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(




                              keyboardType: TextInputType.name,
                              controller:pancardEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter pancard"
                              ),
                            ),

                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(


                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.number,
                              controller:salaryEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter current salary"
                              ),
                            ),

                          ),
                          SizedBox(height:10),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(


                              validator: (value) {
                                if (value == null || value.isEmpty ) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },

                              keyboardType: TextInputType.number,
                              controller:expectedEdit,


                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                  labelText: "Enter expected salary"
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
                              if(currentLocationState==null || currentLocationCity==null)
                                showError(context,"Please select current state and city");
                              else if (selectedDepartment==null || selectedDesignation==null)
                                showError(context,"Please select department and designation");

                              else if (selectedCuisne==null)
                                showError(context,"Please select cuisne");
                              else{
                                makeRegister();

                              }


                            }




                          }, child: Text("Register")),
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

  Future<List<Category>> getDepartment() async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/admin/category/all',
        options:await  getHeaderOption()


    );
    var json=response.data['data'] as List;

    List<Category> listVideo=json.map((e) => Category.fromJson(e)).toList();
    print("url_data:"+response.data.toString());
    return listVideo;
  }
  Future<List<SubCategory>> getdesgination(String id) async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/admin/subcategory/parent/'+id,
        options:await  getHeaderOption()


    );
    var json=response.data['data'] as List;

    List<SubCategory> listVideo=json.map((e) => SubCategory.fromJson(e)).toList();
    print("url_data:"+response.data.toString());
    return listVideo;
  }

  Future<void> makeRegister() async {

    Dio dio=getDio();
    showLoader(context);
    try {
      var response = await dio.post('/api/user/register', data:
      {
        "firstName":  firstNameEdit.value.text,
        "lastName": lastNameEdit.value.text,
        "email": emailNameEdit.value.text,
        "mobileNumber": widget.phoneNumber,
        "password": widget.pass,
        "role": "Job Seeker",
        "aadharCard":{
          "aadharNumber": "",
          "aadharImage":aadharcardEdit.text
        },
        "panCard":{
          "panNumber": pancardEdit.text,
          "panImage":""
        },
        "current_location": {
          "city": currentLocationCity,
          "state": currentLocationState

        },
        "preferedCity": {
          "city": preferLocationCity,
          "state": preferLocationState

        },
        "preferedCitySecond": {
          "city": preferTwoLocationCity,
          "state": preferTwoLocationState

        },
        "department":selectedDepartment!.sId,
        "designation":selectedDesignation!.sId,
        "cuisine_name":selectedCuisne,
        "currentSalary":salaryEdit.value.text,
        "expectedSalary":expectedEdit.value.text,
      }

      );
      print("res:" + response.toString());
      dissmissLoader(context);
      if (response.statusCode == 200) {
        setUserJob(response.data['token'],kKaarighar,response.data['user']);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => JobDashboard()), (
            Route<dynamic> route) => false
        );
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}


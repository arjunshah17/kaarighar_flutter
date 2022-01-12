import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:kaarighar/employer/model/KaarigharUser.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';
import 'package:place_picker/uuid.dart';

class JobSeekerVerificationScreen extends StatefulWidget {


  @override
  _JobSeekerVerificationScreenState createState() => _JobSeekerVerificationScreenState();
}

class _JobSeekerVerificationScreenState extends State<JobSeekerVerificationScreen> {
  TextEditingController adhaarEdit=TextEditingController();
  TextEditingController pancardEdit=TextEditingController();
  TextEditingController salaryEdit=TextEditingController();
  String? currentLocationState,currentLocationCity;
  String? homeLocationState,homeLocationCity;
  PickedFile? aadharImage;
  String? aaharUrl;
  String? pancardUrl;
  String? salarySlipUrl;
  PickedFile? pancardImage;
  PickedFile? salaryslipImage;
  final _formKey = GlobalKey<FormState>();
  bool _isHidden = true;


  String? selectedDegree;

  TextEditingController collageEdit=TextEditingController();
  TextEditingController degreeEdit=TextEditingController();
  TextEditingController decriptionEdit=TextEditingController();
  List<Category>? categoryList;
  List<SubCategory>? subCategoryList;
  Category? selectedDepartment;
  SubCategory? selectedDesignation;
  String? selectedCuisne;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      showLoader(context);
    getProfile();
      setState(() {

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
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).accentColor,),onPressed: (){
          Navigator.pop(context);

        },),
        centerTitle: true,
        title: Text("Verification",style: TextStyle(color: Theme.of(context).accentColor),),
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

                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Attach aadhaar card",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),

                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(




                                    keyboardType: TextInputType.name,
                                    controller:adhaarEdit,


                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                        labelText: "Enter aadhaar card"
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Container(
                                          height: 100,
                                          width: 150,
                                          child:aaharUrl!="" && aaharUrl!=null?Image.network(aaharUrl!,

                                            height: 100,width: 150,)  :  aadharImage!=null? Image.file(File(aadharImage!.path),

                                            height: 100,width: 150,): Image.asset(



                                            "assets/images/add.png"

                                            ,

                                            height: 100,width: 150,

                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextButton(



                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ),


                                                padding: EdgeInsets.all(12),
                                                primary: Colors.white,
                                                backgroundColor: Theme.of(context).primaryColor
                                            ),
                                            onPressed: () async {



                                              final _picker = ImagePicker();
                                              aadharImage= (await _picker.getImage(source: ImageSource.gallery))!;
                                              setState(() {

                                              });
                                              print(aadharImage!.path!);

 uploadDoc();


                                            }, child: Text("upload")),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Attach pancard",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),

                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(




                                    keyboardType: TextInputType.name,
                                    controller:pancardEdit,


                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                        labelText: "Enter  pancard"
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Container(
                                          height: 100,
                                          width: 150,
                                          child:pancardUrl!="" && pancardUrl!=null?Image.network(pancardUrl!,

                                            height: 100,width: 150,)  :   pancardImage!=null? Image.file(File(pancardImage!.path),

                                            height: 100,width: 150,): Image.asset(



                                            "assets/images/add.png"

                                            ,

                                            height: 100,width: 150,

                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextButton(



                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ),


                                                padding: EdgeInsets.all(12),
                                                primary: Colors.white,
                                                backgroundColor: Theme.of(context).primaryColor
                                            ),
                                            onPressed: () async {



                                              final _picker = ImagePicker();
                                              pancardImage= (await _picker.getImage(source: ImageSource.gallery))!;
                                              setState(() {

                                              });
                                              print(pancardImage!.path!);

                                              uploadPan();


                                            }, child: Text("upload")),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Card(  color: Colors.grey.shade300,
                            child: Column(
                              children: [
                                Container(

                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(top: 10,left: 10),
                                    child: Text("Attach salary slip",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13),)),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: TextFormField(




                                    keyboardType: TextInputType.number,
                                    controller:salaryEdit,


                                    decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,




                                        labelText: "Enter salary"
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Container(
                                          height: 100,
                                          width: 150,
                                          child: salaryslipImage!=null? Image.file(File(salaryslipImage!.path),

                                            height: 100,width: 150,): Image.asset(



                                            "assets/images/add.png"

                                            ,

                                            height: 100,width: 150,

                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextButton(



                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ),


                                                padding: EdgeInsets.all(12),
                                                primary: Colors.white,
                                                backgroundColor: Theme.of(context).primaryColor
                                            ),
                                            onPressed: () async {



                                              final _picker = ImagePicker();
                                              salaryslipImage= (await _picker.getImage(source: ImageSource.gallery))!;
                                              setState(() {

                                              });
                                              print(salaryslipImage!.path!);

                                              uploadSalary();


                                            }, child: Text("upload")),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),







                        ],
                      ),
                    ),
                  ),



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
      var response = await dio.put('/api/user/profile/',
          options:await getHeaderOption(),
          data:
          {
            "education" :[ {
              "school" : collageEdit.value.text,
              "degree" : degreeEdit.value.text,
              "fieldofstudy" : selectedDegree,
              "current" : "true",
              "description" : decriptionEdit.value.text
            }]
          }

      );
      print("res:" + response.toString());
      dissmissLoader(context);
      if (response.statusCode == 200) {
     //   Navigator.of(context).pop();

      }

    }
    catch(ex){
      if(ex is DioError)
      {
        dissmissLoader(context);
print("error:"+ex.message);
        showError(context, ex.response!.data["msg"]!.toString());
      }
    }

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

   uploadDoc() async {
if(adhaarEdit.text.isNotEmpty) {
  try {
    Dio dio = getDio();
    showLoader(context);
    var uniqueValue = UniqueKey();
    var userId = await getUserId();
    var uuid = Uuid();

// Generate a v1 (time-based) id


    var formData = FormData.fromMap({
      'aadharNumber': adhaarEdit.text,
      "aadharImage": await MultipartFile
          .fromFile(aadharImage!.path, filename: 'doc_' + uuid.generateV4(),
        contentType: MediaType('image', 'png'),

      )
    });
    var response = await dio.post('/api/user/profile/aadhar',
        options: await getHeaderOption(),
        data:
        formData


    );
    print("res:" + response.toString());
    dissmissLoader(context);

    setState(() {

    });
  }


  catch (e) {
    print(e.toString());
    dissmissLoader(context);
  }
}
else showError(context, "Please enter enter aadhaar no");
  }
  uploadPan() async {
    if(pancardEdit.text.isNotEmpty) {
      try {
        Dio dio = getDio();
        showLoader(context);
        var uniqueValue = UniqueKey();
        var userId = await getUserId();
        var uuid = Uuid();

// Generate a v1 (time-based) id


        var formData = FormData.fromMap({
          'panNumber': adhaarEdit.text,
          "panImage": await MultipartFile
              .fromFile(pancardImage!.path, filename: 'doc_' + uuid.generateV4(),
            contentType: MediaType('image', 'png'),

          )
        });
        var response = await dio.post('/api/user/profile/pan',
            options: await getHeaderOption(),
            data:
            formData


        );
        print("res:" + response.toString());
        dissmissLoader(context);

        setState(() {

        });
      }


      catch (e) {
        print(e.toString());
        dissmissLoader(context);
      }
    }
    else showError(context, "Please enter enter pancard no");
  }
  uploadSalary() async {
    if(salaryEdit.text.isNotEmpty) {
      try {
        Dio dio = getDio();
        showLoader(context);
        var uniqueValue = UniqueKey();
        var userId = await getUserId();
        var uuid = Uuid();

// Generate a v1 (time-based) id


        var formData = FormData.fromMap({
          'salaryAmount': salaryEdit.text,
          "salaryImage": await MultipartFile
              .fromFile(salaryslipImage!.path, filename: 'doc_' + uuid.generateV4(),
            contentType: MediaType('image', 'png'),

          )
        });
        var response = await dio.post('/api/user/profile/salary',
            options: await getHeaderOption(),
            data:
            formData


        );
        print("res:" + response.toString());
        dissmissLoader(context);

        setState(() {

        });
      }


      catch (e) {
        print(e.toString());
        dissmissLoader(context);
      }
    }
    else showError(context, "Please enter enter aadhaar no");
  }


  Future<void> getProfile() async {
    Dio dio =getDio();

    var  responseAddress = await dio.get(
        '/api/user/me',
        options:await  getHeaderOption()


    );
    var jsonaddress=responseAddress.data;
    var item=  KaarigharUser.fromJson(jsonaddress);
    // selectedDegree=item.fieldofstudy;
    // collageEdit.text=item.school!;
    // degreeEdit.text=item.degree!;
    // decriptionEdit.text=item.description!;
    adhaarEdit.text=item.aadharCard!.aadharNumber!;
    pancardEdit.text=item.panCard!.panNumber!;
    aaharUrl=item.aadharCard!.aadharImage!;
    pancardUrl=item.panCard!.panImage!;


    setState(() {

    });

  }
}
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:kaarighar/jobseeker/JobDashboard.dart';
import 'package:kaarighar/util/const.dart';
import 'package:kaarighar/util/util.dart';

class JobSeekerWorkScreen extends StatefulWidget {


  @override
  _JobSeekerWorkScreenState createState() => _JobSeekerWorkScreenState();
}

class _JobSeekerWorkScreenState extends State<JobSeekerWorkScreen> {
  TextEditingController usernameEdit=TextEditingController();
  TextEditingController passwordEdit=TextEditingController();
  String? currentLocationState,currentLocationCity;
  String? homeLocationState,homeLocationCity;
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
      categoryList=await getDepartment();
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
      floatingActionButton:
      FloatingActionButton.extended(
        label: Text("Add work experience"),
        icon:Icon(Icons.add) ,
        onPressed: () async {

addWork();
        },
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).accentColor,),onPressed: (){
          Navigator.pop(context);

        },),
        centerTitle: true,
        title: Text("Work experience",style: TextStyle(color: Theme.of(context).accentColor),),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(



        ),
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
            "experience" : [{
              "title" : "",
              "company" : "Facebook",
              "location" : "Pune",
              "from": "11/10/12",
              "current" : "true",
              "description" : "SDE intern at Facebook"
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


  Future<void> addWork() async {

    Dio dio=getDio();
    String userId="";
    List<Category>? categoryList;
    List<SubCategory>? subCategoryList;
    Category? selectedDepartment;
    SubCategory? selectedDesignation;
    String? selectedCuisne;

    categoryList=await getDepartment();

    String    currentLocationState="",currentLocationCity="";



    bool hasError = false;
    showModalBottomSheet<void>(
        isScrollControlled: true,

        context: context,
        isDismissible:true,



        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: new BoxDecoration(
                color: Theme.of(context).primaryColor,

                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),

            child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) =>
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 5,),
                              AppBar(
                                backgroundColor: Colors.transparent,
                                leading: IconButton(icon: Icon(Icons.clear,color: Theme.of(context).accentColor,),onPressed: (){
                                  Navigator.pop(context);

                                },),
                                elevation: 0,
                                centerTitle: true,
                                title: Text("Work",style: TextStyle(color: Theme.of(context).accentColor),),),
                              Container(
                                child:  Column(children: [

                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(




                                      keyboardType: TextInputType.name,
                                      controller:collageEdit,


                                      decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,


                                          filled: true,
                                          fillColor: Colors.white,



                                          labelText: "Enter restaurant name"
                                      ),
                                    ),
                                  ),

                                  SizedBox(height:10),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(




                                      keyboardType: TextInputType.name,
                                      controller:collageEdit,


                                      decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,

                                          filled: true,
                                          fillColor: Colors.white,
                                          labelText: "Enter starting date"
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:10),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextFormField(




                                      keyboardType: TextInputType.name,
                                      controller:collageEdit,



                                      decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,

                                          filled: true,

                                          fillColor: Colors.white,



                                          labelText: "Enter end date(keep empty if you are working now there)"
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child:
                                    Card(   color: Colors.grey.shade300,
                                      child: Column(
                                        children: [
                                          Container(

                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(top: 10,left: 10),
                                              child: Text("Select current field",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),)),
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


                                        ],
                                      ),
                                    ),
                                  ),



                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),



                                    width: 100,

                                    child: TextButton(








                                        style: TextButton.styleFrom(





                                            padding: EdgeInsets.all(12),

                                            primary: Theme.of(context).primaryColor,

                                            backgroundColor: Theme.of(context).accentColor

                                        ),

                                        onPressed: (){

                                          Navigator.pop(context);



                                        }, child: Text("Add",style: GoogleFonts.lato(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),

                                  ),

                                  SizedBox(height:10),

                                ],),
                              )

                            ],
                          ),
                        ))
            ),
          );
        });


  }
}
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/employer/model/Category.dart';
import 'package:kaarighar/employer/model/JobData.dart';
import 'package:kaarighar/jobseeker/JobSeekerJobDetail.dart';
import 'package:kaarighar/jobseeker/job.dart';
import 'package:kaarighar/util/util.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  Future<List<JobData>> getJobs() async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/job/all',
        options:await  getHeaderOption()


    );
    var json=response.data["data"] as List;
    print("url_data:"+response.data.toString());
    List<JobData> listVideo=json.map((e) => JobData.fromJson(e)).toList();

    return listVideo;

  }
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  Widget searchAndControler(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 5, right: 5,top:20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width: MediaQuery.of(context).size.width - 50,
            child: TextField(
              cursorColor: Common().appColor,
              style: GoogleFonts.lato(),
              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,
                hintText: Common().searchJob,
                hintStyle: GoogleFonts.lato(color: Common().appColor),
                suffixIcon: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.search,
                        color: Common().appColor,
                      ),
                    ),

                  ],
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                  BorderSide(width: 0.1, color: Common().appColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                  BorderSide(width: 0.5, color: Common().appColor),
                ),

              ),
            )),
      ],
    ),
  );
  Widget greetings() => Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    width: 170,
                    child: Text(Common().greetings,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().matteBlack)),
                  ),
                  Container(
                    width: 170,
                    child: Text(Common().findPerfectJob,
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Common().appColor)),
                  )
                ],
              )),
        ],
      ));
  Widget category(int index, String title) => Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
              color:
              (_currentIndex != index) ? Common().white : Common().appColor,
              border: Border.all(color: Common().appColor, width: 0.5),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(title,
                style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: (_currentIndex != index)
                        ? Common().appColor
                        : Common().white)),
          ),
        ),
      ));
  Widget jobCategories(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(Common().jobCategories,
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Common().appColor)),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category(0, Common().all),
                  category(1, "Directors of kitchen"),
                  category(2, "Corporate chef"),
                  category(3, "Executive chef"),

                ],
              ),
            ),
          ),
        ],
      ));
  Widget job(BuildContext context, String position, String tag, String company,
      String location, String image) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>Job(
              position: position,
              company: company,
              location: location,
              isBookmark: true,
            )),
          );
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         child: Job(
          //           position: position,
          //           company: company,
          //           location: location,
          //           isBookmark: false,
          //         ),
          //         type: PageTransitionType.fade));
        },
        child: Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Card(
              shadowColor: Common().appColor,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Hero(
                      tag: tag,
                      child: Image.asset(
                        image,
                        width: 120,
                      ),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 190,
                          child: Text(position,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Common().appColor)),
                        ),
                        Container(
                          width: 190,
                          child: Text(company,
                              style: GoogleFonts.lato(
                                  fontSize: 18, color: Common().matteBlack)),
                        ),
                        Container(
                          width: 190,
                          child: Text(location,
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Common().matteBlack)),
                        ),
                        Divider(),
                        Container(
                            width: 190,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: Common().appColor),
                                    Text("20 minutes ago",
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            color: Common().appColor))
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )),
      );
  Widget recommendedJob(
      String position, String company, String location, String image) =>
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         child: Job(
                //           position: position,
                //           company: company,
                //           location: location,
                //           isBookmark: false,
                //         ),
                //         type: PageTransitionType.fade));
              },
              child: Card(
                shadowColor: Common().appColor,
                child: Container(
                  width: 280,
                  height: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Hero(
                          tag: company,
                          child: Image.asset(
                            image,
                            height: 120,
                          ),
                        ),
                      ),
                      Text(
                        position,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Common().appColor),
                      ),
                      Text(
                        company,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().appColor),
                      ),
                      Text(
                        location,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().appColor),
                      ),
                      Divider(),
                      Container(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Common().appColor),
                                Text("20 minutes ago",
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Common().appColor))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: Common().appColor,
                                ),
                                Text("Full-time",
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Common().appColor))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )));
  Widget recommendedJobList() => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 10),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(Common().recommendedJobs,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Common().appColor)),
                ))),
      ),
      Container(
          height: 260,
          //  decoration: BoxDecoration(color: Common().appColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                recommendedJob(
                  "Flutter Developer",
                  "IT Company",
                  "Singapore",
                  Common().ipsum2,
                ),
                recommendedJob(
                  "Full-stack Developer",
                  "IT Company",
                  "Ortigas Center, Pasig",
                  Common().ipsum3,
                ),
                recommendedJob("React Developer", "IT Company",
                    "Quezon City, PH", Common().ipsum),
                recommendedJob("Business Analyst", "IT Company",
                    "Quezon City, PH", Common().ipsum2),
                recommendedJob(
                    "SQL Developer",
                    "Simplexinternet Philippines, Inc.",
                    "National Capital Region",
                    Common().ipsum3),
                recommendedJob(
                    "QA Tester",
                    "IT Company",
                    "National Capital Region",
                    Common().ipsum2),
                recommendedJob("AppHosting Azure", "IT Company",
                    "National Capital Region", Common().ipsum2)
              ],
            ),
          )),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        actions: [IconButton(onPressed: (){
          addFilter();

        }, icon:Icon(FontAwesomeIcons.filter))],
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Kaarighar",style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Common().matteBlack)),),


        body: SafeArea(

          child:Column(
          children: [

            searchAndControler(context),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text("recent jobs",
                            style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Common().appColor)),
                      ))),
            ),
            Expanded(
                child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: FutureBuilder<List<JobData>>(
                          future: getJobs(),
                          builder: (BuildContext context, AsyncSnapshot<List<JobData>> snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting)
                            {
                              return Center(child: CircularProgressIndicator());
                            }
                            else if(snapshot.hasError){
                              return  Center(
                                child:Text( 'No jobs'+snapshot.error.toString()),
                              );
                            }
                            else
                              return  Container(
                                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: ListView.builder(
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext context,int index){
                                      return jobTile(index,snapshot.data![index]);
                                    }),
                              );

                          }

                      ),
                    )))
          ],
      ),
        ),
    );
  }
  Future<void> addFilter() async {

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
                    title: Text("Filter",style: TextStyle(color: Theme.of(context).accentColor),),),
                  Container(
                    child:  Column(children: [





                      SizedBox(height:10),
                      Container(
                        margin: EdgeInsets.all(10),
                        child:
                        Card(   color: Colors.grey.shade300,
                          child: Column(
                            children: [
                              Container(

                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 10,left: 10),
                                  child: Text("Select current location",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.black),)),
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SelectState(
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



                            }, child: Text("Filter",style: GoogleFonts.lato(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),

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


  Widget jobTile(int index, JobData jobData) {
    return  InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JObSeekerJobDetail(jobData)),
        );
      },
      child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(


              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .start,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Container(

                    child: Text(jobData.name!,
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .primaryColor),),
                  ),
                  Container(

                    child: Text(
                      jobData.description!,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),),
                  ),
                  buildDetailRow("Department", jobData.department!.title!),
                  buildDetailRow("Designation", jobData.designation!.title!),
                  buildDetailRow("Cuisine name", "demo"),
                  Container(

                    child: Text(
                      "Location: "+ jobData!.location!.city!+","+jobData!.location!.state!,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      "From 3 days ago",
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),),
                  ),


                ],
              ))),
    );
  }
  Widget buildDetailRow(String title,String data){
    return Container(


        child: Row(
          children: [

            Container(
                child: Text(title, style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black))),Text(" : ", style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
            Text(data, style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
          ],
        ));
  }
  }


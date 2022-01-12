import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/employer/EmployeeMyJobScreen.dart';
import 'package:kaarighar/employer/KaarigharDetailScreen.dart';
import 'package:kaarighar/employer/model/Employee.dart';
import 'package:kaarighar/employer/model/KaarigharUser.dart';
import 'package:kaarighar/jobseeker/MyJobScreen.dart';
import 'package:kaarighar/jobseeker/job.dart';
import 'package:kaarighar/util/util.dart';

import 'EmployeeAddressScreen.dart';
import 'model/Category.dart';

class EmployeeHomeScreen extends StatefulWidget {
  @override
  _EmployeeHomeScreenState createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  int _currentIndex = 0;
  String searchKey = "";
  late Future<List<KaarigharUser>> userList;

  @override
  void initState() {
    super.initState();
    userList = getHistory();
    _currentIndex = 0;
  }

  Future<List<KaarigharUser>> getHistory() async {
    Dio dio = getDio();

    var response;

    if (true) {
      response = await dio.get('/api/users', options: await getHeaderOption());
    } else {
      response = await dio.get('/api/marketplace/search/' + searchKey,
          options: await getHeaderOption());
    }

    var json = response.data['data'] as List;

    List<KaarigharUser> listVideo =
        json.map((e) => KaarigharUser.fromJson(e)).toList();
    print("url_data:" + listVideo.toString());
    return listVideo;
  }

  Widget searchAndControler(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
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
                    hintText: "Search people",
                    hintStyle: GoogleFonts.lato(color: Common().appColor),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Common().appColor,
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
          width: 100,
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
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category(0, Common().all),
                  category(1, "My job"),
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
            MaterialPageRoute(
                builder: (context) => Job(
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
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                    recommendedJob("QA Tester", "IT Company",
                        "National Capital Region", Common().ipsum2),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewJobPost();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Kaarighar",
            style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Common().matteBlack)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_alt,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              addFilter();
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            searchAndControler(context),
            Expanded(
                child: Container(
                    child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Text("Recents kaarighars",
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
                    child: FutureBuilder<List<KaarigharUser>>(
                        future: userList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<KaarigharUser>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return BasicLoader();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('No kaarighar available!'),
                            );
                          } else {
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5.0,
                                  mainAxisSpacing: 5.0,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return buildKarighar(
                                      context, index, snapshot.data![index]);
                                });
                          }
                        }),
                  )))
                ],
              ),
            )))
          ],
        ),
      ),
    );
  }

  Future<void> addNewJobPost() async {
    Dio dio = getDio();
    String userId = "";

    List<Category>? categoryList;
    List<SubCategory>? subCategoryList;
    TextEditingController titleController=TextEditingController();
    TextEditingController descriptionController=TextEditingController();
    TextEditingController vacancyController=TextEditingController();
    TextEditingController salaryController=TextEditingController();
    Category? selectedDepartment;
    SubCategory? selectedDesignation;
    Address? selectedAddress;
    String? selectedCuisne;
    categoryList=await getDepartment();
    final _formKey = GlobalKey<FormState>();
    var responseAddress = await dio.get('/api/user/profile/address/all',
        options: await getHeaderOption());
    var jsonaddress = responseAddress.data["address"] as List;
    if(jsonaddress.isEmpty)
      AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Need to add address before posting job',
          desc: 'You want to add this address?',


          btnOkOnPress: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmployeeAddressScreen()),
            );



          },

          btnCancelOnPress: ()async{

            Navigator.pop(context);

          }
      )..show();
    else {
      List<Address> listAddress =
      jsonaddress.map((e) => Address.fromJson(e)).toList();

      bool hasError = false;
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            decoration: new BoxDecoration(
                color: Theme
                    .of(context)
                    .primaryColor,
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Padding(
              padding: MediaQuery
                  .of(context)
                  .viewInsets,
              child: StatefulBuilder(

                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          AppBar(
                            backgroundColor: Colors.transparent,
                            leading: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Theme
                                    .of(context)
                                    .accentColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            elevation: 0,
                            centerTitle: true,
                            title: Text(
                              "Add Job",
                              style: TextStyle(color: Theme
                                  .of(context)
                                  .accentColor),
                            ),
                          ),
                          Container(
                            height: 600,
                            child: SingleChildScrollView(
                              child: Container(

                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [

                                      Container(

                                          margin: EdgeInsets.all(10),
                                          child:
                                          Card(color: Colors.grey.shade300,
                                              child: Column(children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: categoryList != null
                                                      ? DropdownSearch<
                                                      Category>(
                                                    mode: Mode.MENU,
                                                    showSelectedItems: false,
                                                    itemAsString: (val) =>
                                                    val!.title!,
                                                    items: categoryList,
                                                    label:
                                                    "Select department",
                                                    hint: "Select department",
                                                    onChanged: (value) async {
                                                      showLoader(context);
                                                      subCategoryList =
                                                      await getdesgination(
                                                          value!.sId!);
                                                      selectedDepartment =
                                                          value;
                                                      setState(() {});
                                                      dissmissLoader(context);
                                                    },
                                                  )
                                                      : Container(),
                                                ),

                                                subCategoryList != null
                                                    ? Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: DropdownSearch<
                                                      SubCategory>(
                                                    mode: Mode.MENU,
                                                    showSelectedItems: false,
                                                    itemAsString: (val) =>
                                                    val!.title!,
                                                    items: subCategoryList,
                                                    label:
                                                    "Select designation",
                                                    hint:
                                                    "Select designation",
                                                    onChanged: (value) async {
                                                      selectedDesignation =
                                                          value;
                                                      // showLoader(context);
                                                      // subCategoryList=await getdesgination(value!.sId!);
                                                      // setState(() {
                                                      //
                                                      // });
                                                      // dissmissLoader(context);
                                                    },
                                                  ),
                                                )
                                                    : Container(),
                                                SizedBox(height: 10),
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
                                                      'Japanese',
                                                      'Others'
                                                    ],
                                                    label: "Select cuisine",
                                                    hint: "select cuisine",
                                                    onChanged: (value) {
                                                      selectedCuisne = value;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: listAddress != null
                                                      ? DropdownSearch<Address>(

                                                    mode: Mode.MENU,
                                                    showSelectedItems: false,
                                                    itemAsString: (val) =>
                                                    val!.addressType!,
                                                    items: listAddress,
                                                    label:
                                                    "Select address",
                                                    hint: "Select address",
                                                    onChanged: (value) async {
                                                      selectedAddress = value!;
                                                    },
                                                  )
                                                      : Container(),
                                                ),


                                              ],))),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.text,
                                          controller: titleController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(

                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              isDense: false,
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: "Enter Title"),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(

                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: descriptionController,
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(

                                            hintText: "Enter description",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                            ),
                                            isDense: false,
                                            filled: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(height: 10),
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: vacancyController,
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(

                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              isDense: false,
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: "Enter Vacancy"),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(

                                        margin: EdgeInsets.all(10),
                                        child: TextFormField(
                                          controller: salaryController,
                                          style: TextStyle(color: Colors.black),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }

                                            return null;
                                          },
                                          decoration: InputDecoration(

                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(10),
                                              ),
                                              isDense: false,
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: "Enter salary"),
                                        ),
                                      ),
                                      SizedBox(height: 10),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            width: 100,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.all(12),
                                    primary: Theme
                                        .of(context)
                                        .primaryColor,
                                    backgroundColor:
                                    Theme
                                        .of(context)
                                        .accentColor),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Dio dio = getDio();
                                    if (selectedDepartment == null)
                                      showError(context,
                                          "Please select department");
                                    else if (selectedDesignation == null)
                                      showError(context,
                                          "Please select designation");
                                    else if (selectedAddress == null)
                                      showError(context,
                                          "Please select address");
                                    else if (selectedCuisne == null)
                                      showError(context,
                                          "Please select cuisne");
                                    else {
                                      showLoader(context);
                                      try {
                                        var response = await dio.post(
                                            '/api/job',
                                            options: await getHeaderOption(),
                                            data:

                                            {
                                              "name": titleController
                                                  .text,
                                              "parent": "619352d1cbc8362e6cd1c1e9",
                                              'cuisine_name': selectedCuisne,
                                              'currentSalary': salaryController
                                                  .text,
                                              "noRole": vacancyController
                                                  .text,
                                              "positon": "Intern",
                                              "location": selectedAddress!
                                                  .toJson(),
                                              "department": selectedDepartment!
                                                  .sId,
                                              "designation": selectedDesignation!
                                                  .sId,
                                              "description": descriptionController
                                                  .text
                                            }


                                        );
                                        print(
                                            "res:" + response.toString());

                                        dissmissLoader(context);
                                        setState(() {

                                        });

                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmployeeMyJobScreen()),
                                        );
                                      }
                                      catch (e) {
                                        dissmissLoader(context);
                                        Navigator.pop(context);
                                        print(e.toString());
                                      }
                                    }
                                  }
                                },
                                child: Text(
                                  "Add",
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  }

              ),
            ),
          );
        },
      );
    }
  }

  Widget buildKarighar(BuildContext context, int index, KaarigharUser item) {
    return Container(
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => KaarigharDetailScreen(item)),
          );
        },
        child: Card(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(item.firstName![0]! + item.lastName![0]),
                ),
                Container(
                    child: Text(
                  item.firstName! + " " + item.lastName!,
                  style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Common().appColor,
                      fontWeight: FontWeight.bold),
                )),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10),
                  child: Text(
                    "City:" + item!.currentLocation!.city!,
                    style: GoogleFonts.lato(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Common().matteBlack),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addFilter() async {
    Dio dio = getDio();
    String userId = "";
    List<Category>? categoryList;
    List<SubCategory>? subCategoryList;
    Category? selectedDepartment;
    SubCategory? selectedDesignation;
    String? selectedCuisne;

    categoryList = await getDepartment();

    String currentLocationState = "", currentLocationCity = "";

    bool hasError = false;
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        isDismissible: true,
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
                              SizedBox(
                                height: 5,
                              ),
                              AppBar(
                                backgroundColor: Colors.transparent,
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                elevation: 0,
                                centerTitle: true,
                                title: Text(
                                  "Filter",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      child: Card(
                                        color: Colors.grey.shade300,
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: Text(
                                                  "Select current location",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                            Container(
                                              margin: EdgeInsets.all(20),
                                              child: SelectState(
                                                onCountryChanged: (value) {
                                                  setState(() {});
                                                },
                                                onStateChanged: (value) {
                                                  setState(() {
                                                    currentLocationState =
                                                        value!;
                                                  });
                                                },
                                                onCityChanged: (value) {
                                                  setState(() {
                                                    currentLocationCity =
                                                        value!;
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
                                      child: Card(
                                        color: Colors.grey.shade300,
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: Text(
                                                  "Select current field",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                )),
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: categoryList != null
                                                  ? DropdownSearch<Category>(
                                                      mode: Mode.MENU,
                                                      showSelectedItems: false,
                                                      itemAsString: (val) =>
                                                          val!.title!,
                                                      items: categoryList,
                                                      label:
                                                          "Select department",
                                                      hint: "Select department",
                                                      onChanged: (value) async {
                                                        showLoader(context);
                                                        subCategoryList =
                                                            await getdesgination(
                                                                value!.sId!);
                                                        selectedDepartment =
                                                            value;
                                                        setState(() {});
                                                        dissmissLoader(context);
                                                      },
                                                    )
                                                  : Container(),
                                            ),
                                            SizedBox(height: 10),
                                            subCategoryList != null
                                                ? Container(
                                                    margin: EdgeInsets.all(10),
                                                    child: DropdownSearch<
                                                        SubCategory>(
                                                      mode: Mode.MENU,
                                                      showSelectedItems: false,
                                                      itemAsString: (val) =>
                                                          val!.title!,
                                                      items: subCategoryList,
                                                      label:
                                                          "Select designation",
                                                      hint:
                                                          "Select designation",
                                                      onChanged: (value) async {
                                                        selectedDesignation =
                                                            value;
                                                        // showLoader(context);
                                                        // subCategoryList=await getdesgination(value!.sId!);
                                                        // setState(() {
                                                        //
                                                        // });
                                                        // dissmissLoader(context);
                                                      },
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(height: 10),
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
                                                  'Japanese',
                                                  'Others'
                                                ],
                                                label: "Select cuisine",
                                                hint: "select cuisine",
                                                onChanged: (value) {
                                                  selectedCuisne = value;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      width: 100,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.all(12),
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              backgroundColor: Theme.of(context)
                                                  .accentColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Filter",
                                            style: GoogleFonts.lato(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))),
          );
        });
  }

  Future<List<Category>> getDepartment() async {
    Dio dio = getDio();
    String userId = "";

    var response = await dio.get('/api/admin/category/all',
        options: await getHeaderOption());
    var json = response.data['data'] as List;

    List<Category> listVideo = json.map((e) => Category.fromJson(e)).toList();
    print("url_data:" + response.data.toString());
    return listVideo;
  }

  Future<List<SubCategory>> getdesgination(String id) async {
    Dio dio = getDio();
    String userId = "";

    var response = await dio.get('/api/admin/subcategory/parent/' + id,
        options: await getHeaderOption());
    var json = response.data['data'] as List;

    List<SubCategory> listVideo =
        json.map((e) => SubCategory.fromJson(e)).toList();
    print("url_data:" + response.data.toString());
    return listVideo;
  }
}

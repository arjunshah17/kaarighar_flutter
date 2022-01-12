import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/employer/model/JobData.dart';
import 'package:kaarighar/jobseeker/job.dart';
import 'package:kaarighar/util/util.dart';

import 'JobSeekerJobDetail.dart';
class MyJobScreen extends StatefulWidget {


  @override
  _MyJobScreenState createState() => _MyJobScreenState();
}

class _MyJobScreenState extends State<MyJobScreen> {


  int _currentIndex = 0;

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
          width: 70,
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
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("My job",style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Common().matteBlack)),),

      body: SafeArea(

        child:Column(
          children: [

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
  Future<List<JobData>> getJobs() async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/user/profile/jobs',
        options:await  getHeaderOption()


    );
    var json=response.data["data"] as List;
    print("url_data:"+response.data.toString());
    List<JobData> listVideo=json.map((e) => JobData.fromJson(e)).toList();

    return listVideo;

  }
}

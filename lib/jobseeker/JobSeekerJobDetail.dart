
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/employer/model/JobData.dart';
import 'package:kaarighar/util/util.dart';


class JObSeekerJobDetail extends StatefulWidget {
  final JobData jobData;

  const JObSeekerJobDetail(this.jobData);
  @override
  _JObSeekerJobDetailState createState() => _JObSeekerJobDetailState();
}

class _JObSeekerJobDetailState extends State<JObSeekerJobDetail> {

  @override
  void initState() {
    super.initState();

  }



  Widget textWidget(String text1, String text2) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text1,
                    style: GoogleFonts.lato(color: Common().appColor, fontWeight: FontWeight.w600)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text2,
                    style: GoogleFonts.lato(
                        color: Common().appColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        ),
      ));
  Widget socials(String social) => Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Container(
      decoration: BoxDecoration(
          color: Common().appColor,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Text(social, style: GoogleFonts.lato(color: Common().white)),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,

          title: Text("Job Detail",style: TextStyle(color: Colors.white),),),
        body: SafeArea(
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/ipsum2.png"),
                            fit: BoxFit.fitWidth)),
                  ),
                ],
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 0),
                      child: Container(
                        child: Column(
                          children: [
                            textWidget("Title: ", widget.jobData.name!),
                            textWidget("Department: ", widget.jobData.department!.title!),
                            textWidget("Designation: ", widget.jobData.designation!.title!),
                            textWidget("Cuisine name: ", ""),
                            textWidget("vacancy: ", widget.jobData.noRole!),
                            textWidget("Company: ", widget.jobData!.recruiter!.company!.companyName!),
                            textWidget("Location: ", widget.jobData.location!.addressLine1!),
                            SizedBox(
                              height: 10,
                            ),
                            textWidget("Description: ", widget.jobData!.description!),

                            Divider(),
                          ],
                        ),
                      ),
                    ),
                  )),
              Container(

                margin: EdgeInsets.only(left: 10,right: 10),




                child: TextButton(








                    style: TextButton.styleFrom(

                        shape:
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),





                        padding: EdgeInsets.all(10),

                        primary: Theme.of(context).primaryColor,

                        backgroundColor: Theme.of(context).primaryColor

                    ),

                    onPressed: () async {

                      var user=await getUserJob();
                      Dio dio=getDio();
                      showLoader(context);
                      var response = await dio.post('/api/job/apply/'+widget.jobData.sId!,
                          options: await getHeaderOption(),
                          data:
                          {

                          }


                      );
                      print("res:" + response.toString());
                      showSuccess(context,response.data["message"]);
                      dissmissLoader(context);
                      Navigator.of(context).pop();


                    }, child: Text("Apply now",style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),

              ),
            ],
          ),
        ));

  }
}

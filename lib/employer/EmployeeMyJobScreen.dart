import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/EmployerJobDetail.dart';
import 'package:kaarighar/employer/model/JobData.dart';
import 'package:kaarighar/jobseeker/MyJobScreen.dart';
import 'package:kaarighar/jobseeker/job.dart';
import 'package:kaarighar/util/util.dart';
class EmployeeMyJobScreen extends StatefulWidget {


  @override
  _EmployeeMyJobScreenState createState() => _EmployeeMyJobScreenState();
}

class _EmployeeMyJobScreenState extends State<EmployeeMyJobScreen> {

  Future<List<JobData>> getJobs() async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/job',
        options:await  getHeaderOption()


    );
    var json=response.data["data"] as List;
    print("url_data:"+response.data.toString());
    List<JobData> listVideo=json.map((e) => JobData.fromJson(e)).toList();

    return listVideo;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(     backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),

        centerTitle: true,
        title: Text("My jobs",style: TextStyle(color: Colors.white),),),
      body:FutureBuilder<List<JobData>>(
        future: getJobs(),
    builder: (BuildContext context, AsyncSnapshot<List<JobData>> snapshot){
    if(snapshot.connectionState==ConnectionState.waiting)
    {
    return Center(child: CircularProgressIndicator());
    }
    else if(snapshot.hasError){
    return  Center(
    child:Text( 'No jobs'),
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

            ));


  }

  Widget jobTile(int index, JobData jobData) {
  return  InkWell(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployeeJobDetail(jobData)),
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

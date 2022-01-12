
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/employer/KaarigharDetailScreen.dart';
import 'package:kaarighar/employer/model/JobData.dart';
import 'package:kaarighar/employer/model/KaarigharUser.dart';


class EmployeeJobDetail extends StatefulWidget {
  final JobData jobData;

  const EmployeeJobDetail(this.jobData);
  @override
  _EmployeeJobDetailState createState() => _EmployeeJobDetailState();
}

class _EmployeeJobDetailState extends State<EmployeeJobDetail> {

  @override
  void initState() {
    super.initState();

  }


  Widget getScreenDetail(){
    return Expanded(
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
                  textWidget("Cuisine name: ",""),
                  textWidget("vacancy: ", widget.jobData!.noRole!),
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
        ));
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
                    "City:" + "hh",
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

    return  DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
    bottom: TabBar(
    tabs: [
    Tab(text: "Detail",),
    Tab(text: "Kaarighars",),

    ]),
            
            actions: [
              IconButton(onPressed: (){

              }, icon: Icon(Icons.delete,color: Colors.red,))
            ],
            title: Text("Job Detail",style: TextStyle(color: Colors.white),),),
          body: SafeArea(
            child: TabBarView(
              children: [
                ListView(
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
                    getScreenDetail()

                  ],
                ),
                widget.jobData.candidate!=null?GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: widget.jobData.candidate!.length,
                    itemBuilder: (context, index) {
                      return buildKarighar(
                          context, index,widget.jobData.candidate![index]);
                    }):Center(child:Text("No kaarighar have applied"))
              ],
            ),
          )),
    );



  }
}

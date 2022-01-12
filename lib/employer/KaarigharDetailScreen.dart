import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/model/KaarigharUser.dart';
import 'package:url_launcher/url_launcher.dart';
class KaarigharDetailScreen extends StatefulWidget {
final KaarigharUser _user;

  const KaarigharDetailScreen(this._user);

  @override
  _KaarigharDetailScreenState createState() => _KaarigharDetailScreenState();
}

class _KaarigharDetailScreenState extends State<KaarigharDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          contactNow(widget._user);
        },
        child: Icon(Icons.phone),
      ),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),

        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Kaarighar detail",style: TextStyle(color: Colors.white),),),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            SizedBox(height:10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10,left: 5),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text("Personal details",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      )),
                  Container(
                    alignment: Alignment.topLeft,

                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                     buildDetailRow("Name", widget._user!.firstName!+" "+widget._user!.lastName!),
                        buildDetailRow("Mobile", widget._user.mobileNumber!),
                        buildDetailRow("Email", widget._user.email!),
                        buildDetailRow("Current state", widget._user!.currentLocation!.state!),
                        buildDetailRow("Current city", widget._user!.currentLocation!.city!),
                        buildDetailRow("Department", widget._user.department!.title!),
                        buildDetailRow("Designation",widget._user.designation!.title!),

                      ],

                    ),

                  ),
                ],
              ),
            ),
            SizedBox(height:10),
            Card(  elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10,left: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text("Education qualification",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      )),
                  widget._user!.education!=null?    Container(
                    alignment: Alignment.topLeft,

                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildDetailRow("Education level", widget._user!.education![0].fieldofstudy!),
                        buildDetailRow("Collage name", widget._user!.education![0].school!),
                        buildDetailRow("Description", widget._user!.education![0].description!),
                      ],

                    ),

                  ):Container(),
                ],
              ),
            ),
            SizedBox(height:10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey.shade300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(

                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10,left: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [

                          Text("Work experience",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                        ],
                      )),
                  widget._user!.education!=null?    Column(
                    children: [
                      Card(
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.topLeft,

                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildDetailRow("Resturant name", "Mcdonald"),
                              buildDetailRow("time", "20-oct-2015 to now"),
                              buildDetailRow("Department", "Kitchen Hierarchy"),
                              buildDetailRow("Designation", "Directors of kitchen")
                            ],

                          ),

                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.topLeft,

                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildDetailRow("Resturant name", "Mcdonald"),
                              buildDetailRow("time", "20-oct-2015 to now"),
                              buildDetailRow("Department", "Kitchen Hierarchy"),
                              buildDetailRow("Designation", "Directors of kitchen")
                            ],

                          ),

                        ),
                      ),
                      Card(
                        color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.topLeft,

                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              buildDetailRow("Resturant name", "Mcdonald"),
                              buildDetailRow("time", "20-oct-2015 to now"),
                              buildDetailRow("Department", "Kitchen Hierarchy"),
                              buildDetailRow("Designation", "Directors of kitchen")
                            ],

                          ),

                        ),
                      ),
                    ],
                  ):Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildDetailRow(String title,String data){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),

        child: Row(
          children: [

            Container(
                width:100,
                child: Text(title)),Text(" : "),
            Text(data),
          ],
        ));
  }

  void contactNow(KaarigharUser item){
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
              builder: (BuildContext context, StateSetter setter) {
                return
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
                          title: Text("Contact details",style: TextStyle(color: Theme.of(context).accentColor),),),

                        Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    launch("mailto:"+item!.email!);
                                  },
                                  child: Container(child: Row(
                                    children: [
                                      Icon(Icons.mail,color:Theme.of(context).accentColor,),
                                      SizedBox(width: 5,),
                                      Text("Email: "+item.email!,style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),),

                                    ],
                                  )),
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: (){
                                    launch("tel://"+item.mobileNumber!);
                                  },
                                  child: Container(child: Row(
                                    children: [
                                      Icon(Icons.phone,color:Theme.of(context).accentColor,),
                                      SizedBox(width: 5,),
                                      Text("Mobile no: "+item.mobileNumber!,style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),),

                                    ],
                                  )),
                                ),


                              ],
                            ),
                          ),
                        )


                      ],
                    ),
                  );},
            ),
          ),
        );
      },
    );
  }
}

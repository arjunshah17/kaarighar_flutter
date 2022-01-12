import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
class EmployeeSubcription extends StatefulWidget {


  @override
  _EmployeeSubcriptionState createState() => _EmployeeSubcriptionState();
}

class _EmployeeSubcriptionState extends State<EmployeeSubcription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Subscription"),),
      body: ListView(
        children: [Container(
      margin: EdgeInsets.symmetric(
      vertical: 10, horizontal: 10),
      child: Card(
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
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

                    child: Text("₹ 200 /per month",
                      style: GoogleFonts.lato(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .primaryColor),),
                  ),
                  Container(

                    child: Text(
                      "subscribe for 1 month at ₹ 200",
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 10,right: 10),




                    child: TextButton(








                        style: TextButton.styleFrom(

                            shape:
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),





                            padding: EdgeInsets.all(10),

                            primary: Theme.of(context).primaryColor,

                            backgroundColor: Theme.of(context).primaryColor

                        ),

                        onPressed: (){




                        }, child: Text("Subscribe now",style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),

                  ),
                ],
              )
          )
      ),

    ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
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

                          child: Text("₹ 200 /per month",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme
                                    .of(context)
                                    .primaryColor),),
                        ),
                        Container(

                          child: Text(
                            "subscribe for 1 month at ₹ 200",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 10,right: 10),




                          child: TextButton(








                              style: TextButton.styleFrom(

                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),





                                  padding: EdgeInsets.all(10),

                                  primary: Theme.of(context).primaryColor,

                                  backgroundColor: Theme.of(context).primaryColor

                              ),

                              onPressed: (){




                              }, child: Text("Subscribe now",style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),

                        ),
                      ],
                    )
                )
            ),

          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            child: Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
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

                          child: Text("₹ 200 /per month",
                            style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme
                                    .of(context)
                                    .primaryColor),),
                        ),
                        Container(

                          child: Text(
                            "subscribe for 1 month at ₹ 200",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 10,right: 10),




                          child: TextButton(








                              style: TextButton.styleFrom(

                                  shape:
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),





                                  padding: EdgeInsets.all(10),

                                  primary: Theme.of(context).primaryColor,

                                  backgroundColor: Theme.of(context).primaryColor

                              ),

                              onPressed: (){




                              }, child: Text("Subscribe now",style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),

                        ),
                      ],
                    )
                )
            ),

          )
        ],
      ),
    );
  }
}

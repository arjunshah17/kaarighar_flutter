import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:states_and_ut_india/states_and_ut_india.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/employer/EmployeeAddressForm.dart';
import 'package:kaarighar/employer/model/Employee.dart';
import 'package:kaarighar/util/util.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
class JobWorkScreen extends StatefulWidget {


  @override
  _JobWorkScreenState createState() => _JobWorkScreenState();
}

class _JobWorkScreenState extends State<JobWorkScreen> {

  Future<List<Address>> getAddress() async {
    Dio dio=getDio();
    String userId="";

    var  response = await dio.get(
        '/api/user/profile/address/all',
        options:await  getHeaderOption()


    );
    var json=response.data["address"] as List;
    print("url_data:"+response.data.toString());
    List<Address> listVideo=json.map((e) => Address.fromJson(e)).toList();

    return listVideo;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      FloatingActionButton.extended(
        label: Text("Add address"),
        icon:Icon(Icons.add) ,
        onPressed: () async {

          LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PlacePicker("AIzaSyAek3NV8k5S4xqnMESpxeLO56FqVT45S4g",
                  )));

          // Handle the result in your way
          print("loc_data:"+result.toString());

          addNewAddress(result);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Address"),),
      body: FutureBuilder<List<Address>>(
          future: getAddress(),
          builder: (BuildContext context, AsyncSnapshot<List<Address>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError){
              return  Center(
                child:Text( 'No Address'),
              );
            }
            else
              return  ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context,int index){
                    return  Container(
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

                                    child: Text( snapshot.data![index].addressType!,
                                      style: GoogleFonts.lato(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Theme
                                              .of(context)
                                              .primaryColor),),
                                  ),
                                  Container(

                                    child: Text(
                                      snapshot.data![index].addressLine1!,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(top: 10,right:2),




                                    child:Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // IconButton(icon: Icon(Icons.edit,color: Theme.of(context).primaryColor),onPressed: (){
                                        //
                                        // },),

                                        IconButton(icon: Icon(Icons.delete,color: Colors.red),onPressed: (){
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.INFO,
                                              animType: AnimType.BOTTOMSLIDE,
                                              title: 'Are you sure you want to delete',
                                              desc: 'You want to delete this address?',


                                              btnOkOnPress: () async {
                                                var userId=await getUserId();
                                                print("userID:"+userId!);
                                                Dio dio=getDio();
                                                showLoader(context);
                                                var response = await dio.delete('/api/user/profile/address/'+snapshot.data![index]!.sId!,
                                                    options: await getHeaderOption(),
                                                    data:
                                                    {

                                                    }


                                                );
                                                print("res:" + response.toString());
                                                dissmissLoader(context);
                                                setState(() {

                                                });


                                              },

                                              btnCancelOnPress: ()async{

                                                Navigator.pop(context);

                                              }
                                          )..show();
                                        },),
                                      ],
                                    ),

                                  ),
                                ],
                              )
                          )
                      ),

                    );

                  });}
      ),
    );
  }
  void addNewAddress( LocationResult loc){
    TextEditingController titleController=new TextEditingController();
    TextEditingController addressController=new TextEditingController();
    TextEditingController pincodeController=new TextEditingController();
    TextEditingController stateController=new TextEditingController();
    TextEditingController cityController=new TextEditingController();
    addressController.text=loc.formattedAddress!;
    pincodeController.text=loc.postalCode;

    String    currentLocationState="",currentLocationCity="";

    cityController.text=loc.city!.shortName!;
    final _formKey = GlobalKey<FormState>();
    bool hasError = false;
    showModalBottomSheet<void>(


      context: context,
      isDismissible:true,
      isScrollControlled: true,




      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(

          decoration: new BoxDecoration(
              color: Theme.of(context).primaryColor,

              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),

          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(

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
                    title: Text("Add address",style: TextStyle(color: Theme.of(context).accentColor),),),
                  Container(

                    child:   Form(
                      key: _formKey,
                      child: Column(children: [

                        Container(

                          margin: EdgeInsets.all(10),

                          child: TextFormField(
                            controller: titleController,

                            style: TextStyle(color: Colors.black),



                            keyboardType:TextInputType.text,





                            validator: (value) {

                              if (value == null || value.isEmpty) {

                                return 'Please enter some text';

                              }

                              return null;

                            },





                            decoration: InputDecoration(

                                  isDense: false,



                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),

                                ),







                                filled: true,



                                fillColor: Colors.white,





                                labelText: "Enter Title"

                            ),

                          ),

                        ),



                        SizedBox(height:10),

                        Container(

                          margin: EdgeInsets.all(10),

                          child: TextFormField(
                            controller: addressController,
                            minLines: 3,
                            style: TextStyle(color: Colors.black),



                            keyboardType:TextInputType.multiline,

                            maxLines: null,






                            validator: (value) {

                              if (value == null || value.isEmpty) {

                                return 'Please enter some text';

                              }

                              return null;

                            },





                            decoration: InputDecoration(

                                  isDense: false,

                              hintText: "Enter street address",





                              border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(10),

                              ),







                              filled: true,



                              fillColor: Colors.white,







                            ),

                          ),

                        ),



                        SizedBox(height:10),

                        Container(

                          margin: EdgeInsets.all(10),

                          child: TextFormField(
                            controller: pincodeController,

                            style: TextStyle(color: Colors.black),



                            keyboardType:TextInputType.number,





                            validator: (value) {

                              if (value == null || value.isEmpty) {

                                return 'Please enter some text';

                              }

                              return null;

                            },





                            decoration: InputDecoration(

                                  isDense: false,



                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10),

                                ),







                                filled: true,



                                fillColor: Colors.white,





                                hintText: "Enter pincode"

                            ),

                          ),

                        ),










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
                                    selectedState:INStates.getName(loc.administrativeAreaLevel1.shortName),
                                    selectedCity: loc.city.name,
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

                        SizedBox(height:10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),



                          width: 100,

                          child: TextButton(








                              style: TextButton.styleFrom(





                                  padding: EdgeInsets.all(12),

                                  primary: Theme.of(context).primaryColor,

                                  backgroundColor: Theme.of(context).accentColor

                              ),

                              onPressed: () async {

                                if(_formKey.currentState!.validate()) {
                                  Dio dio=getDio();
                                  showLoader(context);
                                  try {

                                    List<Address> add= await   getAddress();
                                    String json = "";
                                    for(Address value in add){
                                      json= value.toJson().toString()+",";
                                    }

                                    var response = await dio.post('/api/user/profile/address',
                                        options:await getHeaderOption(),
                                        data:
                                        {
                                          "address" : [{
                                            "addressType":titleController.value.text,
                                            "addressLine1":addressController.value.text,
                                            "addressLine2":"Vejalpur, Vejalpur Road",
                                            "city":currentLocationCity,
                                            "state": currentLocationState,
                                            "country": "India",
                                            "pincode": pincodeController.value.text,
                                            "longitude": loc.latLng.longitude,
                                            "latitude":  loc.latLng.latitude
                                          }]
                                        }



                                    );
                                    print("res:" + response.toString());
                                    dissmissLoader(context);
                                    setState(() {

                                    });

                                    Navigator.pop(context);
                                  }
                                  catch(e){
                                    dissmissLoader(context);
                                    Navigator.pop(context);
                                    print(e.toString());


                                  }}




                              }, child: Text("Add",style: GoogleFonts.lato(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),

                        ),

                      ],),
                    ),
                  )

                ],
              ),
            ),
          ),
        );
      },
    );

  }
}

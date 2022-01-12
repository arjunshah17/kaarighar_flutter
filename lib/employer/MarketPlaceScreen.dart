import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kaarighar/employer/model/EmployeeUser.dart';
import 'package:place_picker/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kaarighar/common/Util.dart';
import 'package:kaarighar/common/common.dart';
import 'package:kaarighar/common/constants.dart';
import 'package:kaarighar/jobseeker/job.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaarighar/model/model/MarketPlace.dart';
import 'package:kaarighar/util/util.dart';
class MarketPlaceScreen extends StatefulWidget {

  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  int _currentIndex = 0;
  EmployeeUser? userId;
  String mainFilter="all";
  String searchKey="";

 late Future<List<MarketPlace>> marketListData;
  Future<List<MarketPlace>> getHistory(String filter) async {
    Dio dio=getDio();

    var response;
    if(filter=="all") {
      if(searchKey.length<3) {
        response = await dio.get(
            '/api/marketplace/all',
            options: await getHeaderOption()


        );
      }
      else{
        response = await dio.get(
            '/api/marketplace/search/'+searchKey,
            options: await getHeaderOption()


        );

      }
}
else{
  response = await dio.get(
      '/api/marketplace',
      options: await getHeaderOption()


  );
}

    var json=response.data["data"] as List;

    List<MarketPlace> listVideo=json.map((e) => MarketPlace.fromJson(e)).toList();
    print("url_data:"+listVideo.toString());
    return listVideo;

  }
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      userId=await getUserEmployee();
    });

  marketListData=  getHistory("all");
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
              onChanged: (value){
                if(value.length>=3){
                  searchKey=value;
                  marketListData=getHistory("all");
                  setState(() {

                  });

                }
                else{

                  searchKey="";
                  marketListData=getHistory("all");
                  setState(() {

                  });
                }

              },
              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: false,
                hintText: "Search products",
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

  Widget category(int index, String title) => Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
            if(index==0)
              marketListData=getHistory("all");
            else
              marketListData=getHistory("me");
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
            padding: const EdgeInsets.only(bottom:10,top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category(0, Common().all),
                  category(1, "My ads"),

                ],
              ),
            ),
          ),
        ],
      ));
  
  
  Widget buildMarketItem(BuildContext context,int  index,MarketPlace item)  {

   return Padding(
            padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Card(
              shadowColor: Common().appColor,
              child: Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(

                      child: Row(children:[ CircleAvatar(child: Text(item.recruiter!.firstName![0]!+item.recruiter!.lastName![0]),), Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(item.recruiter!.firstName!,style: GoogleFonts.lato(
                            fontSize: 15,
                            color: Common().appColor),),
                      )],),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5,right: 10),

                      child: Text(item.name!,style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Common().appColor),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5,right: 10),

                      child: Text("Description:"+item.description!,style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Common().matteBlack),),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10,top: 5,right: 10),

                      child: Text("Price:"+"₹"+item!.price.toString()!,style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Common().matteBlack),),
                    ),
  Container(
  child: ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.network(
  item.image!,
  height: 200.0,
  fit: BoxFit.fitWidth,
  width:  MediaQuery.of(context).size.width,
  ),
  ),
  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 5,right: 10),




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

contactNow(item);


                              }, child: Text("Contact now",style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),

                        ),
                      item.recruiter!.sId==userId!.sId!? IconButton(onPressed: (){

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.INFO,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Are you sure you want to delete',
                          desc: 'You want to delete this ad?',


                          btnOkOnPress: () async {
                            var userId=await getUserId();
                            print("userID:"+userId!);
                        Dio dio=getDio();
                        showLoader(context);
                            var response = await dio.delete('/api/marketplace/'+item!.sId!,
                                options: await getHeaderOption(),
                                data:
                                {

                                }


                            );
                            print("res:" + response.toString());
                            dissmissLoader(context);
                            setState(() {
                           marketListData=   getHistory("all");
                            });


                          },

                          btnCancelOnPress: ()async{

                            Navigator.pop(context);

                          }
                        )..show();
                        }, icon: Icon(Icons.delete,color:Colors.red)):Container()
                      ],
                    ),
                  ],
                ),
              ),
            ));}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addNewProductPost();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Marketplace",style: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Common().matteBlack)),),

      body: SafeArea(

        child: Column(
          children: [

            searchAndControler(context),
            jobCategories(context),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text("Recents ads",
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
                      child: FutureBuilder<List<MarketPlace>>(
                        future: marketListData,
    builder: (BuildContext context, AsyncSnapshot<List<MarketPlace>> snapshot)
    {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return BasicLoader();
      }
      else if (snapshot.hasError) {
        return Center(
          child: Text('No product found!'),
        );
      }
      else {

    return    ListView.builder(
      itemCount: snapshot.data!.length,



        itemBuilder: (context,index){
        return buildMarketItem(context, index, snapshot.data![index]);
        }

        );
      }
    }
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void addNewProductPost(){

TextEditingController titleEditController=new TextEditingController();
TextEditingController descriptionController=new TextEditingController();
TextEditingController priceController=new TextEditingController();
final key= GlobalKey<FormState>();
PickedFile? mainImage;
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
            builder: (BuildContext context, StateSetter setter) {
             return
             Container(

                child: Form(
                  key:key ,
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
                        title: Text("Add product",style: TextStyle(color: Theme.of(context).accentColor),),),
                      Container(
                        height: 450,
                        child:   ListView(children: [

                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: InkWell(
                                onTap: () async {
                                  final _picker = ImagePicker();
                                  mainImage= (await _picker.getImage(source: ImageSource.gallery))!;
                                  setter(() {

                                  });

                                },
                                child:mainImage!=null? Image.file(File(mainImage!.path),

                                  height: 100,width: 100,): Image.asset(



                                 "assets/images/add.png"

                                  ,

                                  height: 100,width: 100,

                                ),
                              ),
                            ),
                          ),

                          Container(

                            margin: EdgeInsets.all(10),

                            child: TextFormField(
controller: titleEditController,

                              style: TextStyle(color: Colors.black),



                              keyboardType:TextInputType.text,





                              validator: (value) {

                                if (value == null || value.isEmpty ||value.length<3) {

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
                              controller: descriptionController,

                              style: TextStyle(color: Colors.black),



                              keyboardType:TextInputType.multiline,

                              maxLines: null,






                              validator: (value) {

                                if (value == null || value.isEmpty ||value.length<3) {

                                  return 'Please enter some text';

                                }

                                return null;

                              },





                              decoration: InputDecoration(

                                  isDense: false,

                                hintText: "Enter description",





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





                                  hintText: "Enter Price"

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

                                onPressed: () async {
                                  if(key.currentState!.validate())
                                    {
                                      if(mainImage!=null)
                                        {
try {
  Dio dio = getDio();
  showLoader(context);
  var uniqueValue=UniqueKey();
  var userId=await getUserEmployee();
  var uuid = Uuid();

// Generate a v1 (time-based) id


  var formData = FormData.fromMap({
    'name': titleEditController.text,
    'recruiter': userId!.sId!,
    'description': descriptionController.text,
    "price":priceController.text,
    "image": await MultipartFile
        .fromFile(mainImage!.path,  filename: 'market_'+uuid.generateV4(),
      contentType: MediaType('image', 'png'),

    )
  });
  var response = await dio.post('/api/marketplace/create',
      options: await getHeaderOption(),
      data:
      formData


  );
  print("res:" + response.toString());
  dissmissLoader(context);
  Navigator.pop(context);
  setState(() {
    marketListData =getHistory("all");
  });

}


catch(e){
  print(e.toString());
  dissmissLoader(context);
  Navigator.pop(context);
}}
                                      else{
                                        showError(context,"please upload image");
                                      }

}







                                }, child: Text("Add",style: GoogleFonts.lato(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),)),

                          ),

                          SizedBox(height:10),

                        ],),
                      )

                    ],
                  ),
                ),
              );},
            ),
          ),
        );
      },
    );

  }
void contactNow(MarketPlace item){
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
                                  launch("mailto:"+item.recruiter!.email!);
                                },
                                child: Container(child: Row(
                                children: [
                                  Icon(Icons.mail,color:Theme.of(context).accentColor,),
                                  SizedBox(width: 5,),
                                  Text("Email: "+item.recruiter!.email!,style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),),

                                ],
                            )),
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){
                                  launch("tel://"+item.recruiter!.mobileNumber!);
                                },
                                child: Container(child: Row(
                                  children: [
                                    Icon(Icons.phone,color:Theme.of(context).accentColor,),
                                    SizedBox(width: 5,),
                                    Text("Mobile no: "+item.recruiter!.mobileNumber!,style: TextStyle(fontSize: 18,color:Theme.of(context).accentColor),),

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



import 'package:flutter/material.dart';
import 'package:productui/purchase_history.dart';
import 'package:productui/screens/orders/order_screen.dart';
import 'package:productui/screens/user_profile/userprofilenew.dart';
import 'package:productui/screens/user_profile/viewprofile.dart';
import 'package:productui/screens/view_product/product.dart';
import 'package:productui/screens/view_work/view_work.dart';
import 'package:productui/user%20view%20artist.dart';
import 'package:productui/view_complaintmain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:smart_parking2/user/user_changepassword.dart';
// import 'package:smart_parking2/user/view_book.dart';
// import 'package:smart_parking2/user/view_complaint.dart';
// import 'package:smart_parking2/user/view_near_parking.dart';
// import 'package:smart_parking2/user/view_parking_location.dart';
import 'dart:convert';

import 'changepassword.dart';
import 'chat.dart';
import 'complaint.dart';
import 'feedback.dart';
//
// import 'package:smart_parking2/user/view_prof_new.dart';
// import 'package:smart_parking2/user/view_slot.dart';
//
// import 'Loginmain.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserHomePage(title: 'Register'),
    );
  }
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key, required this.title});


  final String title;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String photo='';
  String name='';
  String type='';

  String email='email';
  String phone='phone';

  String gender='gender';
  String image='image';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ipunique();
    senddata();
  }

  //stable ip address settings third
  void ipunique() async{
    SharedPreferences s=await SharedPreferences.getInstance();
    photo=s.getString('photo').toString();
    name=s.getString('name').toString();
    type=s.getString('type').toString();

  }



  @override
  Widget build(BuildContext context) {


    return WillPopScope(

      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>UserHomePage (title: '',),));

        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),


          title: Text(widget.title),
        ),
        body: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/img2.jpg'))),

          child: ListView.builder(



            physics: BouncingScrollPhysics(),
            // padding: EdgeInsets.all(5.0),
            // shrinkWrap: true,
            // itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                    //     Card(
                    //       shadowColor: Colors.orangeAccent,
                    //       shape: RoundedRectangleBorder(
                    //         side: BorderSide(
                    //           color: Colors.grey, //<-- SEE HERE
                    //         ),
                    //         borderRadius: BorderRadius.circular(20.0),
                    //       ),
                    //       child: Container(
                    //         color: Colors.transparent,
                    //
                    //         height: 230,
                    //         child: Row(
                    //           children: [
                    //
                    //             Expanded(
                    //               child: Container(
                    //                 alignment: Alignment.topLeft,
                    //                 child: Column(
                    //                   children: [
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    // ],
                    //                 ),
                    //               ),
                    //               flex: 8,
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       elevation: 8,
                    //       margin: EdgeInsets.all(10),
                    //     ),
                      ],
                    )),
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child:
                Column(children: [


                  CircleAvatar(radius: 29,backgroundImage: NetworkImage(image)),
                  Text(
                    name,
                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),

                  ),




                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),

              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' Profile  '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(),)
                  );
                },
              ), ListTile(
                leading: Icon(Icons.password),
                title: const Text('  change password  '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(title: '',),)
                  );
                },
              ),











              ListTile(
                leading: Icon(Icons.report_problem),
                title: const Text('Complaint'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyComplaint(title: "",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage(title: "",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: const Text('Complaint View'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewComplaintPage(title: "",),));
                },
              ),

              ListTile(
                leading: Icon(Icons.work),
                title: const Text('View work '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage()));
                },
              ),

   ListTile(
                leading: Icon(Icons.brush_rounded),
                title: const Text(' ARTIST'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewArtistPage(title: "",),));
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: const Text(' Cart '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: const Text(' Purchase History '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseHistory()));
                },
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: const Text('  Chat '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyChatApp()));
                },
              ),
   //
   //
   //
   //            ListTile(
   //              leading: Icon(Icons.change_circle),
   //              title: const Text(' Change Password '),
   //              onTap: () {
   //                Navigator.pop(context);
   //                Navigator.push(context, MaterialPageRoute(builder: (context) => MyUserChangePassword(),));
   //              },
   //            ),
   //
   //            ListTile(
   //              leading: Icon(Icons.logout),
   //              title: const Text('LogOut'),
   //              onTap: () {
   //
   //                Navigator.push(context, MaterialPageRoute(builder: (context) => login_new_full(),));
   //              },
   //            ),










            ],
          ),
        ),





      ),
    );
  }
















  void senddata()async{



    SharedPreferences sh=await SharedPreferences.getInstance();
    String url=sh.getString('url').toString();
    String lid=sh.getString('lid').toString();
    final urls=Uri.parse(url+"/user_profile_new/");
    try{
      final response=await http.post(urls,body:{
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {


          setState(() {
            email=jsonDecode(response.body)['email'];
            name=jsonDecode(response.body)['name'];
            phone=jsonDecode(response.body)['phone'];


            image=sh.getString('imgurl').toString()+jsonDecode(response.body)['image'];



          });

        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }

  }



}


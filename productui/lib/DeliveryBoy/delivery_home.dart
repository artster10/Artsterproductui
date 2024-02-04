

import 'package:flutter/material.dart';
import 'package:productui/DeliveryBoy/view_assigned_work.dart';
import 'package:productui/DeliveryBoy/view_delivery_prof_new.dart';
import 'package:productui/screens/user_profile/viewprofile.dart';
import 'package:productui/screens/view_work/view_work.dart';
import 'package:productui/view_complaintmain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

import '../delivery/deliveryboyprofile.dart';






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
      title: 'Artster',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const deliveryboyHomePage(title: 'Artster'),
    );
  }
}

class deliveryboyHomePage extends StatefulWidget {
  const deliveryboyHomePage({super.key, required this.title});


  final String title;

  @override
  State<deliveryboyHomePage> createState() => _deliveryboyHomePageState();
}

class _deliveryboyHomePageState extends State<deliveryboyHomePage> {
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
        Navigator.push(context, MaterialPageRoute(builder: (context) =>deliveryboyHomePage (title: '',),));

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => deliveryViewProfilefull(title: '',),)
                  );
                },
              ), 

              ListTile(
                leading: Icon(Icons.work),
                title: const Text('View work '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSession(title: '')));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' Assigned Work  '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AssignedWork(),)
                  );
                },
              ),
              //





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


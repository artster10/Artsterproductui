import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'loading.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const MyComplaint(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyComplaint extends StatefulWidget {
  const MyComplaint({super.key, required this.title});

  final String title;

  @override
  State<MyComplaint> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<MyComplaint> {




  MyComplaint() {
    view_notification();
  }


  List<String> id_ = <String>[];
  List<String> pname_= <String>[];
  List<String> price_= <String>[];
  List<String> video_= <String>[];
  List<String> images_= <String>[];
  List<String> pinfo_= <String>[];




  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> pname = <String>[];
    List<String> pinfo = <String>[];
    List<String> price = <String>[];
    List<String> images = <String>[];
    List<String> video = <String>[];





    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/and_view_product/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        images.add(sh.getString('img_url').toString()+arr[i]['images']);
        pname.add(arr[i]['pname']);
        pinfo.add(arr[i]['pinfo']);
        video.add(sh.getString("img_url").toString()+arr[i]['video']);
        price.add(arr[i]['price']);


      }

      setState(() {
        id_ = id;
        images_ = images;
        video_ = video;
        pname_ = pname;
        pinfo_ = pinfo;
        price_ = price;



      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  TextEditingController complaintCOntroller=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterCarousel(
              options: CarouselOptions(
                height: 400.0,
                showIndicator: true,
                slideIndicator: CircularSlideIndicator(),
              ),
              items: [1,2].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(

                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.amber
                        ),
                        child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                    );
                  },
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }


}





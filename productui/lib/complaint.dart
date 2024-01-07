import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: complaintCOntroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Complaint"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {

                _send_data();
              }, child: Text('Send')),
            ),
          ],
        ),
      ),
    );
  }
  void _send_data() async{


    String complaints=complaintCOntroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/and_complaintdetails_post/');
    try {
      final response = await http.post(urls, body: {
        'comp':complaints,
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sent');

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Loading(),));
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

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
      home: const ChangePassword(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.title});

  final String title;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController current_password=TextEditingController();
  TextEditingController new_password=TextEditingController();
  TextEditingController confirm_password=TextEditingController();



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
                controller: current_password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Current Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: new_password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "New Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirm_password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm Password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {

                _send_data();
              }, child: Text('Change')),
            ),
          ],
        ),
      ),
    );
  }
  void _send_data() async{


    String currentpassword=current_password.text;
    String newpassword=new_password.text;
    String confirmpassword=confirm_password.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/and_changepassword_post/');
    try {
      final response = await http.post(urls, body: {
        'textfield':currentpassword,
        'textfield2':newpassword,
        'textfield3':confirmpassword,
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Changing Successfull');

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

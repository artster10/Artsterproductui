import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Work request'),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  TextEditingController _textController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          TextField(
            controller: _textController,
            maxLines: 5, // Adjust as needed for the desired number of lines
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter text here',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle button press here
              // Access the entered text using _textController.text
              print('Text entered: ${_textController.text}');
            },
            child: Text('Request'),
          )
          ],
        );
  }

  void _send_data() async{


    String uname=_textController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String aid = sh.getString('aid').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/myapp/and_login_post/');
    try {
      final response = await http.post(urls, body: {
        'textfield':uname,
        'aid':aid,
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {

          String lid=jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),));
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
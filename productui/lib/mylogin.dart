import 'package:flutter/material.dart';
import 'package:productui/screens/view_product/bg.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:productui/loading.dart';
import 'package:productui/screens/home/home_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'DeliveryBoy/delivery_home.dart';
import 'signup.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset('assets/images/brush2.png',
                      height: 250, width: 250),
                  const Text(
                    'Welcome back, you\'ve being missed!',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: unameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Username")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: passController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        _send_data();
                      },
                      child: Container(
                        padding: EdgeInsets.all(18),
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Not a user? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyMySignup(),
                              ));
                        },
                        child: Text(
                          "Signup now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    String uname = unameController.text;
    String password = passController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/and_login_post/');
    try {
      final response = await http.post(urls, body: {
        'textfield': uname,
        'textfield2': password,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String id = jsonDecode(response.body)['lid'].toString();
          String type = jsonDecode(response.body)['type'];
          sh.setString("lid", id);
          if (type == 'user') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Loading(),
                ));
          } else if (type == 'deliveryboy') {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => deliveryboyHomePage(
                    title: 'Delivery Home',
                  ),
                ));
          }
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

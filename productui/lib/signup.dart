import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';

import 'package:permission_handler/permission_handler.dart';
import 'login.dart';
import 'user_home.dart';

void main() {
  runApp(const MyMySignup());
}

class MyMySignup extends StatelessWidget {
  const MyMySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MysignupPage(title: 'MySignup'),
    );
  }
}

class MysignupPage extends StatefulWidget {
  const MysignupPage({super.key, required this.title});

  final String title;

  @override
  State<MysignupPage> createState() => _MysignupPageState();
}

class _MysignupPageState extends State<MysignupPage> {
  String gender = "Male";
  File? uploadimage;
  TextEditingController fnameController = new TextEditingController();
  TextEditingController snameController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController mobnoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmpasswordController = new TextEditingController();

  // Future<void> chooseImage() async {
  //   // final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     // uploadimage = File(choosedimage!.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_selectedImage != null) ...{
                InkWell(
                  child: Image.file(
                    _selectedImage!,
                    height: 400,
                  ),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                        height: 200,
                        width: 200,
                      ),
                      Text('Select Image', style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: fnameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("First Name")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: snameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Second Name")),
                ),
              ),
              RadioListTile(
                value: "Male",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Male";
                  });
                },
                title: Text("Male"),
              ),
              RadioListTile(
                value: "Female",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Female";
                  });
                },
                title: Text("Female"),
              ),
              RadioListTile(
                value: "Other",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = "Other";
                  });
                },
                title: Text("Other"),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("DOB")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: mobnoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Phone")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("E-mail")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Password")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Confirm Password")),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _send_data();
                },
                child: Text("Signup"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _send_data() async {
    String fname = fnameController.text;
    String sname = snameController.text;
    String Dob = dateController.text;
    String mobno = mobnoController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmpassword = confirmpasswordController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/and_signup_post/');
    try {
      final response = await http.post(urls, body: {
        "fileField": photo,
        "textfield": fname,
        "textfield2": sname,
        "textfield3": Dob,
        "textfield4": mobno,
        "textfield5": email,
        "textfield6": password,
        "textfield8": confirmpassword,
        "gen": gender,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Registration Successfull');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomePage(
                  title: "",
                ),
              ));
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

  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String photo = '';
}

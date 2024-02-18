import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/config/colors.dart';
import 'package:productui/screens/message/widgets/message_background.dart';
import 'package:productui/screens/message/widgets/message_item.dart';
import 'package:productui/screens/nav/nav.dart';
import 'package:productui/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat.dart';

class ChatArtist extends StatefulWidget {
  const ChatArtist({super.key});

  @override
  State<ChatArtist> createState() => _SearchArtistState();
}

class _SearchArtistState extends State<ChatArtist> {
  TextEditingController search = TextEditingController();
  late Future canChangeData = _search_data();

  _SearchArtistState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> aid_ = <String>[];

  List<String> firstname_ = <String>[];
  List<String> secondname_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> email_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> category_ = <String>[];
  List<String> gender_ = <String>[];
  List<String> dateofbirth_ = <String>[];
  // List<String> place_= <String>[];
  // List<String> post_= <String>[];
  // List<String> pin_= <String>[];
  // List<String> state_= <String>[];
  // List<String> district_= <String>[];

  // List<String> qualification_= <String>[];
  // List<String> loginid_= <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> aid = <String>[];

    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> category = <String>[];
    List<String> gender = <String>[];
    List<String> dateofbirth = <String>[];

    // List<String> gender= <String>[];
    //
    // List<String> place= <String>[];
    // List<String> post= <String>[];
    // List<String> pin= <String>[];
    // List<String> state= <String>[];
    // List<String> district= <String>[];
    List<String> photo = <String>[];
    // List<String> qualification= <String>[];
    // List<String> loginid= <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String did = sh.getString('did').toString();
      // String laid = sh.getString('laid').toString();
      String url = '$urls/and_viewartist/';

      var data = await http.post(Uri.parse(url), body: {
        "did": did,
        // "laid":laid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        aid.add(arr[i]['aid'].toString());

        // loginid.add(arr[i]['logid'].toString());

        firstname.add(arr[i]['fname']);
        secondname.add(arr[i]['lname']);
        email.add(arr[i]['email']);

        phone.add(arr[i]['phone']);
        category.add(arr[i]['category']);
        gender.add(arr[i]['gender']);
        dateofbirth.add(arr[i]['dateofbirth']);
        photo.add(sh.getString("img_url").toString() + arr[i]['img']);
      }

      setState(() {
        id_ = id;
        aid_ = aid;

        firstname_ = firstname;
        secondname_ = secondname;
        phone_ = phone;
        email_ = email;
        photo_ = photo;
        category_ = category;
        gender_ = gender;
        dateofbirth_ = dateofbirth;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  Future<void> _search_data() async {
    List<String> id = <String>[];
    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> email = <String>[];
    List<String> phone = <String>[];
    List<String> category = <String>[];
    List<String> gender = <String>[];
    List<String> dateofbirth = <String>[];

    List<String> photo = <String>[];
    // List<String> proof = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      // String did = sh.getString('did').toString();
      // String laid = sh.getString('laid').toString();
      String names = search.text;
      String url = '$urls/search/';

      var data = await http.post(Uri.parse(url), body: {
        // "did": did,
        // "laid": laid,
        "name": names,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());

        firstname.add(arr[i]['fname']);
        secondname.add(arr[i]['lname']);
        email.add(arr[i]['email']);

        phone.add(arr[i]['phone']);
        category.add(arr[i]['category']);
        gender.add(arr[i]['gender']);
        dateofbirth.add(arr[i]['dateofbirth']);

        photo.add(sh.getString("img_url").toString() + arr[i]['img']);
      }

      setState(() {
        id_ = id;
        firstname_ = firstname;
        secondname_ = secondname;
        phone_ = phone;
        email_ = email;
        photo_ = photo;
        category_ = category;
        gender_ = gender;
        dateofbirth_ = dateofbirth;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
//

  //
  @override
  Widget build(BuildContext context) {
    return MessageBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Nav(),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/button_back.svg'),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 16.0),
          //     child: IconButton(
          //         onPressed: () {},
          //         icon: SvgPicture.asset('assets/icons/menu.svg')),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Messages',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 25.0,
                            color: kBlack.withOpacity(0.10))
                      ]),
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: kWhite,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              BorderSide(width: 0.0, style: BorderStyle.none),
                        ),
                        prefixIcon: Image.asset('assets/images/search.png'),
                        hintText: 'search',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: k1LightGray)),
                    onChanged: (value) {
                      setState(() {
                        canChangeData = _search_data();
                      });
                      // Perform search functionality here
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: id_.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          SharedPreferences sh =
                              await SharedPreferences.getInstance();
                          sh.setString("aid", aid_[index]);
                          sh.setString("agrname", firstname_[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyChatPage(
                                  title: '',
                                ),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.60),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1.0, color: kBlack),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(photo_[index]),
                                  radius: 35,
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      firstname_[index] +
                                          " " +
                                          secondname_[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: kBlack),
                                    ),
                                    Text(
                                      category_[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                // ListView(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   children: [
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //     // MessageItem(
                //     //     name: 'Malena tudi', message: 'Hey how\'s going'),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

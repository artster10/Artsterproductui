import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productui/chat_artist.dart';
import 'package:productui/product_info/product_info.dart';
import 'package:productui/screens/home/home_screen.dart';
import 'package:productui/screens/message/message_screen.dart';
import 'package:productui/screens/profile/profile_screen.dart';
import 'package:productui/screens/view_product/bg.dart';
import 'package:productui/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config/colors.dart';
import '../../user view artist.dart';
import '../artist_profile/viewa.dart';
import '../nav/nav.dart';
import '../orders/order_screen.dart';
import '../product_details/product_details.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  _ProductPageState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> pname_ = <String>[];
  List<String> price_ = <String>[];
  List<String> video_ = <String>[];
  List<String> images_ = <String>[];
  List<String> pinfo_ = <String>[];

  List<String> firstname_ = <String>[];
  List<String> secondname_ = <String>[];
  List<String> img_ = <String>[];

  List<String> aid_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> pname = <String>[];
    List<String> pinfo = <String>[];
    List<String> price = <String>[];
    List<String> images = <String>[];
    List<String> video = <String>[];
    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> img = <String>[];
    List<String> aid = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/and_view_product/';

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        images.add(sh.getString('img_url').toString() + arr[i]['images']);
        pname.add(arr[i]['pname']);
        pinfo.add(arr[i]['pinfo']);
        video.add(sh.getString("img_url").toString() + arr[i]['video']);
        price.add(arr[i]['price']);
        firstname.add(arr[i]['firstname']);
        secondname.add(arr[i]['secondname']);
        img.add(sh.getString('img_url').toString() + arr[i]['img']);
        aid.add(arr[i]['aid'].toString());
      }

      setState(() {
        id_ = id;
        images_ = images;
        video_ = video;
        pname_ = pname;
        pinfo_ = pinfo;
        price_ = price;
        firstname_ = firstname;
        secondname_ = secondname;
        img_ = img;
        aid_ = aid;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Artster',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatArtist()));
                },
                icon: SvgPicture.asset('assets/icons/message.svg'),
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   centerTitle: false,
        //   title: Padding(
        //     padding: const EdgeInsets.only(left: 8.0),
        //     child: Text(
        //       'Artster',
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyLarge!
        //           .copyWith(fontWeight: FontWeight.w700),
        //     ),
        //   ),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: IconButton(
        //         onPressed: () {},
        //         icon: SvgPicture.asset('assets/icons/search.svg'),
        //       ),
        //     ),
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 42,
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 56.0,
              //         width: 56.0,
              //         alignment: Alignment.center,
              //         margin: const EdgeInsets.only(left: 24.0),
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           gradient: k3GradientAccent,
              //           boxShadow: [
              //             BoxShadow(
              //               blurRadius: 12.0,
              //               offset: const Offset(0, 4),
              //               color: k3Pink.withOpacity(0.52),
              //             ),
              //           ],
              //         ),
              //         child: SvgPicture.asset('assets/icons/only_plus.svg'),
              //       ),
              //       ...List.generate(
              //         5,
              //         (index) => Container(
              //           height: 56.0,
              //           width: 56.0,
              //           margin: EdgeInsets.only(
              //             left: 30.0,
              //             right: index == 4 ? 30.0 : 0.0,
              //           ),
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(width: 2.0, color: k2AccentStroke),
              //             image: const DecorationImage(
              //               image:
              //                   AssetImage('assets/images/profile_image.jpg'),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: id_.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences sh =
                          await SharedPreferences.getInstance();
                      sh.setString("pid", id_[index]);
                      // sh.setString("name", pname_[index]);
                      // sh.setString("description", pinfo_[index]);
                      // sh.setString("price", price_[index]);
                      // sh.setString("video", video_[index]);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductInfo(),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 32.0,
                      ),
                      padding: const EdgeInsets.all(14.0),
                      height: size.height * 0.40,
                      width: size.width,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: NetworkImage(images_[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        SharedPreferences sh =
                                            await SharedPreferences
                                                .getInstance();
                                        sh.setString("aid", aid_[index]);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen()),
                                        );
                                      },
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(img_[index]),
                                        maxRadius: 20.0,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          firstname_[index] +
                                              ' ' +
                                              secondname_[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: kBlack),
                                        ),
                                        Text(
                                          '2 hrs ago',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xFFD8D8D8)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.more_vert, color: kWhite),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     _buildPostStat(
                          //       context: context,
                          //       iconPath: 'assets/icons/favorite_border.svg',
                          //       value: '5.2K',
                          //     ),
                          //     _buildPostStat(
                          //       context: context,
                          //       iconPath: 'assets/icons/favorite_border.svg',
                          //       value: '1.1K',
                          //     ),
                          //     _buildPostStat(
                          //       context: context,
                          //       iconPath: 'assets/icons/favorite_border.svg',
                          //       value: '5.2K',
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

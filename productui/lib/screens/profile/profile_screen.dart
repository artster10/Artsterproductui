import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/config/colors.dart';
import 'package:productui/screens/profile/widgets/stat.dart';
import 'package:productui/screens/profile/widgets/profile_background.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:productui/user_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math' as math;

import '../../product_info/product_info.dart';
import '../../user view artist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedTab = 'photos';


  _changeTab(String tab) {
    setState(() => _selectedTab = tab);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _send_data();
    view_notification();

    return ProfileBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(
              'Product Details',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomePage(title: '',),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/button_back.svg'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi / 4,
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: kBlack),
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: ProfileImageClipper(),
                    child: Image.network(
                      img_,
                      width: 180.0,
                      height: 180.0,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              Text(
                fname_,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4.0),
              Text(
                lname_,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 80.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stat(title: 'Posts', value: 35),
                    Stat(title: 'Followers', value: 1552),
                    Stat(title: 'Follows', value: 128),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _changeTab('photos'),
                    child: SvgPicture.asset(
                      'assets/icons/Button-photos.svg',
                      color: _selectedTab == 'photos' ? k2AccentStroke : null,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _changeTab('saved'),
                    child: SvgPicture.asset(
                      'assets/icons/Button-saved.svg',
                      color: _selectedTab == 'saved' ? k2AccentStroke : null,
                    ),
                  ),
                ],
              ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: id_.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              itemBuilder: (BuildContext context,int index) {
                return  GestureDetector(
                  onTap: () async {
                    SharedPreferences sh =
                    await SharedPreferences.getInstance();
                    sh.setString("pid", id_[index]);
                    sh.setString("aid",sh.getString("aid").toString());
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
          )

              // we'll use flutter_staggered_grid_view package here:
              // Padding(
              //   padding: const EdgeInsets.all(13.0),
              //   child: StaggeredGrid.count(
              //     crossAxisCount: 2,
              //     mainAxisSpacing: 14.0,
              //     crossAxisSpacing: 14.0,
              //     children: [
              //       StaggeredGridTile.count(
              //         crossAxisCellCount: 1,
              //         mainAxisCellCount: 1.5,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(19.0),
              //           child: Image.network(
              //             image_[index],
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //       StaggeredGridTile.count(
              //         crossAxisCellCount: 1,
              //         mainAxisCellCount: 1,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(19.0),
              //           child: Image.asset(
              //             'assets/images/Rectangle-7.png',
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //       StaggeredGridTile.count(
              //         crossAxisCellCount: 1,
              //         mainAxisCellCount: 1.5,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(19.0),
              //           child: Image.asset(
              //             'assets/images/Rectangle-8.png',
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //       StaggeredGridTile.count(
              //         crossAxisCellCount: 1,
              //         mainAxisCellCount: 1,
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(19.0),
              //           child: Image.asset(
              //             'assets/images/Rectangle-1.png',
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  String fname_ = "";
  String lname_ = "";
  String category_ = "";
  String gender_ = "";
  String email_ = "";
  String phone_ = "";
// String password_ = "";
// String confirmpassword_ = "";
  String img_ = "";

  void _send_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String aid = sh.getString('aid').toString();
    String img_url = sh.getString('img_url').toString();

    final urls = Uri.parse('$url/view_profile_artist/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'aid':aid

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String fname = jsonDecode(response.body)['fname'].toString();
          String sname = jsonDecode(response.body)['sname'].toString();
          String gender = jsonDecode(response.body)['gender'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['mobno'].toString();
          String img = img_url + jsonDecode(response.body)['img'].toString();

          setState(() {
            fname_ = fname;
            lname_ = sname;
            gender_ = gender;
            email_ = email;
            phone_ = phone;
            img_ = img;
          });
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

  List<String> id_ = <String>[];
  List<String> pname_ = <String>[];
  List<String> price_ = <String>[];
  List<String> video_ = <String>[];
  List<String> images_ = <String>[];
  List<String> pinfo_ = <String>[];

  List<String> firstname_ = <String>[];
  List<String> secondname_ = <String>[];



  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> pname = <String>[];
    List<String> pinfo = <String>[];
    List<String> price = <String>[];
    List<String> video = <String>[];
    List<String> firstname = <String>[];
    List<String> secondname = <String>[];
    List<String> images = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String aid = sh.getString('aid').toString();
      String url = '$urls/and_view_product_artist/';

      var data = await http.post(Uri.parse(url), body: {

        'aid':aid,

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        pname.add(arr[i]['pname']);
        pinfo.add(arr[i]['pinfo']);
        price.add(arr[i]['price']);
        images.add(sh.getString('img_url').toString() + arr[i]['images']);

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

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

}

class ProfileImageClipper extends CustomClipper<Path> {
  double radius = 35;

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(size.width / 2 - radius, radius)
      ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + radius, radius)
      ..lineTo(size.width - radius, size.height / 2 - radius)
      ..quadraticBezierTo(size.width, size.height / 2, size.width - radius,
          size.height / 2 + radius)
      ..lineTo(size.width / 2 + radius, size.height - radius)
      ..quadraticBezierTo(size.width / 2, size.height, size.width / 2 - radius,
          size.height - radius)
      ..lineTo(radius, size.height / 2 + radius)
      ..quadraticBezierTo(0, size.height / 2, radius, size.height / 2 - radius)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;


}




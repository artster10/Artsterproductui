import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:productui/purchase_sub.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:productui/screens/orders/widgets/order_item.dart';
import 'package:productui/screens/orders/widgets/order_screen_background.dart';
import 'package:productui/screens/view_product/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config/colors.dart';
import 'delivery_home.dart';
import 'more_details.dart';
// import 'package:productui/screens/nav/nav.dart';

class AssignedWork extends StatefulWidget {
  const AssignedWork({super.key});

  @override
  State<AssignedWork> createState() => _AssignedWorkState();
}

class _AssignedWorkState extends State<AssignedWork> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_complaints();


  }

  List<String> id_=[];
  List<String> fname_=[];
  List<String> sname_=[];
  List<String> date_=[];
  List<String> mobno_=[];
  List<String> amount_=[];
  List<String> afname_=[];
  List<String> asname_=[];
  List<String> amobno_=[];
  List<String> email_=[];





  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OrderBackground(
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
                builder: (context) => deliveryboyHomePage(title: '',),
              ),
            ),
            icon: SvgPicture.asset('assets/icons/button_back.svg'),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child:  ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              // padding: EdgeInsets.all(5.0),
              shrinkWrap: true,
              itemCount: id_.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onLongPress: () {
                    print("long press" + index.toString());
                  },
                  title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 140,

                            margin: EdgeInsets.only(bottom: 16.0),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: kWhite.withOpacity(0.70),
                            ),
                            child:

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                  date_[index],
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: kBlack, fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [




                                    Text(
                                      fname_[index],
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: kBlack, fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),




                                    TextButton(onPressed: (){
                                      _send_data();
                                    }, child: Text("Delivered"))


                                  ],
                                ),





                                Row(

                                  children: [
                                    Text(
                                      afname_[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .copyWith(color: kBlack),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              amount_[index],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(color: kBlack),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),


                                    ],
                                  ))])));
              },
            ),





          ),

        ),
      ),
    );


  }

  void view_complaints() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> fname = <String>[];
    List<String> sname = <String>[];

    List<String> amount = <String>[];
    List<String> mobno = <String>[];

    List<String> afname =<String>[];
    List<String> asname =<String>[];
    List<String> email =<String>[];
    List<String> amobno =<String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/view_assigned_work/';
      String lid = sh.getString("lid").toString();
      String img_url = sh.getString("img_url").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        fname.add(arr[i]['fname'].toString());
        sname.add(arr[i]['sname'].toString());
        amount.add(arr[i]['amount'].toString());
        mobno.add(arr[i]['mobno'].toString());
        afname.add(arr[i]['afname'].toString());
        asname.add(arr[i]['asname'].toString());
        amobno.add(arr[i]['amobno'].toString());
        email.add(arr[i]['email'].toString());


      }

      setState(() {
        id_ = id;
        date_ = date;
        fname_ = fname;
        sname_ = sname;
        amount_ = amount;
        mobno_ = mobno;
        afname_=afname;
        asname_=asname;
        amobno_=amobno;
        email_=email;


      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }
  void _send_data() async{


    // String complaints=complaintCOntroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/update_status/');
    try {
      final response = await http.post(urls, body: {
        // 'comp':complaints,
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sent');

          Navigator.push(context, MaterialPageRoute(
            builder: (context) => MoreDetails(),));
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

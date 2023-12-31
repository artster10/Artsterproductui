import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const ViewComplaints());
}

class ViewComplaints extends StatelessWidget {
  const ViewComplaints({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Complaints',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ViewComplaintsPage(title: 'Complaints'),
    );
  }
}

class ViewComplaintsPage extends StatefulWidget {
  const ViewComplaintsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ViewComplaintsPage> createState() => _ViewComplaintsPageState();
}

class _ViewComplaintsPageState extends State<ViewComplaintsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewComplaints();
  }

  Icon actionIcon = const Icon(
    Icons.add,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (displayWidget == true) {
          setState(() {
            displayWidget = false;
            actionIcon = const Icon(
              Icons.add,
              color: Colors.white,
            );
          });
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black45,
          actions: const [
            // IconButton(icon: Icon(Icons.add),onPressed: () => ,)
          ],
          title: Text(widget.title),
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              image: AssetImage(
                'assets/bg1.jpg',
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Card(
                elevation: 40,
                shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width - 15,
                      padding: const EdgeInsets.only(
                          left: 2.0, right: 15.0, top: 12.0, bottom: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Date[index]".toString(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Status[index]".toString(),
                                  style: "Status[index]" == 'Pending'
                                      ? const TextStyle(color: Colors.orange)
                                      : const TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Complaint'),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width - 35,
                            child: ReadMoreText(
                              "complaint[index]",
                              trimLines: 2,
                              colorClickableText: Colors.blue,
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              lessStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Reply'),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width - 35,
                            child: ReadMoreText(
                              " Reply[index]",
                              trimLines: 2,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 15),
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: ' Show less',
                              moreStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              lessStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: actionIcon,
          onPressed: () => setState(() {
            if (displayWidget == true) {
              setState(() {
                displayWidget = false;
                actionIcon = const Icon(Icons.add);
              });
            } else if (displayWidget == false) {
              displayWidget = true;
              actionIcon = const Icon(Icons.arrow_downward);
            }
          }),
        ),
        bottomSheet: displayWidget ? complaintModalSheet() : null,
      ),
    );
  }

  bool displayWidget = false;
  int count = 2;

  List id = [], Date = [], Status = [], Reply = [], complaint = [];

  void viewComplaints() async {
    if (_isDisposed) {
      return;
    }
    List id_ = [], Date_ = [], Status_ = [], Reply_ = [], complaint_ = [];
    SharedPreferences sh = await SharedPreferences.getInstance();
    String mUrl = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final url = Uri.parse('$mUrl/user_view_complaints/');
    try {
      final response = await http.post(url, body: {'lid': lid});
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)["status"];
        if (status != "ok") {
          Fluttertoast.showToast(msg: 'Not Found');
        } else {
          List data = jsonDecode(response.body)["data"];
          count = data.length;

          for (int index = 0; index < data.length; index++) {
            id_.add(data[index]["id"].toString());
            Date_.add(data[index]["Date"].toString());
            Status_.add(data[index]["Status"].toString());
            Reply_.add(data[index]["Reply"].toString());
            complaint_.add(data[index]["complaints"].toString());
          }
          setState(() {
            id = id_;
            Date = Date_;
            Status = Status_;
            Reply = Reply_;
            complaint = complaint_;
          });
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error. Please try again');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  TextEditingController complaintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget complaintModalSheet() {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            TextFormField(
              maxLength: 300,
              validator: (value) {
                if (value!.length < 15) {
                  return 'Cannot be less than 15 characters';
                }
                return null;
              },
              controller: complaintController,
              decoration: const InputDecoration(
                hintText: 'Write your complaint...',
                border: OutlineInputBorder(),
              ),
              maxLines: 7,
              // You can store the entered complaint using onChanged or TextEditingController.
            ),
            const SizedBox(height: 16.0),
            const Text('Share your concerns'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  sendData();
                }
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendData() async {
    if (_isDisposed) {
      return;
    }
    final SharedPreferences sh = await SharedPreferences.getInstance();
    String url = '${sh.getString('url')}/user_send_complaints/';
    String lid = sh.getString('lid').toString();
    try {
      final response = await http.post(Uri.parse(url), body: {
        'complaint': complaintController.text,
        'lid': lid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          setState(() {
            displayWidget = false;
          });
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewComplaintsPage(title: widget.title),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Error. Please try again');
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

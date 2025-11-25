import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:telephony/telephony.dart';
import 'package:telephony_sms/telephony_sms.dart';

import 'main_screen.dart';

class FirstScreen extends StatefulWidget {
  final String password;
  const FirstScreen({required this.password, super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController name = TextEditingController();
  late Box psBox;
  String deletePassword = "J19031437";
  @override
  void initState() {
    if (Hive.isBoxOpen('first') == false) Hive.openBox("first");
    requestPermission();
    super.initState();
  }

  requestPermission() async {
    await _telephonySMS.requestPermission();
  }

  bool passwordCheck(String pass, ady) {
    psBox = Hive.box("first");
    print(psBox.values);
    // String passFromDatabase = psBox.get("password");
    if (pass == widget.password) {
      psBox.put('password', pass);
      psBox.put("ady", ady);
      psBox.put("passDelete", deletePassword);
      psBox.put("firstTime", true);

      return true;
    } else {
      return false;
    }
  }

  void _password() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool _isHidden = true;

  // final Telephony telephony = Telephony.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: Color(0xff000023),
      body: Stack(
        children: [
          Container(),
          Container(
            padding: EdgeInsets.only(left: width * 8, top: height * 15),
            child: Text('Hoş Geldiňiz!\nBoss',
                style: TextStyle(color: Colors.white, fontSize: 40)),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          controller: name,
                          style: TextStyle(fontSize: 22),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person, size: 24),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Sürüjiniň ady",
                              hintStyle: TextStyle(fontSize: 22),
                              labelStyle: TextStyle(fontSize: 22),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        SizedBox(height: height * 4),
                        TextField(
                          controller: _textFieldController,
                          style: TextStyle(fontSize: 22),
                          obscureText: _isHidden,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_rounded, size: 24),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              suffix: InkWell(
                                onTap: _password,
                                child: Icon(_isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              hintText: "Parol giriziň",
                              hintStyle: TextStyle(fontSize: 22),
                              labelStyle: TextStyle(fontSize: 22),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        SizedBox(height: height * 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Programma giriň',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.indigo,
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (passwordCheck(
                                        _textFieldController.text.trim(),
                                        name.text.trim())) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MainScreen(
                                                  lastIndex: 0)));
                                      _sendSMSGirmek();
                                    } else {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Ýalňyşlyk'),
                                            content: Text(
                                                'Girizen parolyňyz ýalňyş'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.arrow_forward)),
                            )
                          ],
                        ),
                        SizedBox(height: height * 5),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  final _telephonySMS = TelephonySMS();
  // final Telephony telephony = Telephony.instance;

  _sendSMSGirmek() async {
    // await telephony.sendSms(
    //   to: '+99365362074',
    //   message: 'SMS hyzmaty birikdi',
    //   statusListener: (s) => print(s.name),
    // );
    await _telephonySMS.sendSMS(
        phone: "+99365362074", message: "SMS hyzmaty birikdi");
  }
}

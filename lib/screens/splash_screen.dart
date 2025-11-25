import 'dart:async';
import '../providers/baza_provider.dart';
import 'first_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime = false;
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      loadCash();
      if (isFirstTime) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FirstScreen(password: 'pasKey'),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageTransition(
            MainScreen(
              lastIndex: 0,
              // onkisi: gutarmadykWagt, sonkyIndex: index, ady: name
            ),
          ),
        );
      }
    });
    super.initState();
  }

  void loadCash() async {
    final bazaProvider = BazaProvider();
    await bazaProvider.loadFromHive();
  }
  // late Box box;
  // late Box psBox;
  // BazaModel? gutarmadykWagt;
  // int index = 0;
  // bool isFirstTime = true;
  // String pasKey = 'IICSA0173057';
  // String name = "";
  // @override
  // void initState() {
  //   super.initState();
  //   barla();
  //   Timer(const Duration(seconds: 2), () {
  //     setState(() {
  //       if (isFirstTime) {
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => FirstScreen(password: pasKey)));
  //       } else {
  //         Navigator.pushReplacement(
  //             context,
  //             PageTransition(MainScreen(
  //                 onkisi: gutarmadykWagt, sonkyIndex: index, ady: name)));
  //       }
  //     });
  //   });
  // }

  // barla() async {
  //   if (Hive.isBoxOpen('baza') == false) await Hive.openBox("baza");
  //   if (Hive.isBoxOpen('first') == false) await Hive.openBox("first");
  //   psBox = Hive.box("first");
  //   box = Hive.box("baza");
  //   // Hive.box("baza").clear();
  //   if (psBox.isNotEmpty) {
  //     //  print("psbox is empty");
  //     //   psBox.put('password', pasKey);
  //     // } else {
  //     // print(psBox.values);
  //     isFirstTime = false;
  //     name = psBox.get("ady");
  //   }
  //   if (box.isEmpty) {
  //     print("baza bosh");
  //     return;
  //   }

  //   var bazadan1 = box.values.toList();
  //   // List<BazaModel> bazadan=box.values.toList() as List<BazaModel>;
  //   int len = bazadan1.length;
  //   index = len;
  //   List<BazaModel> ba = [];
  //   List keys = [];
  //   List<BazaModel> arhivModels = [];
  //   for (var element in bazadan1) {
  //     BazaModel bzz = element as BazaModel;
  //     if (bzz.isFinished) {
  //       if (!bzz.isDeleted) {
  //         print("key=${element.key} baza=${bzz.toSetir()}");
  //         keys.add(element.key);
  //         ba.add(bzz);
  //       } else {
  //         arhivModels.add(bzz);
  //       }
  //     }
  //   }

  //   for (int i = 0; i < keys.length; i++) {
  //     print("index=$i key=${keys[i]} baza=${ba[i].toSetir()}");
  //   }

  //   BazaModel f = bazadan1[len - 1] as BazaModel;
  //   if (!f.isFinished) {
  //     gutarmadykWagt = f;
  //     Provider.of<BazaProvider>(context, listen: false)
  //         .setUnfinished(gutarmadykWagt!);
  //   } else {
  //     gutarmadykWagt = null;
  //   }
  //   print(f.toSetir());
  //   //print(bazadan1.length);

  //   print('${ba.length} == keys len=${keys.length}');

  //   // keys.forEach((element) {
  //   //   print(element);
  //   // });
  //   // for (int i = 0; i < len; i++) {
  //   //   print("i=$i");
  //   //   print(keys[i]);
  //   //   bazaModel = bazadan1[i] as BazaModel;
  //   //   if (bazaModel.isFinished && !bazaModel.isDeleted) {
  //   //     bazaModels.add(bazaModel);
  //   //   } else {
  //   //     arhivModels.add(bazaModel);
  //   //     keys.removeAt(i);
  //   //   }
  //   // }
  //   Provider.of<BazaProvider>(context, listen: false).setCurrentbaza(ba, keys);
  //   Provider.of<BazaProvider>(context, listen: false).setArhivbaza(arhivModels);
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      backgroundColor: Color(0xff000023),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset("assets/logo.png", height: height * 20),
          ),
          SizedBox(height: height * 3),
          Text(
            "ТРЕЗВЫЙ ВОДИТЕЛЬ",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          SizedBox(height: 10),
          Text(
            "ÝOL HYZMATY",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: height * 1),
          Text(
            "AVTOPEREGON",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: height * 25),
          Center(child: SpinKitChasingDots(size: 50, color: Colors.white)),
        ],
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
    : super(
        pageBuilder: (context, animation, anotherAnimation) => page,
        transitionDuration: const Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
            curve: Curves.fastLinearToSlowEaseIn,
            parent: animation,
          );
          return Align(
            alignment: Alignment.topCenter,
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0,
              child: page,
            ),
          );
        },
      );
}

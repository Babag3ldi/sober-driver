import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Box box;
  late Box psBox;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    return Consumer<BazaProvider>(builder: (context, prov, _) {
      return Scaffold(
        backgroundColor: '#000023'.toColor(),
        appBar: AppBar(
            backgroundColor: '#000023'.toColor(),
            title: Text("История", style: TextStyle(fontSize: 26, color: Colors.white)),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white)),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
              itemCount: prov.arhiwdakiBaza.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext ctx, inx) {
                int index = prov.arhiwdakiBaza.length - 1 - inx;
                return Card(
                    color: '#000043'.toColor(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.indigo,
                            radius: 40,
                            child: Text("${prov.arhiwdakiBaza[index].baha}",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                          ),
                        ),
                        SizedBox(
                          width: sizeWidth * 42,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                  " ${index + 1})${prov.arhiwdakiBaza[index].aCity}-${prov.arhiwdakiBaza[index].bCity}",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                  maxLines: 3,
                                  textAlign: TextAlign.center),
                              SizedBox(height: 5),
                              Text(
                                "${prov.arhiwdakiBaza[index].bashlanWagty}-${prov.arhiwdakiBaza[index].gutaranWagty}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              Text(
                                prov.arhiwdakiBaza[index].dowamlylygy(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              Text(prov.arhiwdakiBaza[index].sene,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              const SizedBox(height: 5),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (prov.arhiwdakiBaza[index].isSpes)
                                      Text(
                                        "C",
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.green),
                                      ),
                                    if (prov.arhiwdakiBaza[index].isPogoda)
                                      Text("  P",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green))
                                  ]),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              radius: 40,
                              child: Text(
                                  "+${prov.arhiwdakiBaza[index].prosent().toStringAsFixed(1)}",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white))),
                        ),
                      ],
                    ));
              }),
        ),
      );
    });
  }
}

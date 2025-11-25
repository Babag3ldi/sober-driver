import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:telephony_sms/telephony_sms.dart';

import '../providers/baza_provider.dart';

class CashRegister extends StatefulWidget {
  const CashRegister({super.key});

  @override
  State<CashRegister> createState() => _CashRegisterState();
}

class _CashRegisterState extends State<CashRegister> {
  final TextEditingController _passController = TextEditingController();
  final TelephonySMS _telephonySMS = TelephonySMS();

  late Box _settingsBox; // "first" box — parol üçin
  bool _isHidden = true; // password hide/show
  String _typedPassword = "";

  @override
  void initState() {
    super.initState();
    print("herrreee");
    _initBoxesAndData();
  }

  Future<void> _initBoxesAndData() async {
    // Parol saklanýan box
    if (!Hive.isBoxOpen('first')) {
      _settingsBox = await Hive.openBox('first');
    } else {
      _settingsBox = Hive.box('first');
    }

    // Kassa üçin maglumatlary Provider arkaly ýükle
    // Bu metoda öz BazaProvider içinde implement etmeli: loadCash() ýa-da summaHasapla()
    final bazaProv = context.read<BazaProvider>();
    if (bazaProv.currentBaza.isEmpty) {
      // Eger sende öň "summaHasapla()" bar bolsa, ony ulanyp bilersiň
      // ignore: invalid_use_of_protected_member
      await bazaProv.summaHasapla(); 
          // Ýa-da täze "loadCash()" diýip döredip, şu ýere goýarsyň:
      // await bazaProv.loadCash();
    }
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  void _togglePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  // 🔐 Bazadaky paroly al
  String? _getStoredPassword() {
    if (!_settingsBox.containsKey('passDelete')) return null;
    return _settingsBox.get('passDelete') as String?;
  }

  // 📩 SMS ugrat — hemmesini öçürildi
  Future<void> _sendSMSDeleteAll() async {
    await _telephonySMS.sendSMS(
      phone: "+99365362074",
      message: "Ähli maglumat öçürildi",
    );
  }

  // 📩 SMS ugrat — 1 ýazgy öçürildi
  Future<void> _sendSMSDeleteOne() async {
    await _telephonySMS.sendSMS(
      phone: "+99365362074",
      message: "Bir maglumat öçürildi",
    );
  }

  // 🔐 Parol dialog — ähli ýazgylary öçürmek üçin
  Future<void> _confirmDeleteAll() async {
    _passController.clear();
    _typedPassword = "";

    final sizeWidth = MediaQuery.of(context).size.width / 100;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Color(0xFF000043),
          title: const Text(
            "Öçürmegi tassyklaň",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          content: TextField(
            controller: _passController,
            obscureText: _isHidden,
            onChanged: (v) => _typedPassword = v,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: "Parol giriziň",
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 18),
              suffixIcon: IconButton(
                icon: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: _togglePassword,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF750000),
                minimumSize: Size(sizeWidth * 30, 40),
              ),
              onPressed: () async {
                final stored = _getStoredPassword();
                if (stored == null || stored != _typedPassword) {
                  // Parol ýalňyş
                  Navigator.of(ctx).pop(false);
                  _showError("Girizen parolyňyz ýalňyş");
                  return;
                }

                // Dogry parol — ähli maglumatlary öçür
                await context.read<BazaProvider>().clearTheCash();
                await _sendSMSDeleteAll();
                Navigator.of(ctx).pop(true);
              },
              child: const Text("Удалит", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: Size(sizeWidth * 30, 40),
              ),
              onPressed: () => Navigator.of(ctx).pop(false),
              child:
                  const Text("Отменитъ", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (result != true) {
      // hiç zat etmeli däl, ulanyjy çykdy
    }
  }

  // 🔐 Parol dialog — 1 ýazgyny öçürmek üçin
  Future<bool?> _confirmDeleteOne(int index) async {
    _passController.clear();
    _typedPassword = "";

    final sizeWidth = MediaQuery.of(context).size.width / 100;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Color(0xFF000043),
          title: const Text(
            "Öçürmegi tassyklaň",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          content: TextField(
            controller: _passController,
            obscureText: _isHidden,
            onChanged: (v) => _typedPassword = v,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              hintText: "Parol giriziň",
              hintStyle: const TextStyle(color: Colors.white70, fontSize: 18),
              suffixIcon: IconButton(
                icon: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                ),
                onPressed: _togglePassword,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF750000),
                minimumSize: Size(sizeWidth * 30, 40),
              ),
              onPressed: () async {
                final stored = _getStoredPassword();
                if (stored == null || stored != _typedPassword) {
                  Navigator.of(ctx).pop(false);
                  _showError("Girizen parolyňyz ýalňyş");
                  return;
                }

                await context.read<BazaProvider>().deleteOneItem(index);
                await _sendSMSDeleteOne();
                Navigator.of(ctx).pop(true);
              },
              child: const Text("Удалит", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: Size(sizeWidth * 30, 40),
              ),
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text(
                "Отменитъ",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    return result;
  }

  void _showError(String msg) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Ýalňyşlyk'),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width / 100;
    final sizeHeight = MediaQuery.of(context).size.height / 100;

    return Consumer<BazaProvider>(builder: (context, prov, child) {
      print("hereeeeeee ${prov.currentBaza.length}");
        return Scaffold(
          backgroundColor: Color(0xFF000023),
          appBar: AppBar(
            backgroundColor: Color(0xFF000023),
            title: const Text(
              'Касса',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: _confirmDeleteAll,
                child: SizedBox(
                  height: sizeHeight * 8,
                  width: sizeWidth * 94,
                  child: Card(
                    color: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: Colors.white70, width: 1),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        "${prov.totalPrice.toStringAsFixed(2)} TMT",
                        style: const TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 10),
        
              // List of rides
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: prov.currentBaza.length,
                  itemBuilder: (context, inx) {
                    final index = prov.currentBaza.length - 1 - inx;
                    final model = prov.currentBaza[index];

        
        
                    return Dismissible(
                      key: ValueKey(model.id),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (_) => _confirmDeleteOne(index),
                      background: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: const SizedBox(
                            width: 75,
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                      child: Card(
                        color: Color(0xFF000043),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Left circle — baha
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 34,
                                child: Text(
                                  "${model.baha}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
        
                            // Middle info
                            SizedBox(
                              width: sizeWidth * 48,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "${index + 1}) ${model.aCity}-${model.bCity}",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${model.bashlanWagty}-${model.gutaranWagty}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    model.differenceBetweenTimes(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    model.sene,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (model.isSpes)
                                        const Text(
                                          "C",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.green),
                                        ),
                                      if (model.isPogoda)
                                        const Text(
                                          "  P",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.green),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
        
                            // Right circle — %
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 34,
                                child: Text(
                                  "+${(model.prosent()).toStringAsFixed(1)}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

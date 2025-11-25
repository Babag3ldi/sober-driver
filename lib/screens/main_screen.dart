import 'package:driver_app/data/routes.dart';
import 'package:driver_app/screens/barada.dart';
import 'package:driver_app/screens/cash_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/baza_model.dart';
import '../providers/baza_provider.dart';
import '../providers/baha_provider.dart';
import '../services/timer_service.dart';
import '../services/hive_service.dart';

// Widgets
import '../widgets/timer_display.dart';
import '../widgets/route_selector.dart';
import '../widgets/price_display.dart';
import '../widgets/extras_checkboxes.dart';
import '../widgets/start_finish_buttons.dart';
import '../widgets/bottom_menu.dart';
import '../widgets/title_clock_header.dart';

class MainScreen extends StatefulWidget {
  final int lastIndex;

  const MainScreen({super.key, required this.lastIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DateTime _selectDate = DateTime.now();
  String? from;
  String? to;

  bool isSpes = false;
  bool isPogoda = false;

  bool isRunning = false;

  Duration duration = Duration.zero;

  late TimerService timerService;

  @override
  void initState() {
    super.initState();
    timerService = TimerService(onTick: _updateTime);
    Provider.of<BazaProvider>(context, listen: false).loadFromHive();
                  // print("$tot");
  }

  void _updateTime(Duration d) {
    setState(() {
      duration = d;
    });
  }

  void _startRide() async {
    if (from == null || to == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Iki şäheri saýla!")));
      return;
    }

    isRunning = true;

    final now = DateTime.now();

    final model = BazaModel(
      id: widget.lastIndex + 1,
      aCity: from!,
      bCity: to!,
      baha: context.read<BahaProvider>().baha,
      bashlanWagty: DateFormat("HH:mm:ss").format(now),
      bashlanSene: now.toString(),
      gutaranWagty: "",
      gutaranSene: "",
      sene: DateFormat("dd-MM-yyyy").format(now),
      isSpes: isSpes,
      isPogoda: isPogoda,
      yarygije: false,
      dolanWagt: 30,
      isFinished: false,
    );

    await HiveService.add(model);

    context.read<BazaProvider>().setActiveRide(model);

    timerService.start();
    setState(() {});
  }

  // 🔵 Finish
  void _finishRide() async {
    if (!isRunning) return;

    final ride = context.read<BazaProvider>().activeRide;
    if (ride == null) return;

    timerService.stop();

    final now = DateTime.now();

    int price = context.read<BahaProvider>().baha;
    int extra = (price / 10).round();

    ride
      ..gutaranWagty = DateFormat("HH:mm:ss").format(now)
      ..gutaranSene = now.toString()
      ..baha = price + extra
      ..isFinished = true;

    await HiveService.update(ride);

    // Reset UI
    setState(() {
      isRunning = false;
      duration = Duration.zero;

      from = null;
      to = null;
      isSpes = false;
      isPogoda = false;
    });

    // context.read<BahaProvider>().setBaha(0);
    context.read<BazaProvider>().clearActive();
  }

  @override
  void dispose() {
    timerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerBaha = context.watch<BahaProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF000023),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleAndClockHeader(title: "Babo", selectDate: _selectDate),

              TimerDisplay(duration: duration),

              const SizedBox(height: 20),

              RouteSelector(
                from: from,
                to: to,
                cities: shaherlerA,
                onFromChanged: (v) {
                  from = v;
                  if (to != null) {
                    providerBaha.calculateBase(from!, to!);
                  }
                },
                onToChanged: (v) {
                  to = v;
                  if (from != null && to != null) {
                    providerBaha.calculateBase(from!, to!);
                  }
                },
              ),

              const SizedBox(height: 20),
              PriceDisplay(price: providerBaha.baha),
              const SizedBox(height: 20),
              ExtrasCheckboxes(
                isSpes: isSpes,
                isPogoda: isPogoda,
                onSpesChanged: (v) {
                  if (v == false) return;
                  setState(() {
                    isSpes = v;
                  });
                  if (v) providerBaha.add(10);
                },
                onPogodaChanged: (v) {
                  if (v == false) return;
                  setState(() {
                    isPogoda = v;
                  });
                  if (v) providerBaha.add(20);
                },
              ),
              const SizedBox(height: 20),
              StartFinishButtons(
                isRunning: isRunning,
                onStart: _startRide,
                onFinish: _finishRide,
              ),
              const SizedBox(height: 20),
              BottomMenu(
                onCash: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CashRegister()),
                  );
                },

                onHistory: () {},
                onInfo: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Barada()),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

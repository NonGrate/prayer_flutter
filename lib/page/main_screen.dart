import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/logic/realtime_database.dart';
import 'package:prayer/model/prayer.dart';
import 'package:prayer/widget/prayer_card.dart';
import 'package:rxdart/rxdart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Api api = Api();

  int selectedIndex = 1;
  PrayerCardUse selectedUse = PrayerCardUse.FEED;

  final FirestoreDatabase rd = FirestoreDatabase();
  late StreamSubscription onPrayer;
  final BehaviorSubject<List<Prayer>> obsPrayers = new BehaviorSubject<List<Prayer>>();
  final GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    onPrayer.cancel();
    obsPrayers.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr("prayers"),
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed("/settings"),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: content(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: tr('selected'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: tr('feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: tr('my_own'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (value) {
          setState(() {
            selectedIndex = value;
            selectedUse = value == 0
                ? PrayerCardUse.SELECTED
                : value == 2
                    ? PrayerCardUse.OWN
                    : PrayerCardUse.FEED;
          });
          loadData();
        },
      ),
      floatingActionButton: selectedUse == PrayerCardUse.OWN
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context).pushNamed("/create"),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget content() {
    return StreamBuilder<List<Prayer>>(
      stream: obsPrayers,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Prayer> prayers = snapshot.data!.where((element) {
          if (selectedUse == PrayerCardUse.SELECTED) {
            return element.followed;
          } else if (selectedUse == PrayerCardUse.FEED) {
            return true;
          } else if (selectedUse == PrayerCardUse.OWN) {
            return element.authorId == 0; // TODO add profile id to DC
          }
          return false;
        }).toList();
        if (prayers.isEmpty) {
          return Column(
            children: [
              Center(
                child: Text(tr("no_prayers")),
              ),
            ],
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async => loadData(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => PrayerCard(prayer: prayers[index], use: selectedUse),
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: prayers.length,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void loadData() async {
    await rd.initDb();

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("prayers").get();
    List<Prayer> _prayers = [];
    snapshot.docs.forEach((element) {
      final Prayer prayer = Prayer.fromJson(element.data());
      _prayers.add(prayer);
    });
    _prayers.sort((Prayer a, Prayer b) => -a.createdAt.compareTo(b.createdAt));
    obsPrayers.sink.add(_prayers);
  }
}

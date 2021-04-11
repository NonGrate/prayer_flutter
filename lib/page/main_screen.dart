import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/logic/api.dart';
import 'package:prayer/model/Prayer.dart';
import 'package:prayer/widget/prayer_card.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Api api = Api();

  List<Prayer> prayers;
  int selectedIndex = 1;
  PrayerCardUse selectedUse = PrayerCardUse.FEED;

  @override
  void initState() {
    loadData();
    super.initState();
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
              child: Icon(Icons.settings, color: Colors.white,),
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
    if (prayers == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (prayers.isEmpty) {
      return Column(
        children: [
          Center(
            child: Text(tr("no_prayers")),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
      );
    }
  }

  void loadData() async {
    var _prayers;
    if (selectedUse == PrayerCardUse.SELECTED) {
      _prayers = await api.loadSelectedPrayers();
    } else if (selectedUse == PrayerCardUse.FEED) {
      _prayers = await api.loadPrayers();
    } else if (selectedUse == PrayerCardUse.OWN) {
      _prayers = await api.loadMyPrayers();
    }

    setState(() {
      prayers = _prayers;
    });
  }
}

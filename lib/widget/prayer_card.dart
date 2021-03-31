import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer/model/Prayer.dart';

class PrayerCard extends StatelessWidget {
  final Prayer prayer;
  final PrayerCardUse use;

  const PrayerCard({Key key, this.prayer, this.use}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prayer.content, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            SizedBox(height: 8),
            use == PrayerCardUse.OWN
                ? Text("${prayer.follows} follows you!", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
                : use == PrayerCardUse.FEED
                    ? Row(
                        children: [
                          Text("✓ Pray for them", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                          Expanded(child: Container()),
                          Text("✗ Don't show", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                        ],
                      )
                    : Text("${prayer.follows} follows", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
          ],
        ),
      ),
    );
  }
}

enum PrayerCardUse {
  FEED,
  SELECTED,
  OWN,
}

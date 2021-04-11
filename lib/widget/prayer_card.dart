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
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prayer.content, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
            SizedBox(height: 8),
            Divider(
              color: Colors.grey,
              height: 2,
            ),
            use == PrayerCardUse.OWN
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${prayer.follows} follows you!",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  )
                : use == PrayerCardUse.FEED
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "✓ Pray for them",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "✗ Don't show",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${prayer.follows} follows",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
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

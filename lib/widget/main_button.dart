import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  // final double height;
  final String text;
  final bool loading;
  final VoidCallback tap;
  final bool hasIcon;
  final Widget icon;

  ButtonMain({
    Key key,
    // @required this.height,
    @required this.text,
    @required this.loading,
    @required this.tap,
    this.icon,
    this.hasIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget textChild = loading == true
        ? SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasIcon
                  ? Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: icon,
                    )
                  : Container(),
              Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          );

    return GestureDetector(
      onTap: tap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange[700],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 6,
              color: Colors.black.withOpacity(0.15),
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: textChild,
      ),
    );
  }
}

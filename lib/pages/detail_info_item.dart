import 'package:flutter/material.dart';

class DetailInfoItem extends StatelessWidget {
  Icon icon;
  String title;
  double fontSize;
  EdgeInsets margin;
  DetailInfoItem(
      {Key key,
      @required this.icon,
      @required this.title,
      this.fontSize,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: this.margin ?? EdgeInsets.symmetric(horizontal: 10),
          child: this.icon,
        ),
        Container(
          child: Text(this.title,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: this.fontSize ?? 17)),
        )
      ],
    );
  }
}

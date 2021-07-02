import 'package:flutter/material.dart';
import 'package:weather_app/pages/setting_detail.dart';

class SettingItem extends StatelessWidget {
  String title;
  String meansure;
  List<String> optionNames;
  SettingItem(
      {Key key,
      @required this.title,
      @required this.meansure,
      @required this.optionNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20),
            child:
                Text(this.title, style: Theme.of(context).textTheme.headline6)),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingDetail(
                          optionName: this.optionNames,
                          title: "${this.title} setting",
                        )));
          },
          child: Row(
            children: [
              Text(
                this.meansure,
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.arrow_forward_ios))
            ],
          ),
        )
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/pages/setting_detail.dart';

class SettingItem extends StatefulWidget {
  String title;
  String meansure;
  List<String> optionNames;
  int defaultIndex;
  final Function onSelect;

  SettingItem(
      {Key key,
      @required this.title,
      @required this.meansure,
      @required this.optionNames,
      @required this.defaultIndex,
      @required this.onSelect})
      : super(key: key);

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(widget.title,
                style: Theme.of(context).textTheme.headline6)),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingDetail(
                          optionName: widget.optionNames,
                          title: "${widget.title} setting",
                          defaultIndex: widget.defaultIndex,
                          // onSelect: (index) {
                          //   print("Selected $index");
                          // },
                          
                          onSelect: (index) {
                            widget.onSelect(index);
                            
                          },
                        )));
          },
          child: Row(
            children: [
              Text(
                widget.meansure,
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

import 'package:flutter/material.dart';

class SettingDetail extends StatefulWidget {
  final List<String> optionName;
  final String title;
  int defaultIndex;
  final Function onSelect;
  // final Function onSelectOption; @required this.onSelectOption
  SettingDetail(
      {Key key,
      @required this.title,
      @required this.optionName,
      @required this.defaultIndex,
      @required this.onSelect})
      : super(key: key);

  @override
  _SettingDetailState createState() => _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: widget.optionName.length,
            itemBuilder: (context, index) {
              return RadioListTile<int>(
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: Colors.deepPurple,
                title: Text(widget.optionName[index]),
                value: index,
                groupValue: widget.defaultIndex,
                onChanged: (int newIndex) {
                  widget.onSelect(newIndex);
                  setState(() {
                    widget.defaultIndex = newIndex;
                  });
                },
              );
            }),
      ),
    );
  }
}

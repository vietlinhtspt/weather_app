import 'package:flutter/material.dart';

class SettingDetail extends StatefulWidget {
  final List<String> optionName;
  final String title;
  // final Function onSelectOption; @required this.onSelectOption
  const SettingDetail(
      {Key key, @required this.title, @required this.optionName})
      : super(key: key);

  @override
  _SettingDetailState createState() => _SettingDetailState();
}

class _SettingDetailState extends State<SettingDetail> {
  int selectedIndex = 1;
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
                groupValue: selectedIndex,
                onChanged: (int newIndex) {
                  print("selected $newIndex");
                  setState(() {
                    selectedIndex = newIndex;
                  });
                },
              );
            }),
      ),
    );
  }
}

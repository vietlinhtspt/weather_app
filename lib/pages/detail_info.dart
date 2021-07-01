import 'package:flutter/material.dart';
import 'package:weather_app/pages/detail_info_item.dart';

class DetailInfo extends StatelessWidget {
  const DetailInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DetailInfoItem(
          icon: Icon(
            Icons.grain,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "13%",
        ),
        DetailInfoItem(
          icon: Icon(
            Icons.lock_clock,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "0.533 mBar",
        ),
        DetailInfoItem(
          icon: Icon(
            Icons.stacked_line_chart,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "9km/h",
        )
      ],
    );
  }
}

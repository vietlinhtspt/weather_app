import 'package:flutter/material.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Text(
            "San Fransisco",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "18°",
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 60),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.deepPurple[900],
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              "Cloudy",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

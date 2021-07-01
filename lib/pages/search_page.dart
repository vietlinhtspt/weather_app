import 'package:flutter/material.dart';
import 'package:weather_app/pages/detail_info_item.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/searchBar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _cityTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SearchBar(cityTextController: _cityTextController),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            width: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "22°",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  GradientIcon(
                      icon: Icon(
                    Icons.cloud,
                    size: 50,
                  ))
                ],
              ),
              Text(
                "Austin",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                "USA",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.blueGrey[600]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailInfoItem(
                    icon: Icon(
                      Icons.grain,
                      size: 17,
                      color: Colors.blueGrey[600],
                    ),
                    title: "17%",
                    fontSize: 14,
                    margin: EdgeInsets.only(right: 5),
                  ),
                  DetailInfoItem(
                    icon: Icon(
                      Icons.stacked_line_chart,
                      size: 14,
                      color: Colors.blueGrey[600],
                    ),
                    title: "7km/h",
                    fontSize: 14,
                    margin: EdgeInsets.only(right: 5),
                  )
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/pages/gradientIcon.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    @required TextEditingController cityTextController,
  })  : _cityTextController = cityTextController,
        super(key: key);

  final TextEditingController _cityTextController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: GradientIcon(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20),
                child: TextFormField(
                    controller: _cityTextController,
                    decoration: InputDecoration(
                        labelText: 'Enter a city',
                        hintText: 'Example: Chicago')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

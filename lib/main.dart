import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc_observer.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_user_bloc.dart';
import 'package:weather_app/blocs/weather_search_bloc.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/setting_page.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/theme.dart';

void main() {
  Bloc.observer = WeatherBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final WeatherServices weatherServices =
      WeatherServices(httpClient: http.Client());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: MultiBlocProvider(providers: [
        BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(weatherServices: weatherServices)),
        BlocProvider<WeatherSearchBloc>(
            create: (context) =>
                WeatherSearchBloc(weatherServices: weatherServices)),
        BlocProvider<WeatherUserBloc>(
          create: (context) =>
              WeatherUserBloc(weatherServices: weatherServices),
        )
      ], child: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  int selectedIndex;
  MainPage({Key key, this.selectedIndex = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    SettingPage(),
  ];
  WeatherBloc _weatherBloc;
  @override
  void initState() {
    super.initState();
    _weatherBloc = BlocProvider.of<WeatherBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _weatherBloc.changeTabController.stream,
      builder: (context, snapshot) {
        int indexTab = 0;
        if (snapshot.hasData) {
          indexTab = snapshot.data;
        }
        print(indexTab);

        return Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(indexTab),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            unselectedItemColor: Theme.of(context).cardColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GradientIcon(icon: Icon(Icons.school)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(icon: Icon(Icons.search)),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: GradientIcon(icon: Icon(Icons.settings)),
                label: 'Setting',
              ),
            ],
            currentIndex: indexTab,
            // selectedItemColor: Colors.amber[800],
            onTap: (index) {
              print(index);
              _weatherBloc.changeTabController.add(index);
            },
          ),
        );
      },
    );
  }
}

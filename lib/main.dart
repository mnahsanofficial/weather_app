import 'package:flutter/material.dart';
import 'package:weather_app/api_service.dart';
import 'package:weather_app/modelWeather.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.cyan,
          appBar: AppBar(
            title: Text("Weather update ",style: TextStyle(fontSize: 30),),

          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_response != null)
                    Column(
                      children: [
                        Image.network(_response.iconUrl),
                        Text(
                          '${_response.tempInfo.temperature}° F',
                          style: TextStyle(fontSize: 40),
                        ),
                        Text(_response.weatherInfo.description,style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 250,
                      child: TextField(
                          controller: _cityTextController,
                          decoration: InputDecoration(labelText: 'City',labelStyle: TextStyle(fontSize: 30)),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  ElevatedButton(onPressed: _search, child: Text('Search',style: TextStyle(fontSize: 20),),style: ElevatedButton.styleFrom(primary: Colors.amberAccent,shadowColor: Colors.black),)
                ],
              ),
            ),
          ),
        ));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
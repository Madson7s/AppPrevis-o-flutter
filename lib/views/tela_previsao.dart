import 'dart:convert';

//import 'menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Weather> getWeather() async {
  final String url = 'https://api.hgbrasil.com/weather?key=<c4245bac>';

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return Weather.fromJson(json.decode(response.body));
  } else {
    throw Exception("Deu ruim");
  }
}

class Weather {
  String city;
  String date;
  String condition;
  int maxTemp;
  int minTemp;

  factory Weather.fromJson(Map<String, dynamic> jsonMap) {
    return Weather(
        city: jsonMap['results']['city'],
        date: jsonMap['results']['forecast'][0]['date'],
        condition: jsonMap['results']['forecast'][0]['description'],
        maxTemp: jsonMap['results']['forecast'][0]['max'],
        minTemp: jsonMap['results']['forecast'][0]['min']);
  }
  Weather({this.city, this.date, this.condition, this.maxTemp, this.minTemp});
}

class TelaPrevisao extends StatefulWidget {
  @override
  _TelaPrevisaoState createState() => _TelaPrevisaoState();
}

class _TelaPrevisaoState extends State<TelaPrevisao> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Previsão de Tempo',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            "Previsão do tempo",
          ),
          centerTitle: true,
        ),
           body: FutureBuilder<Weather>(
            //IMPORTANTE
            future: getWeather(), //IMPORTANTE
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        snapshot.data.date,
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                      Icon(
                        Icons.cloud,
                        size: 250.0,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          snapshot.data.condition,
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      Text(
                          "Máxima: ${snapshot.data.maxTemp.toString()}°", //IMPORTANTE
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                      Text("Mínima: ${snapshot.data.minTemp.toString()}°",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white)),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator() //IMPORTANTE
               );
              }
            },
          )),
    );
  }
}

// codigo que possa ser aproveitado em uma certa melhoria

 /*
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   height: 120,
//                   width: 320,
//                   margin: const EdgeInsets.all(10.0),
//                   padding: const EdgeInsets.all(40.0),
//                   child: Text("CONSULTA"),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.blue),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 Divider(
//                   height: 20,
//                   color: Colors.white,
//                 ),
//                 Container(
//                   height: 260,
//                   width: 320,
//                   margin: const EdgeInsets.all(10.0),
//                   padding: const EdgeInsets.all(40.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.blue),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//         drawer: Drawer(
//           child: TelaPrevisaoDrawer(),
//         */
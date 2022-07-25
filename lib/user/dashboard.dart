import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelmap/restaurant/mapmain.dart';
import 'package:travelmap/restaurant/providers/info_window_provider.dart';
import 'package:travelmap/restaurant/providers/map_provider.dart';
import 'package:provider/provider.dart';


class DashBoard extends StatefulWidget {

  const DashBoard({Key? key}) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context){
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => MapProvider()),
        ListenableProvider(create: (_) => InfoWindowProvider()),
      ],
      child: MaterialApp(
        title: 'GMap Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyMap(),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelmap/restaurant/providers/info_window_provider.dart';
import 'package:travelmap/restaurant/providers/map_provider.dart';
import 'package:travelmap/restaurant/ui/map_screen.dart';
import 'package:provider/provider.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
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
        home: MapScreen(),
      ),
    );
  }
}

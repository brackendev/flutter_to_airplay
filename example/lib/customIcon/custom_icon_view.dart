import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_to_airplay/flutter_to_airplay.dart';

class CustomIconView extends StatefulWidget {
  @override
  _CustomIconViewState createState() => _CustomIconViewState();
}

class _CustomIconViewState extends State<CustomIconView> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterToAirplay.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Flutter 2 Airplay'),
              Text(
                _platformVersion,
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          leading: IconButton(
            alignment: Alignment.centerLeft,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          actions: [
            Container(
              width: 44.0,
              height: 44.0,
              child: Stack(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.play_arrow),
                  ),
                  AirPlayRoutePickerView(
                    tintColor: Colors.transparent,
                    activeTintColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: FlutterAVPlayerView(
              filePath: 'assets/videos/butterfly.mp4',
              // urlString:
              //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            ),
          ),
        ),
      ),
    );
  }
}

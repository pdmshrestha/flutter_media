import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluttermedia/fluttermedia.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<FlutterMediaImage> _images = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    List<FlutterMediaImage> images = [];
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      images = await FlutterMedia.images(limit: 2);
      print("images ${images.length}");
    } on PlatformException {
      print("Failed to load images");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() => _images = images);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: 1,
          ),
          itemCount: _images.length,
          itemBuilder: (_, index) {
            return Image.file(
              _images[index].file,
            );
          },
        ),
      ),
    );
  }
}

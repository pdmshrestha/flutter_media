import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterMedia {
  static const MethodChannel _channel = const MethodChannel('fluttermedia');

  static Future<List<FlutterMediaImage>> images({int limit}) async {
    final List<FlutterMediaImage> images = [];

    try {
      var args = <String, dynamic>{'limit': limit ?? null};
      final resp = await _channel.invokeMethod('getImages', args);
      print("Got images response form device $resp");
      final data = jsonDecode(resp);
      if (data is List) {
        data.forEach((res) => images.add(FlutterMediaImage.fromJson(res)));
      }
      return images;
    } catch (e) {
      throw e;
    }
  }
}

class FlutterMediaImage {
  final int id;
  final File file;
  final String dateTaken;
  final String displayName;

  const FlutterMediaImage(this.id, this.file, this.dateTaken, this.displayName);

  FlutterMediaImage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        file = json['data'] != null ? File(json['data']) : null,
        dateTaken = json['dataTaken'],
        displayName = json['displayName'];
}

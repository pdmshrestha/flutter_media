import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class FlutterMedia {
  static const MethodChannel _channel = const MethodChannel('fluttermedia');

  static Future<List<FlutterMediaImage>> images({int limit}) async {
    final List<FlutterMediaImage> images = [];

    try {
      var args = <String, dynamic>{'limit': limit ?? null};
      final resp = await _channel.invokeMethod('getImages', args);

      print("Got images $resp");

      var allImages = resp as List;

      allImages.forEach((img) {
        print("img $img");
        images.add(FlutterMediaImage.fromMap(img));
      });

      return images;
    } catch (e) {
      throw e;
    }
  }
}

class FlutterMediaImage {
  final int id;
  final File file;
  final String displayName;

  const FlutterMediaImage(this.id, this.file, this.displayName);

  FlutterMediaImage.fromMap(Map<dynamic, dynamic> json)
      : id = json['id'],
        file = json['data'] != null ? File(json['data'].toString()) : null,
        displayName = json['displayName'].toString();
}

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttermedia/fluttermedia.dart';

void main() {
  const MethodChannel channel = MethodChannel('fluttermedia');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterMedia.images, '');
  });
}

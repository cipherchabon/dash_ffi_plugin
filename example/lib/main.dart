import 'dart:ffi';
import 'dart:isolate';

import 'package:dash_ffi_plugin/bindings.dart';
import 'package:flutter/material.dart';

void main() {
  bindings.store_dart_post_cobject(NativeApi.postCObject);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final receivePort = ReceivePort();
  List<int> messages = [];

  @override
  void initState() {
    super.initState();
    receivePort.listen((message) {
      setState(() {
        messages.add(message);
      });
    });
    bindings.start_rust_code(receivePort.sendPort.nativePort);
  }

  @override
  void dispose() {
    receivePort.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                for (final message in messages)
                  Text(
                    message.toString(),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

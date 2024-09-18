import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'providers/image_provider.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var imageList = ref.watch(imageProvider);
    List<Widget> tempList = [];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final url =
                                Uri.https('image360.oppget.com', 'api/photos/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            tempList = [];
                            for (var photo in data) {
                              // debugPrint(photo["thumb_url"].toString());
                              tempList.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            ref.read(imageProvider.notifier).state = tempList;
                          },
                          child: const Text('all')),
                      ElevatedButton(
                          onPressed: () async {
                            tempList = [];
                            final url = Uri.https(
                                'image360.oppget.com', 'api/realestate/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            for (var photo in data) {
                              tempList.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            ref.read(imageProvider.notifier).state = tempList;
                          },
                          child: const Text('real estate')),
                      ElevatedButton(
                          onPressed: () async {
                            tempList = [];
                            final url = Uri.https(
                                'image360.oppget.com', 'api/automotive/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            for (var photo in data) {
                              tempList.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            ref.read(imageProvider.notifier).state = tempList;
                          },
                          child: const Text('automotive')),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: imageList,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

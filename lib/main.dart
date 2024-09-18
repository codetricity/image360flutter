import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Widget> photos = [];
  List<Widget> displayPhotos = [];

  @override
  Widget build(BuildContext context) {
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
                            photos = [];
                            final url =
                                Uri.https('image360.oppget.com', 'api/photos/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            for (var photo in data) {
                              // debugPrint(photo["thumb_url"].toString());
                              photos.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            setState(() {
                              displayPhotos = photos;
                            });
                          },
                          child: const Text('all')),
                      ElevatedButton(
                          onPressed: () async {
                            photos = [];
                            final url = Uri.https(
                                'image360.oppget.com', 'api/realestate/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            for (var photo in data) {
                              photos.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            setState(() {
                              displayPhotos = photos;
                            });
                          },
                          child: const Text('real estate')),
                      ElevatedButton(
                          onPressed: () async {
                            photos = [];
                            final url = Uri.https(
                                'image360.oppget.com', 'api/automotive/');
                            final response = await http.get(url);
                            final data = json.decode(response.body);
                            for (var photo in data) {
                              photos.add(Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(photo["thumb_url"]),
                              ));
                            }
                            setState(() {
                              displayPhotos = photos;
                            });
                          },
                          child: const Text('automotive')),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: displayPhotos,
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

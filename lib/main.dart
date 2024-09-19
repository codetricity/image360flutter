import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image360mobile/view/get_photo_button.dart';
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GetPhotoButton(path: 'api/photos/', label: 'all'),
                      GetPhotoButton(
                          label: 'real estate', path: 'api/realestate/'),
                      GetPhotoButton(
                          label: 'automotive', path: 'api/automotive/'),
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

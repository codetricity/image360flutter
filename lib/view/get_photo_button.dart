import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:image360mobile/view/image_screen.dart';
import 'dart:convert';
import '../providers/image_provider.dart';

class GetPhotoButton extends ConsumerWidget {
  final String label;
  final String path;

  const GetPhotoButton({
    required this.label,
    required this.path,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () async {
          final url = Uri.https('image360.oppget.com', path);
          final response = await http.get(url);
          final data = json.decode(response.body);
          List<Widget> tempList = [];
          for (var photo in data) {
            // debugPrint(photo["thumb_url"].toString());
            tempList.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    debugPrint(photo["medium_url"]);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImageScreen(
                          Image.network(photo["medium_url"]),
                        ),
                      ),
                    );
                  },
                  child: Image.network(photo["thumb_url"])),
            ));
          }
          ref.read(imageProvider.notifier).state = tempList;
        },
        child: Text(label));
  }
}

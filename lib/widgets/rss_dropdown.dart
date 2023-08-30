import 'package:flutter/material.dart';
import '../services/rss_service.dart';

class RssDropdown extends StatefulWidget {
  const RssDropdown({super.key});

  @override
  _RssDropdownState createState() => _RssDropdownState();
}

class _RssDropdownState extends State<RssDropdown> {
  List<Map<String, dynamic>> rssList = [];
  String? selectedUrl;

  @override
  void initState() {
    super.initState();
    _loadRssList();
  }

  _loadRssList() async {
    try {
      List<Map<String, dynamic>> fetchedList = await RssService.fetchRssList(); // Türü burada değiştirdik.
      setState(() {
        rssList = fetchedList;
        selectedUrl = rssList[0]['url'];
      });
    } catch (e) {
      print("Error fetching RSS list: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedUrl,
      onChanged: (String? newValue) {
        setState(() {
          selectedUrl = newValue!;
        });
        // TODO: Use selectedUrl to fetch news.
      },
      items: rssList.map((rss) {
        return DropdownMenuItem<String>(
          value: rss['url'],
          child: Text(rss['name']!),
        );
      }).toList(),
    );
  }
}

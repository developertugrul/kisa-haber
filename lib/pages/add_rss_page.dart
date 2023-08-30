import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRssPage extends StatefulWidget {
  const AddRssPage({super.key});

  @override
  _AddRssPageState createState() => _AddRssPageState();
}

class _AddRssPageState extends State<AddRssPage> {
  final _controllerName = TextEditingController();
  final _controllerUrl = TextEditingController();
  List<Map<String, String>> _rssList = [];

  @override
  void initState() {
    super.initState();
    _loadRssFeeds();
  }

  bool isValidUrl(String url) {
    try {
      Uri.parse(url);
    } catch (e) {
      return false;
    }
    return true;
  }

  _loadRssFeeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? customRssList = prefs.getStringList('customRssList');
    if (customRssList != null) {
      setState(() {
        _rssList = customRssList.map((rssData) {
          List<String> parts = rssData.split('|');
          return {
            'name': parts[0],
            'url': parts[1],
          };
        }).toList();
      });
    }
  }

  _saveRssUrl() async {
    if (_controllerName.text.isEmpty || _controllerUrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen tüm alanları doldurunuz!'))
      );
      return;
    }

    if (!isValidUrl(_controllerUrl.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen geçerli bir URL giriniz!'))
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String combinedData = '${_controllerName.text}|${_controllerUrl.text}';
    List<String> customRssList = prefs.getStringList('customRssList') ?? [];
    customRssList.add(combinedData);
    await prefs.setStringList('customRssList', customRssList);
    _loadRssFeeds();
    _controllerName.clear();
    _controllerUrl.clear();
  }

  _deleteRss(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? customRssList = prefs.getStringList('customRssList');
    if (customRssList != null) {
      customRssList.removeAt(index);
      await prefs.setStringList('customRssList', customRssList);
      _loadRssFeeds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Özel RSS Feedleri')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(labelText: 'RSS Adı'),
            ),
            TextField(
              controller: _controllerUrl,
              decoration: const InputDecoration(labelText: 'RSS URL'),
            ),
            ElevatedButton(onPressed: _saveRssUrl, child: const Text('Ekle')),
            Expanded(
              child: ListView.builder(
                itemCount: _rssList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_rssList[index]['name']!),
                    subtitle: Text(_rssList[index]['url']!),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteRss(index),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

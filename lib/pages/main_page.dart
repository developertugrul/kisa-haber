import 'package:flutter/material.dart';
import 'package:kisahaber/services/news_service.dart';
import 'package:kisahaber/models/news.dart';
import 'package:kisahaber/pages/add_rss_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/rss_service.dart';
import 'contact_page.dart';
import 'news_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _selectedFeedUrl;
  List<News>? _news;
  List<Map<String, dynamic>>? _rssFeeds;

  @override
  void initState() {
    super.initState();
    _loadRssFeeds();
  }

  _loadCustomRssUrls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> customRssUrls = (prefs.getStringList('customRss') ?? []);
    for (String url in customRssUrls) {
      _rssFeeds!.add({
        'name': 'Özel RSS',
        'url': url,
      });
    }
  }

  _loadRssFeeds() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> customRssList = prefs.getStringList('customRssList') ?? [];

      List<Map<String, dynamic>> customFeeds = customRssList.map((rssData) {
        List<String> parts = rssData.split('|');
        return {
          'name': parts[0],
          'url': parts[1],
        };
      }).toList();

      // API'den gelen feed'leri alalım
      List<Map<String, dynamic>> apiFeeds = await RssService.fetchRssList();

      // İki listeyi birleştirelim
      List<Map<String, dynamic>> combinedFeeds = apiFeeds + customFeeds;

      setState(() {
        _rssFeeds = combinedFeeds;
        if (_rssFeeds!.isNotEmpty) {
          _selectedFeedUrl = _rssFeeds![0]['url'] as String;
        }
      });
    } catch (e) {
      print("Error fetching RSS feeds: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kısa Haber'),
        actions: [
          IconButton(
            icon: const Icon(Icons.contact_mail),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // RSS feedlerini liste olarak göster
            Expanded(
              child: ListView.builder(
                itemCount: _rssFeeds?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _rssFeeds![index]['name'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onTap: () async {
                      // RSS'e tıklanınca ilgili haberleri getir
                      _news = await NewsService.fetchNews(
                          _rssFeeds![index]['url'] as String);
                      // navigate to news list page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsListPage(news: _news),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddRssPage(),
                ));
                _loadRssFeeds(); // AddRssPage'den döndükten sonra RSS listesini yeniden yükleyin.
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

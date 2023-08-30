import 'package:flutter/material.dart';
import 'package:kisahaber/models/news.dart';
import '../pages/news_detail_page.dart';
import '../services/news_service.dart';

class NewsList extends StatefulWidget {
  final String feedUrl;

  NewsList({required this.feedUrl});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> newsList = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  _loadNews() async {
    try {
      List<News> fetchedNews = await NewsService.fetchNews(widget.feedUrl);
      setState(() {
        newsList = fetchedNews;
      });
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        final news = newsList[index];
        return ListTile(
          title: Text(news.title),
          subtitle: Text(news.descriptionOrContent),
          leading: Image.network(news.imageUrl),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsDetailPage(url: news.linkOrUrl),
            ));
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../models/news.dart';
import 'news_detail_page.dart';

class NewsListPage extends StatelessWidget {
  final List<News>? news;

  const NewsListPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RSS Feed'),
      ),
      body: ListView.builder(
        itemCount: news?.length ?? 0,
        itemBuilder: (context, index) {
          final newsItem = news![index];
          return ListTile(
            title: Text(newsItem.title),
            subtitle: Text(newsItem.descriptionOrContent),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(url: newsItem.linkOrUrl),
                ),
              );
            },
            leading: newsItem.imageUrl != null && newsItem.imageUrl!.isNotEmpty
                ? Image.network(newsItem.imageUrl!)
                : null,
          );
        },
      ),
    );
  }
}
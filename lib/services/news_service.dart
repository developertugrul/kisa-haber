import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:kisahaber/models/news.dart';

class NewsService {
  static Future<List<News>> fetchNews(String feedUrl) async {
    Iterable<xml.XmlElement>? items;
    final response = await http.get(
      Uri.parse(feedUrl),
      headers: {'Accept': 'application/xml'},
    );
    String xmlData = utf8.decode(response.bodyBytes);
    // BOM'u kaldır
    if (xmlData.startsWith('ï»¿')) {
      xmlData = xmlData.substring(3);
    }

    if (response.statusCode == 200) {
      final news = <News>[];
      final document = xml.XmlDocument.parse(xmlData);

      // check if rss has item or entry
      if (document.findAllElements('item').isEmpty) {
        items = document.findAllElements('entry');
      } else {
        items = document.findAllElements('item');
      }

      //print(items);
      for (var item in items!) {

        final titleElements = item.findElements('title');
        final title = titleElements.isNotEmpty ? titleElements.first.text : '';

        final linkElements = item.findElements('link');
        final urlElements = item.findElements('url');
        final linkOrUrl = linkElements.isNotEmpty
            ? linkElements.first.text
            : (urlElements.isNotEmpty ? urlElements.first.text : '');

        // check if rss has description or content
        final descriptionOrContent = item.findElements('description').isEmpty
            ? item.findElements('content').isEmpty
                ? item.findElements('summary').single.text
                : item.findElements('content').single.text
            : item.findElements('description').single.text;

        // Parsing image from content/description
        final imgRegex = RegExp(r'<img[^>]+src="([^">]+)"');
        final imgMatch = imgRegex.firstMatch(descriptionOrContent);
        final imageUrl = imgMatch?.group(1) ?? '';

        // Cleaning HTML tags
        final cleanedDescription =
            descriptionOrContent.replaceAll(RegExp(r'<[^>]+>'), '');

        news.add(News(
            title: title,
            linkOrUrl: linkOrUrl,
            descriptionOrContent: cleanedDescription,
            imageUrl: imageUrl));
      }
      return news;
    } else {
      throw Exception('Failed to load news');
    }
  }
}

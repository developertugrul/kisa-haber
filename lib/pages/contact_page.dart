import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İletişim'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: const Column(
          children: [
            Text(
              'Kısa Haber Uygulaması',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Bu uygulama, Flutter ile geliştirilmiş bir RSS okuyucudur.'),
            SizedBox(height: 16.0),
            Text(
                'Uygulama,haber özetlerini sizlere sunarak sadece haberin özüne ulaşmanızı sağlar.'),
            SizedBox(height: 16.0),
            Text(
                'Uygulama, haberleri çeşitli kaynaklardan çekerek tek bir yerde toplar. Haberlere ait içeriği gösterebilmek için rss feedinin item ya da entry taglerini kullanır. Bu taglerin ise title, description, link, pubDate gibi alt tagleri vardır. Uygulama, bu taglerden title, description ve link ya da url taglerini kullanır. Uygulama, haberlerin içeriğini göstermek için webview kullanır.'),
            SizedBox(height: 16.0),
            Text(
                'Uygulama hakkındaki görüş ve önerilerinizi aşağıdaki e-posta adresine gönderebilirsiniz ya da bizi arayabilirsiniz.'),
            SizedBox(height: 32.0),
            Text(
              'E-posta: info@chokqu.com',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Text(
              'Telefon: +90 531 216 3448',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Text(
              'www.chokqu.com',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Text(
                'Uygulama Chokqu İthalat ve İhracat Limited Şirketi sponsorluğunda geliştirilmiştir.',textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}

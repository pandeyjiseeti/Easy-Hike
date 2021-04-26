import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          'https://crhscountyline.com/wp-content/uploads/2020/03/Capture.png',
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Gloria Russell',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 32.0),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'UI / UX Designer',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40.0,
                  ),
                  socialMediaLinks(
                      'assets/linkedin.png', 'https://www.linkedin.com/feed/'),
                  socialMediaLinks('assets/github.png', 'https://github.com/'),
                  socialMediaLinks(
                      'assets/twitter.png', 'https://twitter.com/'),
                  socialMediaLinks('assets/google-plus.png',
                      'https://myaccount.google.com/intro/profile'),
                  SizedBox(
                    width: 40.0,
                  ),
                ],
              ),
              Text(
                'Skills',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    skillCard('Figma'),
                    skillCard('Adobe'),
                    skillCard('Sketch'),
                    skillCard('Flutter'),
                    skillCard('Dart'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded socialMediaLinks(String imagePath, String url) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 17.0, 10.0, 17.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.pink[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new IconButton(
            icon: Image(
              image: AssetImage(imagePath),
            ),
            onPressed: () => {
              launchURL(url),
            },
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Container skillCard(String skillName) {
    return Container(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      width: 100.0,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Placeholder(
              fallbackHeight: 50.0,
              fallbackWidth: 50.0,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              skillName,
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
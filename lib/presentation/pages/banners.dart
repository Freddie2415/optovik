import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optovik/presentation/pages/home.dart';

class BannersPage extends StatefulWidget {
  @override
  _BannersPageState createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  final List<String> imgList = [
    "https://i.pinimg.com/736x/f3/51/f3/f351f350e2fd4e0bcfa7a927acca1171.jpg",
    "https://i.pinimg.com/originals/f9/6a/f9/f96af9ed2673866ff79f83c0141505bb.jpg",
    "https://sveres.ru/upload/medialibrary/f1a/000269-podborka-kreativnoy-reklamy-napitkov_027.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/disp/d7a46552615585.591606893ef38.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/1400/5a3c5a10862325.560ec9b5b07cf.jpg",
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    imgList.forEach((url) {
      precacheImage(NetworkImage(url), context);
    });

    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) => setState(() {
                _current = index;
              }),
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                        child: Image.network(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        ),
                      ),
                    ))
                .toList(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.transparent,
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((item) {
                      int index = imgList.indexOf(item);
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _current == index ? Colors.white : Colors.white24,
                        ),
                      );
                    }).toList(),
                  ),
                  FlatButton(
                    color: Colors.white.withOpacity(0.35),
                    textColor: Colors.white,
                    height: 45,
                    minWidth: 200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      // side: BorderSide(
                      //   color: Colors.white.withOpacity(0.15),
                      // ),
                    ),
                    onPressed: _onSkip,
                    child: Text(
                      "ПРОПУСТИТЬ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}

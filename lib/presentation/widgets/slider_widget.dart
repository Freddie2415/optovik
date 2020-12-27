
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optovik/domain/model/banner.dart' as models;

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key key, this.banners}) : super(key: key);

  final List<models.Banner> banners;
  List<String> get list => banners.map((models.Banner e) => e.image).toList();

  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    widget.list.forEach((url) {
      precacheImage(NetworkImage(url), context);
    });

    return Container(
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlayCurve: Curves.easeOut,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: widget.list
                .map(
                  (item) => Container(
                    child: FadeInImage.assetNetwork(placeholder: "assets/images/banner-placeholder.jpg", image: "$item"),
                  ),
            )
                .toList(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.list.map((item) {
                int index = widget.list.indexOf(item);
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.white : Colors.white24,
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.5, 1],
                  colors: [Colors.black.withOpacity(.5), Colors.transparent],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
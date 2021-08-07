import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ProductImagesWidget extends StatefulWidget {
  final List<String> images;

  const ProductImagesWidget({Key key, this.images}) : super(key: key);

  @override
  _ProductImagesWidgetState createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Image.asset("assets/images/banner-placeholder.jpg");
    }
    if (widget.images.length <= 1) {
      return FadeInImage.assetNetwork(
        placeholder: "assets/images/banner-placeholder.jpg",
        image: "${widget.images[0]}",
      );
    }
    return Container(
      child: Column(
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
            items: widget.images
                .map(
                  (item) => Container(
                child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/banner-placeholder.jpg",
                    image: "$item"),
              ),
            )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.map((item) {
              int index = widget.images.indexOf(item);
              return Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.green : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
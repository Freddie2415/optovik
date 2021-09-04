import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/presentation/pages/home.dart';
import 'package:meta/meta.dart';

class BannersPage extends StatefulWidget {
  final List<String> imgList;

  const BannersPage({Key key, @required this.imgList}) : super(key: key);

  @override
  _BannersPageState createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    widget.imgList.forEach((url) {
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
            items: widget.imgList
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
                    children: widget.imgList.map((item) {
                      int index = widget.imgList.indexOf(item);
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.45),
                      shadowColor: Colors.white.withOpacity(0),
                      minimumSize: Size(200, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: _onSkip,
                    child: Text(
                      S.of(context).skip,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
    AuthModule.authBloc().add(AppStarted());
    Navigator.pushReplacement(context, HomePage.route());
  }
}

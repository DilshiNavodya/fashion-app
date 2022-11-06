import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  List<String> listImage = [
    'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/softlogicbicloud/b/cdn/o/site-images/606d980f27c9b.jpg',
    'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/softlogicbicloud/b/cdn/o/site-images/1500-450/628782d60953b.webp',
    'https://objectstorage.ap-mumbai-1.oraclecloud.com/n/softlogicbicloud/b/cdn/o/site-images/1500-450/62971cdd76a20.webp',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        autoPlay: true,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: listImage
          .map((e) => Image.network(
                e,
                fit: BoxFit.cover,
              ))
          .toList(),
    );
  }
}

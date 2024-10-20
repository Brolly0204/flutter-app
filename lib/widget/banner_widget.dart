import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../util/screen_adapter_helper.dart';

class BannerWidget extends StatefulWidget {
  final List<String> bannerList;
  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
            carouselController: _controller,
            items: widget.bannerList
                .map((item) => _bannerItem(item, width))
                .toList(),
            options: CarouselOptions(
                height: 160.px,
                autoPlay: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                }))
      ],
    );
  }

  Widget _bannerItem(String imageUrl, double width) {
    return GestureDetector(
      child: Image.network(imageUrl, width: width, fit: BoxFit.fill),
      onTap: () {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app/model/home_model.dart';
import '../util/screen_adapter_helper.dart';

class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;
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
                })),
        Positioned(bottom: 10, left: 0, right: 0, child: _indicator())
      ],
    );
  }

  Widget _bannerItem(CommonModel model, double width) {
    return GestureDetector(
      child: Image.network(model.icon!, width: width, fit: BoxFit.fill),
      onTap: () {},
    );
  }

  Widget _indicator() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.bannerList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () {
              _controller.animateToPage(entry.key);
            },
            child: Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Colors.white)
                      .withOpacity(entry.key == _currentIndex ? 0.9 : 0.4)),
            ),
          );
        }).toList());
  }
}

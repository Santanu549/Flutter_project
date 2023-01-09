import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/model/dashboard/DashboardResponse.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';

class BannerSliderViewWidget extends StatefulWidget {
  final List<BannerImg>? bannerList;

  BannerSliderViewWidget({this.bannerList});

  @override
  _BannerSliderViewWidgetState createState() => _BannerSliderViewWidgetState();
}

class _BannerSliderViewWidgetState extends State<BannerSliderViewWidget> with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _nextPage;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _pageController = PageController(initialPage: 0);
    _animationController = new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        int page = widget.bannerList!.length;
        if (_currentPage < page - 1) {
          _currentPage++;
          _pageController.animateToPage(_currentPage, duration: Duration(seconds: 2), curve: Curves.easeInOutSine);
        } else {
          _currentPage = 0;
        }
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(); //Start controller with widget
    return Container(
      height: 250,
      width: context.width(),
      child: PageView.builder(
        itemCount: widget.bannerList!.length,
        controller: _pageController,
        onPageChanged: (value) {
          _animationController.forward();
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: commonCacheImage(widget.bannerList![index].image, fit: BoxFit.cover),
            color: Colors.red,
          );
        },
      ),
    );
  }
}

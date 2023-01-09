import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/screens/DashboardScreen.dart';
import 'package:pet_shop_flutter/utils/AppColors.dart';
import 'package:pet_shop_flutter/utils/AppCommons.dart';
import 'package:pet_shop_flutter/utils/AppConstants.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController pageController = PageController();

  int currentPage = 0;

  List<WalkThroughModelClass> list = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    list.add(WalkThroughModelClass(title: 'Pet Deservers More Care', subTitle: 'we provide all services to treat your\n furry friend better', image: 'assets/ic_god.jpg'));
    list.add(WalkThroughModelClass(title: 'Find your New Friend', subTitle: 'don\'t have a pet yet? Find your favorite\n buddy and adopt him', image: 'assets/ic_god.jpg'));
    list.add(WalkThroughModelClass(title: 'All Pet Needs Are Here', subTitle: 'shop app pet needs right form your hand\n without have to leaving home', image: 'assets/ic_god.jpg'));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: list.map((e) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonCacheImage(e.image, fit: BoxFit.cover, height: 250, width: 250).cornerRadiusWithClipRRect(20),
                  50.height,
                  Text(e.title!, style: boldTextStyle(size: 22), textAlign: TextAlign.center),
                  8.height,
                  Text(e.subTitle!, style: secondaryTextStyle(), textAlign: TextAlign.center),
                ],
              );
            }).toList(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: DotIndicator(
              indicatorColor: primaryColor,
              pageController: pageController,
              pages: list,
              unselectedIndicatorColor: grey,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: AppButton(
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(10)),
              padding: EdgeInsets.all(12),
              text: currentPage != 2 ? 'Next' : 'Continue',
              textStyle: boldTextStyle(color: Colors.white),
              color: primaryColor,
              margin: EdgeInsets.symmetric(horizontal: 16),
              onTap: () async {
                if (currentPage == 2) {
                  await setValue(IS_FIRST_TIME, false);
                  DashboardScreen().launch(context);
                } else {
                  pageController.animateToPage(currentPage + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

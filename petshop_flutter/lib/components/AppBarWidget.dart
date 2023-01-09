import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';

class AppBarWidget extends StatefulWidget {
  static String tag = '/AppBarWidget';
  final Widget? title;
  final ScrollController? scrollController;
  final double? appBarHeight;

  AppBarWidget({this.title, this.scrollController, this.appBarHeight});

  @override
  AppBarWidgetState createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    _animationController = AnimationController(
      duration: Duration(seconds: 10),
      value: 1.0,
      vsync: this,
      reverseDuration: Duration(seconds: 10),
    );
    offsetAnimation = new Tween<Offset>(
      begin: Offset(0.0, widget.appBarHeight ?? -kToolbarHeight + 4),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    widget.scrollController!.addListener(() {
      if (widget.scrollController!.position.userScrollDirection == ScrollDirection.forward) {
        _animationController.forward();
      } else if (widget.scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
        _animationController.reverse();
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offsetAnimation,
      child: Container(
        width: context.width(),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: context.cardColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 3)],
        ),
        child: widget.title,
      ).fit(),
    );
  }
}

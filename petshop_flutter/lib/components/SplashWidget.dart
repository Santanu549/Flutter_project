import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashWidget extends StatefulWidget {
  final String? imagePath;
  final double imageSize;

  final String? appName;
  final TextStyle? textStyle;

  final String? appVersion;

  final Widget? imageWidget;
  final Widget? nameWidget;

  final AnimationController? animationController;
  final Animation<double>? animation;
  final Curve curve;

  final Duration? animationDuration;
  final VoidCallback? onAnimationEnd;

  bool enableAnimation;

  SplashWidget({
    this.imagePath,
    this.imageSize = 130.0,
    this.appName,
    this.animationController,
    this.animation,
    this.curve = Curves.linear,
    this.textStyle,
    this.appVersion,
    this.imageWidget,
    this.nameWidget,
    this.animationDuration,
    this.onAnimationEnd,
    this.enableAnimation = true,
  });

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = widget.animationController ?? AnimationController(vsync: this, duration: widget.animationDuration ?? 1.seconds);
    animation = widget.animation ?? CurvedAnimation(parent: animationController, curve: widget.curve);
    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        widget.onAnimationEnd?.call();
      }
    });

    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  @override
  void dispose() {
    animationController.removeListener(() {});
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildImageWidget() {
      if (widget.imagePath.validate().isNotEmpty) {
        if (widget.imagePath!.startsWith('http')) {
          return Image.network(widget.imagePath.validate(), width: widget.imageSize, height: widget.imageSize, fit: BoxFit.cover);
        } else {
          return Image.asset(widget.imagePath.validate(), width: widget.imageSize, height: widget.imageSize, fit: BoxFit.cover);
        }
      } else {
        return SizedBox();
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Offstage(),
        Column(
          children: [
            widget.enableAnimation ? ScaleTransition(scale: animation, child: widget.imageWidget ?? _buildImageWidget()) : widget.imageWidget ?? _buildImageWidget(),
            16.height,
            widget.nameWidget ?? (widget.appName.validate().isNotEmpty ? Text(widget.appName!, style: widget.textStyle ?? boldTextStyle(size: 24)) : Offstage()),
          ],
        ),
        widget.appVersion.validate().isNotEmpty ? Text(widget.appVersion!, style: secondaryTextStyle()) : Offstage(),
      ],
    ).center().paddingOnly(bottom: 16);
  }
}

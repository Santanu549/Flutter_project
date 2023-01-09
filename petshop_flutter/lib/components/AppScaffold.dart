import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pet_shop_flutter/main.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  AppScaffold({
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: appBar,
        body: Stack(
          children: [
            if (body != null) body!,
            if (!appStore.isNetworkConnected)
              SafeArea(
                child: Container(
                  width: context.width(),
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/ic_no_connection.png', height: 20, color: Colors.white),
                      16.width,
                      Text(language!.noConnection, style: primaryTextStyle(color: Colors.white, size: 12), textAlign: TextAlign.center),
                    ],
                  ),
                  color: Colors.black,
                ),
              ),
          ],
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}

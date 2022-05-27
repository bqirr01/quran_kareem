import 'package:flutter/material.dart';
import 'package:myquran_app/animations/bottomAnimation.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final String text;
  LoadingShimmer({required this.text});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Color(0xFF5C956B),
      highlightColor: Color(0xFF5C956B),
      enabled: true,
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        padding: EdgeInsets.all(8.0),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WidgetAnimator(
                    Text("Loading $text..!", style: TextStyle(fontSize: height * 0.02)))
              ],
            )),
      ),
    );
  }
}

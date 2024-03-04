import 'package:flutter/material.dart';
import 'package:spotify_app/config/screen_size.dart';

class BackGroundScreen extends StatelessWidget {
  const BackGroundScreen({super.key, required this.firstColor, required this.secondColor, required this.children});
final Color firstColor;
final Color secondColor;
final List<Widget>children;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize.height(context),
      width: ScreenSize.width(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [firstColor,secondColor],
        begin: Alignment.topCenter,end:Alignment.bottomCenter  )
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

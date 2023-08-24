import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:testing/screens/entryPoint/entry_point.dart';

import '../../../model/menu.dart';
import 'animated_bar.dart';

class BtmNavItem extends StatelessWidget {
  BtmNavItem(
      {this.aseet,
       this.index,
      required this.navBar,
      required this.press,
      required this.riveOnInit,
      required this.selectedNav});
  var index ;
  final Menu navBar;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final Menu selectedNav;
  bool? aseet = true;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBar(isActive: selectedNav == navBar),
          SizedBox(
            height: 36,
            width: 36,
            child: Opacity(
              opacity: selectedNav == navBar ? 1 : 0.5,
              child: aseet == true
                  ? RiveAnimation.asset(
                      navBar.rive.src,
                      artboard: navBar.rive.artboard,
                      onInit: riveOnInit,
                    )
                  : SvgPicture.asset(
                      navBar.rive.src,
                      height: 40,
                      width: 80,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:testing/constants.dart';
import 'package:testing/screens/home/home_screen.dart';
import 'package:testing/utils/rive_utils.dart';

import '../../model/menu.dart';
import 'components/btm_nav_item.dart';
import 'components/menu_btn.dart';
import 'components/side_bar.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;
  var i;
  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColorLight,
      body: selectedBottonNav == bottomNavItems[0]
          ? Stack(
              children: [
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      snap: false,
                      pinned: false,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: const Text("H o m e",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ) //TextStyle
                              ), //Text
                          background: Image.asset(
                            'assets/Backgrounds/daylight-forest-glossy-443446.jpg',
                            fit: BoxFit.cover,
                          ) //Images.network
                          ), //FlexibleSpaceBar
                      expandedHeight: 100,
                      // backgroundColor: Colors.greenAccent[400],
                      // leading: IconButton(
                      //   icon: const Icon(Icons.menu),
                      //   tooltip: 'Menu',
                      //   onPressed: () {},
                      // ), //IconButton
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.comment),
                          tooltip: 'Comment Icon',
                          onPressed: () {},
                        ), //IconButton
                        IconButton(
                          icon: const Icon(Icons.settings),
                          tooltip: 'Setting Icon',
                          onPressed: () {},
                        ), //IconButton
                      ], //<Widget>[]
                    ),

                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          height: MediaQuery.of(context).size.height,
                          width: double.infinity,
                          child: Stack(children: [
                            AnimatedPositioned(
                              width: 288,
                              height: MediaQuery.of(context).size.height * .99,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn,
                              left: isSideBarOpen ? 0 : -288,
                              top: 0,
                              child: const SideBar(),
                            ),
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(1 * animation.value -
                                    30 * (animation.value) * pi / 180),
                              child: Transform.translate(
                                offset: Offset(animation.value * 265, 0),
                                child: Transform.scale(
                                  scale: scalAnimation.value,
                                  child: const ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(24),
                                    ),
                                    child: HomePage(),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastOutSlowIn,
                              left: isSideBarOpen ? 220 : 0,
                              top: 16,
                              child: MenuBtn(
                                press: () {
                                  isMenuOpenInput.value =
                                      !isMenuOpenInput.value;

                                  if (_animationController.value == 0) {
                                    _animationController.forward();
                                  } else {
                                    _animationController.reverse();
                                  }

                                  setState(
                                    () {
                                      isSideBarOpen = !isSideBarOpen;
                                    },
                                  );
                                },
                                riveOnInit: (artboard) {
                                  final controller =
                                      StateMachineController.fromArtboard(
                                          artboard, "State Machine");

                                  artboard.addController(controller!);

                                  isMenuOpenInput = controller
                                      .findInput<bool>("isOpen") as SMIBool;
                                  isMenuOpenInput.value = true;
                                },
                              ),
                            ),
                          ]),
                        ),
                        childCount: 1,
                      ), //SliverChildBuildDelegate
                    ) //SliverList
                  ], //<Widget>[]
                ),

                // Container(color: Colors.blueAccent,height: 250,
                // width: 500,)
              ],
            )
          : selectedBottonNav == bottomNavItems[1]
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.blue,
                      child: const Center(
                        child: Text("Search ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ) //TextStyle
                            ),
                      ),
                    ),
                  ],
                )
              : selectedBottonNav == bottomNavItems[2]
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.yellow,
                          child: const Center(
                            child: Text("Favorites",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ) //TextStyle
                                ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          color: Colors.deepOrange,
                          child: const Center(
                            child: Text("Chat",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0,
                                ) //TextStyle
                                ),
                          ),
                        ),
                      ],
                    ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
          child: Container(
            padding:
                const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor2.withOpacity(0.3),
                  offset: const Offset(0, 20),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavItems.length,
                  (index) {
                    Menu navBar = bottomNavItems[index];
                    i = index;
                    return BtmNavItem(
                      index: index,
                      aseet: true,
                      navBar: navBar,
                      press: () {
                        RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                        updateSelectedBtmNav(navBar);
                      },
                      riveOnInit: (artboard) {
                        navBar.rive.status = RiveUtils.getRiveInput(artboard,
                            stateMachineName: navBar.rive.stateMachineName);
                      },
                      selectedNav: selectedBottonNav,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

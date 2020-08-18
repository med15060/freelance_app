import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/utils/colors.dart';

class CustomBottomNavigation extends StatelessWidget {
  final List icons = [
    "Home",
    "fix_icon",
    "notification",
    "messages",
    "profile",
    "search"
  ];

  int currentIndex;
  Function onTab;
  CustomBottomNavigation({this.currentIndex, this.onTab});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(color: background, boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, -3), blurRadius: 3)
          ]),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  6,
                  (index) => _Item(
                        icon: icons[index],
                        isActive: index == currentIndex,
                        index: index,
                        onTab: onTab,
                      )))),
    );
  }
}

class _Item extends StatelessWidget {
  final String icon;
  final bool isActive;
  final int index;
  final Function onTab;
  const _Item({
    Key key,
    this.icon,
    this.isActive,
    this.index,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTab(index),
      child: Container(
        child: SvgPicture.asset(
          'assets/images/$icon.svg',
          color: isActive ? primary : primary.withOpacity(0.4),
        ),
      ),
    );
  }
}

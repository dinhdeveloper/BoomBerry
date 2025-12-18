import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remindbless/core/app_assets.dart';

Widget bottomBarDetail({VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -1))],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30,left: 15, right: 15),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(Assets.iconBrowser, width: 30, height: 30, color: Colors.white,),
              SvgPicture.asset(Assets.iconBackAppbar, width: 35, height: 35),
              SvgPicture.asset(Assets.iconBrowser, width: 29, height: 29, color: Colors.white),
            ],
          )
        ),
      ),
    ),
  );
}

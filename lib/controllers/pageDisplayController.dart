import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:get/get.dart';

class PageDisplayController extends GetxController {
  static PageDisplayController instance = Get.find();

  Rx<Widget> pageDisplay = HomeScreen().obs;
  RxInt i = 0.obs;
  int get count => i.value;
  Widget get onPageDisplay => pageDisplay.value;

  add() => i++;
  updatePageDisplay(Widget widget) => pageDisplay = widget.obs;
}

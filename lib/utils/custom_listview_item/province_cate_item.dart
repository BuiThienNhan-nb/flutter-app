import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:get/get.dart';

class ProvinceItem extends StatefulWidget {
  final Province province;
  final Function function;
  const ProvinceItem({
    Key? key,
    required this.province,
    required this.function,
  }) : super(key: key);

  @override
  _ProvinceItemState createState() => _ProvinceItemState();
}

class _ProvinceItemState extends State<ProvinceItem> {
  @override
  Widget build(BuildContext context) {
    destinationController
        .updateSelectedProvince(destinationController.provinceSelectedId.value);
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
        left: 15,
      ),
      child: InkWell(
        // onTap: () => widget.function(widget.province.uid),
        splashColor: Palette.myLightGrey,
        // splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: Obx(
            () => Column(
              children: [
                Text(
                  widget.province.name != ''
                      ? '${widget.province.name}'
                      : 'Null',
                  style: TextStyle(
                    color: widget.province.uid ==
                            destinationController.provinceSelectedId.value
                        ? Palette.orange
                        : Colors.black,
                  ),
                ),
                Icon(
                  Icons.brightness_1,
                  color: widget.province.uid ==
                          destinationController.provinceSelectedId.value
                      ? Palette.orange
                      : Colors.black,
                  size: 7,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

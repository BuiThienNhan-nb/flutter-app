import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:get/get.dart';

class ProvinceRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Province>> provinceStream() {
    return _db
        .collection('provinces')
        // .orderBy('name')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Province> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Province.fromJson(element));
      });
      destinationController.provinceSelectedId = list[0].uid.obs;
      return list;
    });
  }
}

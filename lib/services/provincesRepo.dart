import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/provinces.dart';

class ProvinceRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Province>> provinceStream() {
    return _db
        .collection('provinces')
        .orderBy('name', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Province> list = [];
      query.docs.forEach((element) {
        //add data
        list.add(Province.fromJson(element));
      });
      return list;
    });
  }
}

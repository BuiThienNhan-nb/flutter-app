import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  static CommentController instance = Get.find();
  RxList<String> _key = <String>[].obs;
  RxList<String> _comment = <String>[].obs;

  List<String> get keys => _key.value.toSet().toList();
  List<String> get comments => _comment.value.toSet().toList();

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  // @override
  // Future<void> onInit() async {
  //   await getListKets();
  //   super.onInit();
  // }

  Future<void> getListKeys() async {
    _key = <String>[].obs;
    _comment = <String>[].obs;
    await databaseReference
        .child('keys/${UserRepo.customer.uid}')
        .orderByChild('key')
        .onChildAdded
        .forEach(
      (element) async {
        //if (!_key.value.contains(element.snapshot.value['key'])) {
        _key.add(element.snapshot.value['key']);
        //}
        await getListComments(element.snapshot.value['key']);
      },
    );
  }

  // Stream<List<String>> listKeyStream() {
  //   List<String> keyStream = [];
  //   return databaseReference
  //       .child('keys/${UserRepo.customer.uid}')
  //       .orderByChild('key')
  //       .onChildAdded
  //       .asyncMap(
  //     (event) {
  //       return keyStream;
  //     },
  //   );
  // }

  Future<void> getListComments(String key) async {
    await databaseReference
        .child('comments/${UserRepo.customer.uid}/$key')
        .once()
        .then(
      (value) {
        if (value.exists &&
            !_comment.value.contains(value.value['destination'])) {
          _comment.add(value.value['destination']);
        }
      },
    );
  }
}

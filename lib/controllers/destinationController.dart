import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:flutter_app/services/provincesRepo.dart';
import 'package:get/get.dart';

class DestinationController extends GetxController {
  static DestinationController instance = Get.find();

  RxList<Province> listProvince = <Province>[].obs;
  RxList<Destination> listDestination = <Destination>[].obs;
  Rx<bool> isLoading = false.obs;

  List<Province> get listProvinces => listProvince.value;
  List<Destination> get listDestinations => listDestination.value;

  @override
  void onInit() async {
    super.onInit();
    listProvince.bindStream(ProvinceRepo().provinceStream());
    listDestination.bindStream(DestinationRepo().destinationStream());
  }

  Future<void> fetchDestinations() async {
    // return listDestination.bindStream(DestinationRepo().destinationStream());
    return listProvince.bindStream(ProvinceRepo().provinceStream());
  }
}

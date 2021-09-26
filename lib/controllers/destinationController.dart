import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:flutter_app/screens/home/destination_detail/destination_detail.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:flutter_app/services/provincesRepo.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';

class DestinationController extends GetxController {
  static DestinationController instance = Get.find();

  RxList<Province> listProvince = <Province>[].obs;
  RxList<Destination> listDestination = <Destination>[].obs;
  RxString provinceSelectedId = ''.obs;
  RxList<Destination> listDestinationByProvince = <Destination>[].obs;
  RxList<Destination> listFavDestination = <Destination>[].obs;

  List<Province> get listProvinces => listProvince.value;
  List<Destination> get listDestinations => listDestination.value;
  List<Destination> get listDestinationsByProvince =>
      listDestinationByProvince.value;
  List<Destination> get listFavDestinations => listFavDestination.value;

  @override
  void onInit() {
    super.onInit();

    listProvince.bindStream(ProvinceRepo().provinceStream());
    listDestination.bindStream(DestinationRepo().destinationStream());
    listDestinationByProvince.bindStream(DestinationRepo()
        .destinationByProvinceStream(provinceSelectedId.value));

    // ever(UserRepo.customer.favoriteDes.obs, loadFavDes);
    // ever(listProvince, initDestinationByProvince);
    // ever(provinceSelectedId, updateDestinationByProvince);
    // ever(provinceSelectedId, fetchDestinationByProvince);
    // listDestinationByProvince.bindStream(DestinationRepo()
    //     .destinationByProvinceStream(provinceSelectedId.value));
  }

  initDestinationByProvince(List<Province> list) {
    provinceSelectedId = list[0].uid.obs;
    listDestinationByProvince
        .bindStream(DestinationRepo().destinationByProvinceStream(list[0].uid));
  }

  // void loadFavDes(List<String>? uids) {
  //   listFavDestination = <Destination>[].obs;
  //   listDestinations.forEach((element) {
  //     if (uids!.contains(element.uid)) listFavDestinations.add(element);
  //   });
  // }

  void navigateToDesDetail(Destination destination, tag) {
    Get.to(() => DestinationDetail(destination: destination, tag: tag));
  }

  void updateSelectedProvince(String id) {
    provinceSelectedId = id.obs;
    listDestinationByProvince
        .bindStream(DestinationRepo().destinationByProvinceStream(id));
    update();
  }

  // fetchDestinationByProvince(String id) {
  //   listDestinationByProvince
  //       .bindStream(DestinationRepo().destinationByProvinceStream(id));
  // }
}

import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:flutter_app/screens/home/destination_detail/destination_detail.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:flutter_app/services/postRepo.dart';
import 'package:flutter_app/services/provincesRepo.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';

class DestinationController extends GetxController {
  static DestinationController instance = Get.find();

  RxList<Province> _listProvince = <Province>[].obs;
  RxList<Destination> listDestination = <Destination>[].obs;
  RxString provinceSelectedId = ''.obs;
  RxList<Destination> listDestinationByProvince = <Destination>[].obs;
  RxList<Destination> listFavDestination = <Destination>[].obs;
  RxList<Post> _listPost = <Post>[].obs;

  List<Province> get listProvinces => _listProvince.value;
  List<Destination> get listDestinations => listDestination.value;
  List<Destination> get listDestinationsByProvince =>
      listDestinationByProvince.value;
  List<Destination> get listFavDestinations => listFavDestination.value;
  List<Post> get listPosts => _listPost.value;

  @override
  void onInit() {
    super.onInit();

    _listProvince.bindStream(ProvinceRepo().provinceStream());
    listDestination.bindStream(DestinationRepo().destinationStream());
    listDestinationByProvince.bindStream(DestinationRepo()
        .destinationByProvinceStream(provinceSelectedId.value));
    _listPost.bindStream(PostRepo().postStream());
  }

  initDestinationByProvince(List<Province> list) {
    provinceSelectedId = list[0].uid.obs;
    listDestinationByProvince
        .bindStream(DestinationRepo().destinationByProvinceStream(list[0].uid));
  }

  void navigateToDesDetail(Destination destination, tag) {
    Get.to(() => DestinationDetail(destination: destination, tag: tag));
  }

  void updateSelectedProvince(String id) {
    provinceSelectedId = id.obs;
    listDestinationByProvince
        .bindStream(DestinationRepo().destinationByProvinceStream(id));
    update();
  }

  void fetchEntirePost() {
    _listPost.forEach((element) {
      element.customer.bindStream(
          UserRepo().customerByIdStream(element.customer.value.uid));
      element.destination.bindStream(DestinationRepo()
          .destinationByIdStream(element.destination.value.uid));
    });
    update();
  }

  void fetchEntireSpecificPost(Post post) {
    post.customer
        .bindStream(UserRepo().customerByIdStream(post.customer.value.uid));
    post.destination.bindStream(
        DestinationRepo().destinationByIdStream(post.destination.value.uid));
    update();
  }

  void fetchPost() async {
    await PostRepo().fetchPost().then((value) => _listPost = value.obs);
  }
}

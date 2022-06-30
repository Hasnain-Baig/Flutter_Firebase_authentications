import 'package:get/get.dart';

class HomeController extends GetxController {
  Map _user = {};
  Map get user => _user;

  setUser(uid, name, email) {
    _user['uid'] = uid;
    _user['name'] = name;
    _user['email'] = email;
    update();
  }

  logout() {
    Get.back();
    _user = {};
    update();
  }
}

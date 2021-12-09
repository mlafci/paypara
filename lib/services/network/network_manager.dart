import 'package:paypara/services/network/network_service.dart';

class NetworkManager {
  static NetworkManager _instance;
  static NetworkManager get instance {
    if (_instance == null) _instance = NetworkManager._init();
    return _instance;
  }

  NetworkManager._init();

  Future login(dynamic data) async {
    return await NetworkService.requsetPost(
      path: "/accounts/login",
      data: data,
    );
  }

  Future register(dynamic data) async {
    return await NetworkService.requsetPost(
      path: "/accounts/register",
      data: data,
    );
  }

  Future searchUser(dynamic data) async {
    return await NetworkService.requsetGet(
      path: "/user/searchByUserName/$data",
    );
  }

  Future addGroup(dynamic data) async {
    return await NetworkService.requsetPost(
      path: "/groups",
      data: data,
    );
  }
}

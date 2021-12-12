import 'package:paypara/core/constants/enums/base_url_enum.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/network/network_service.dart';
import 'base_network.dart';

class NetworkManager extends BaseService {
  static NetworkManager _instance;
  static NetworkManager get instance {
    if (_instance == null) _instance = NetworkManager._init();
    return _instance;
  }

  NetworkManager._init();

  // TODO Değişicek
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

  Future<Group> addGroup({dynamic data}) async {
    return await post<Group>(
      baseUrl: BaseURL.URL,
      path: "/groups",
      model: Group(),
      data: data,
    );
  }

  Future<User> getSearchUser({dynamic data}) async {
    return await get<User>(
      baseUrl: BaseURL.URL,
      path: '/user/searchByUserName/$data',
      model: User(),
    );
  }
}

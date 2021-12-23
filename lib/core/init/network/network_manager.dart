import 'package:paypara/core/constants/enums/base_url_enum.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/network/network_service.dart';
import 'base_network.dart';
import 'package:paypara/models/expense/expense.dart';

class NetworkManager extends BaseService {
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

  Future updateProfile(dynamic data) async {
    return await NetworkService.requsetPut(
      path: "/user/UserProfileByUserId",
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

  Future<Group> getGroup({dynamic data}) async {
    return await get<Group>(
      baseUrl: BaseURL.URL,
      path: "/groups/GetUserGroupsWithDetail/${data}",
      model: Group(),
    );
  }

  Future<Group> deleteGroupFromUser({dynamic data}) async {
    return await delete<Group>(
      baseUrl: BaseURL.URL,
      path: "/groups/DeleteUserInGroupByUserId",
      data: data,
      model: Group(),
    );
  }

  Future<User> getSearchUser({dynamic data}) async {
    return await get<User>(
      baseUrl: BaseURL.URL,
      path: '/user/searchByUserName/$data',
      model: User(),
    );
  }

  Future<Expense> getExpenses({dynamic data}) async {
    return await get<Expense>(
      baseUrl: BaseURL.URL,
      path: '/groups/GetExpensesByGroupId',
      model: Expense(),
      data: data,
    );
  }

  Future<Expense> addExpense({dynamic data}) async {
    return await post<Expense>(
      baseUrl: BaseURL.URL,
      path: '/expenses',
      model: Expense(),
      data: data,
    );
  }

  Future<Expense> profileStatus({dynamic data}) async {
    return await get<User>(
      baseUrl: BaseURL.URL,
      path: '/user/UserProfileByUserId',
      model: User(),
      data: data,
    );
  }
}

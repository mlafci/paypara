import 'package:flutter/material.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/core/utils/date_util.dart';
import 'package:paypara/models/expense/expense.dart';

class ExpenseService {
  static ExpenseService _instance;
  static ExpenseService get instance {
    if (_instance == null) _instance = ExpenseService._init();
    return _instance;
  }

  ExpenseService._init();

  Expense expense = new Expense();

  Future addExpense({
    BuildContext context,
    int groupID,
    int categoryID,
    int price,
    String note,
    DateTime date,
  }) async {
    dynamic model = {
      "isActive": true,
      "userId": "034cdf65-25d9-4218-9881-08011c81de01",
      "groupId": groupID,
      "categoryId": categoryID,
      "price": price,
      "note": note,
      "date": "${date.toIso8601String()}",
    };
    await NetworkManager.instance.addExpense(data: model);
  }

  Future getExpenses({
    BuildContext context,
    int groupID,
  }) async {
    dynamic model = {
      "GroupId": "$groupID",
      "Date": "${DateTime.now()}",
    };
    expense = await NetworkManager.instance.getExpenses(data: model);
  }

  List<Result> getExpensesByDate(DateTime dateTime) {
    return ExpenseService.instance.expense.result.where((element) => element.date.compareDate(dateTime)).toList();
  }

  List<Result> getLastExpenses() {
    return ExpenseService.instance.expense.result.where((element) => !element.date.compareDate(DateTime.now())).toList();
  }
}
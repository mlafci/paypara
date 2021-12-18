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

  Expense lastExpenses = new Expense();

  Future getExpenses({
    BuildContext context,
    int groupID,
  }) async {
    dynamic model = {
      "GroupId": "$groupID",
      "Date": "${DateTime.now()}",
    };
    lastExpenses = await NetworkManager.instance.getLastExpense(data: model);
  }

  List<Result> getExpensesByDate(DateTime dateTime) {
    return ExpenseService.instance.lastExpenses.result.where((element) => element.date.compareDate(dateTime)).toList();
  }

  List<Result> getLastExpenses() {
    return ExpenseService.instance.lastExpenses.result.where((element) => !element.date.compareDate(DateTime.now())).toList();
  }
}

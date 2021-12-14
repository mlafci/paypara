import 'package:flutter/material.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/models/expense/expense.dart';

class ExpenseService {
  static ExpenseService _instance;
  static ExpenseService get instance {
    if (_instance == null) _instance = ExpenseService._init();
    return _instance;
  }

  ExpenseService._init();

  Expense lastExpenses = new Expense();

  Future getLastExpense({
    BuildContext context,
    int groupID,
  }) async {
    dynamic model = {
      "GroupId": "$groupID",
      "Date": "${DateTime.now()}",
    };
    lastExpenses = await NetworkManager.instance.getLastExpense(data: model);
  }
}
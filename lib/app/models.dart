import 'package:flutter/material.dart';

/// A data model for an account.
class AccountData {
  final String id;
  final String name;
  final double primaryAmount;
  final String accountNumber;
  final String bankName;

  const AccountData(
      {this.id,
      this.name,
      this.primaryAmount,
      this.accountNumber,
      this.bankName});
}

/// A data model for a bill.
class BillData {
  final String id;
  final String name;
  final double primaryAmount;
  final String accountNumber;
  final String bankName;

  /// The due date of this bill.
  final String dueDate;

  /// If this bill has been paid.
  final bool isPaid;

  const BillData({
    this.id,
    this.name,
    this.primaryAmount,
    this.accountNumber,
    this.bankName,
    this.dueDate,
    this.isPaid = false,
  });
}

/// A data model for a Transaction
class TransactionData {
  final String id;
  final String description;
  final DateTime date;
  final double amount;
  final String accountId;
  final String categoryId;

  const TransactionData({
    this.id,
    this.description,
    this.date,
    this.amount,
    this.accountId,
    this.categoryId
});
}

/// A data model for Category.
class CategoryData {
  final String id;
  final String name;

  const CategoryData({
    this.id,
    this.name
  });
}

/// A data model for a budget.
///
/// The [primaryAmount] is the budget cap in USD.
class BudgetData {
  const BudgetData({this.name, this.primaryAmount, this.amountUsed});

  /// The display name of this entity.
  final String name;

  /// The primary amount or value of this entity.
  final double primaryAmount;

  /// Amount of the budget that is consumed or used.
  final double amountUsed;
}


/// A data model for an alert.
class AlertData {

  /// The alert message to display.
  final String message;

  /// The icon to display with the alert.
  final IconData iconData;

  AlertData({this.message, this.iconData});
}

class DetailedEventData {
  const DetailedEventData({
    this.title,
    this.date,
    this.amount,
  });

  final String title;
  final DateTime date;
  final double amount;
}

/// A data model for data displayed to the user.
class UserDetailData {
  UserDetailData({this.title, this.value});

  /// The display name of this entity.
  final String title;

  /// The value of this entity.
  final String value;
}

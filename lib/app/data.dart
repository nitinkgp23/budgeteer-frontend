// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../l10n/gallery_localizations.dart';
import 'formatters.dart';
import 'models.dart';

/// Calculates the sum of the primary amounts of a list of [AccountData].
double sumAccountDataPrimaryAmount(List<AccountData> items) =>
    sumOf<AccountData>(items, (item) => item.primaryAmount);

/// Calculates the sum of the primary amounts of a list of [BillData].
double sumBillDataPrimaryAmount(List<BillData> items) =>
    sumOf<BillData>(items, (item) => item.primaryAmount);

/// Calculates the sum of the primary amounts of a list of [BillData].
double sumBillDataPaidAmount(List<BillData> items) => sumOf<BillData>(
      items.where((item) => item.isPaid).toList(),
      (item) => item.primaryAmount,
    );

/// Calculates the sum of the primary amounts of a list of [BudgetData].
double sumBudgetDataPrimaryAmount(List<BudgetData> items) =>
    sumOf<BudgetData>(items, (item) => item.primaryAmount);

/// Calculates the sum of the amounts used of a list of [BudgetData].
double sumBudgetDataAmountUsed(List<BudgetData> items) =>
    sumOf<BudgetData>(items, (item) => item.amountUsed);

/// Utility function to sum up values in a list.
double sumOf<T>(List<T> list, double Function(T elt) getValue) {
  var sum = 0.0;
  for (var elt in list) {
    sum += getValue(elt);
  }
  return sum;
}

/// Class to return dummy data lists.
///
/// In a real app, this might be replaced with some asynchronous service.
class DummyDataService {
  static List<TransactionData> getTransactionDataList(BuildContext context) {
    return <TransactionData>[
      TransactionData(
        description: 'Phone back cover',
        date: DateTime.utc(2020, 7, 18),
        amount: 250.0,
        categoryId: 'Electronics',
      ),
      TransactionData(
        description: 'Books',
        date: DateTime.utc(2020, 7, 10),
        amount: 700,
        categoryId: 'Books',
      ),
      TransactionData(
        description: 'Dinner',
        date: DateTime.utc(2020, 7, 9),
        amount: 400,
        categoryId: 'Restaurant',
      ),
      TransactionData(
        description: 'Paneer',
        date: DateTime.utc(2020, 7, 1),
        amount: 70,
        categoryId: 'Groceries',
      ),
      TransactionData(
        description: 'Shampoo',
        date: DateTime.utc(2020, 6, 26),
        amount: 400,
        categoryId: 'Groceries',
      ),
      TransactionData(
        description: 'Chicken',
        date: DateTime.utc(2020, 6, 22),
        amount: 200,
        categoryId: 'Groceries',
      ),
      TransactionData(
        description: 'Laptop repair',
        date: DateTime.utc(2020, 6, 10),
        amount: 250,
        categoryId: 'Electronics',
      ),
      TransactionData(
        description: 'Shoes',
        date: DateTime.utc(2020, 7, 10),
        amount: 2250,
        categoryId: 'Garments',
      ),
    ];
  }

  static List<AccountData> getAccountDataList(BuildContext context) {
    return <AccountData>[
      AccountData(
        name: GalleryLocalizations.of(context).rallyAccountDataChecking,
        primaryAmount: 221125.13,
        accountNumber: '1234561234',
      ),
      AccountData(
        name: GalleryLocalizations.of(context).rallyAccountDataHomeSavings,
        primaryAmount: 25450.88,
        accountNumber: '8888885678',
      ),
      AccountData(
        name: GalleryLocalizations.of(context).rallyAccountDataCarSavings,
        primaryAmount: 987.48,
        accountNumber: '8888889012',
      ),
      AccountData(
        name: GalleryLocalizations.of(context).rallyAccountDataVacation,
        primaryAmount: 253,
        accountNumber: '1231233456',
      ),
      const AccountData(
        name: 'Splitwise',
        primaryAmount: 31000.13,
        accountNumber: '1234561234',
      ),
      const AccountData(
        name: 'SBI Savings',
        primaryAmount: 8678.88,
        accountNumber: '8888885678',
      ),
    ];
  }

  static List<UserDetailData> getAccountDetailList(BuildContext context) {
    return <UserDetailData>[
      UserDetailData(
        title: GalleryLocalizations.of(context)
            .rallyAccountDetailDataAnnualPercentageYield,
        value: percentFormat(context).format(0.001),
      ),
      UserDetailData(
        title:
            GalleryLocalizations.of(context).rallyAccountDetailDataInterestRate,
        value: rupeeWithSignFormat(context).format(1676.14),
      ),
      UserDetailData(
        title:
            GalleryLocalizations.of(context).rallyAccountDetailDataInterestYtd,
        value: rupeeWithSignFormat(context).format(81.45),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context)
            .rallyAccountDetailDataInterestPaidLastYear,
        value: rupeeWithSignFormat(context).format(987.12),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context)
            .rallyAccountDetailDataNextStatement,
        value: shortDateFormat(context).format(DateTime.utc(2019, 12, 25)),
      ),
      UserDetailData(
        title:
            GalleryLocalizations.of(context).rallyAccountDetailDataAccountOwner,
        value: 'Philip Cao',
      ),
    ];
  }

  static List<DetailedEventData> getDetailedEventItems() {
    // The following titles are not localized as they're product/brand names.
    return <DetailedEventData>[
      DetailedEventData(
        title: 'Genoe',
        date: DateTime.utc(2019, 1, 24),
        amount: -16.54,
      ),
      DetailedEventData(
        title: 'Fortnightly Subscribe',
        date: DateTime.utc(2019, 1, 5),
        amount: -12.54,
      ),
      DetailedEventData(
        title: 'Circle Cash',
        date: DateTime.utc(2019, 1, 5),
        amount: 365.65,
      ),
      DetailedEventData(
        title: 'Crane Hospitality',
        date: DateTime.utc(2019, 1, 4),
        amount: -705.13,
      ),
      DetailedEventData(
        title: 'ABC Payroll',
        date: DateTime.utc(2018, 12, 15),
        amount: 1141.43,
      ),
      DetailedEventData(
        title: 'Shrine',
        date: DateTime.utc(2018, 12, 15),
        amount: -88.88,
      ),
      DetailedEventData(
        title: 'Foodmates',
        date: DateTime.utc(2018, 12, 4),
        amount: -11.69,
      ),
    ];
  }

  static List<BillData> getBillDataList(BuildContext context) {
    // The following names are not localized as they're product/brand names.
    return <BillData>[
      BillData(
        name: 'RedPay Credit',
        primaryAmount: 45.36,
        dueDate: dateFormatAbbreviatedMonthDay(context)
            .format(DateTime.utc(2019, 1, 29)),
      ),
      BillData(
        name: 'Rent',
        primaryAmount: 1200,
        dueDate: dateFormatAbbreviatedMonthDay(context)
            .format(DateTime.utc(2019, 2, 9)),
        isPaid: true,
      ),
      BillData(
        name: 'TabFine Credit',
        primaryAmount: 87.33,
        dueDate: dateFormatAbbreviatedMonthDay(context)
            .format(DateTime.utc(2019, 2, 22)),
      ),
      BillData(
        name: 'ABC Loans',
        primaryAmount: 400,
        dueDate: dateFormatAbbreviatedMonthDay(context)
            .format(DateTime.utc(2019, 2, 29)),
      ),
    ];
  }

  static List<UserDetailData> getBillDetailList(BuildContext context,
      {double dueTotal, double paidTotal}) {
    return <UserDetailData>[
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBillDetailTotalAmount,
        value: rupeeWithSignFormat(context).format(paidTotal + dueTotal),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBillDetailAmountPaid,
        value: rupeeWithSignFormat(context).format(paidTotal),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBillDetailAmountDue,
        value: rupeeWithSignFormat(context).format(dueTotal),
      ),
    ];
  }

  static List<BudgetData> getBudgetDataList(BuildContext context) {
    return <BudgetData>[
      BudgetData(
        name: GalleryLocalizations.of(context).rallyBudgetCategoryCoffeeShops,
        primaryAmount: 70,
        amountUsed: 45.49,
      ),
      BudgetData(
        name: GalleryLocalizations.of(context).rallyBudgetCategoryGroceries,
        primaryAmount: 170,
        amountUsed: 16.45,
      ),
      BudgetData(
        name: GalleryLocalizations.of(context).rallyBudgetCategoryRestaurants,
        primaryAmount: 170,
        amountUsed: 123.25,
      ),
      BudgetData(
        name: GalleryLocalizations.of(context).rallyBudgetCategoryClothing,
        primaryAmount: 70,
        amountUsed: 19.45,
      ),
    ];
  }

  static List<UserDetailData> getBudgetDetailList(BuildContext context,
      {double capTotal, double usedTotal}) {
    return <UserDetailData>[
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBudgetDetailTotalCap,
        value: rupeeWithSignFormat(context).format(capTotal),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBudgetDetailAmountUsed,
        value: rupeeWithSignFormat(context).format(usedTotal),
      ),
      UserDetailData(
        title: GalleryLocalizations.of(context).rallyBudgetDetailAmountLeft,
        value: rupeeWithSignFormat(context).format(capTotal - usedTotal),
      ),
    ];
  }

  static List<String> getSettingsTitles(BuildContext context) {
    return <String>[
      GalleryLocalizations.of(context).rallySettingsManageAccounts,
      GalleryLocalizations.of(context).rallySettingsTaxDocuments,
      GalleryLocalizations.of(context).rallySettingsPasscodeAndTouchId,
      GalleryLocalizations.of(context).rallySettingsNotifications,
      GalleryLocalizations.of(context).rallySettingsPersonalInformation,
      GalleryLocalizations.of(context).rallySettingsPaperlessSettings,
      GalleryLocalizations.of(context).rallySettingsFindAtms,
      GalleryLocalizations.of(context).rallySettingsHelp,
      GalleryLocalizations.of(context).rallySettingsSignOut,
    ];
  }

  static List<AlertData> getAlerts(BuildContext context) {
    return <AlertData>[
      AlertData(
        message: GalleryLocalizations.of(context)
            .rallyAlertsMessageHeadsUpShopping(
                percentFormat(context, decimalDigits: 0).format(0.9)),
        iconData: Icons.sort,
      ),
      AlertData(
        message: GalleryLocalizations.of(context)
            .rallyAlertsMessageSpentOnRestaurants(
                rupeeWithSignFormat(context, decimalDigits: 0).format(120)),
        iconData: Icons.sort,
      ),
      AlertData(
        message: GalleryLocalizations.of(context).rallyAlertsMessageATMFees(
            rupeeWithSignFormat(context, decimalDigits: 0).format(24)),
        iconData: Icons.credit_card,
      ),
      AlertData(
        message: GalleryLocalizations.of(context)
            .rallyAlertsMessageCheckingAccount(
                percentFormat(context, decimalDigits: 0).format(0.04)),
        iconData: Icons.attach_money,
      ),
      AlertData(
        message: GalleryLocalizations.of(context)
            .rallyAlertsMessageUnassignedTransactions(16),
        iconData: Icons.not_interested,
      ),
    ];
  }
}

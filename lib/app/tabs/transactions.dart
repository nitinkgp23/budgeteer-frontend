// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/gallery_options.dart';
import '../../layout/letter_spacing.dart';
import '../../layout/text_scale.dart';
import '../colors.dart';
import '../data.dart';
import '../finance.dart';
import '../models.dart';
import 'sidebar.dart';

/// A page that shows a summary of accounts.
class TransactionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = DummyDataService.getTransactionDataList(context);
    final detailItems = <UserDetailData>[];

    return TabWithSidebar(
      mainView: TransactionFinancialEntityView(
        financialEntityCards: buildTransactionDataListViews(items, context),
      ),
      sidebarItems: [
        for (UserDetailData item in detailItems)
          SidebarItem(title: item.title, value: item.value)
      ],
    );
  }
}

class TransactionFinancialEntityView extends StatelessWidget {
  const TransactionFinancialEntityView({
    this.financialEntityCards,
  });

  /// The amounts to assign each item.
  final List<FinancialEntityCategoryView> financialEntityCards;

  @override
  Widget build(BuildContext context) {
    final maxWidth = pieChartMaxSize + (cappedTextScale(context) - 1.0) * 100.0;
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              // We decrease the max height to ensure the [RallyPieChart] does
              // not take up the full height when it is smaller than
              // [kPieChartMaxSize].
              maxHeight: math.min(
                constraints.biggest.shortestSide * 0.9,
                maxWidth,
              ),
            ),
            child: TransactionRallyPieChart(arccolor: RallyColors.budgetColor(3)),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            constraints: BoxConstraints(maxWidth: maxWidth),
            color: RallyColors.inputBackground,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: maxWidth),
            color: RallyColors.cardBackground,
            child: Column(
              children: financialEntityCards,
            ),
          ),
        ],
      );
    });
  }
}

/// A colored piece of the [TransactionRallyPieChart].
class TransactionRallyPieChartSegment {
  const TransactionRallyPieChartSegment({this.color, this.value});

  final Color color;
  final double value;
}

/// The max height and width of the [TransactionRallyPieChart].
const pieChartMaxSize = 500.0;

/// An animated circular pie chart to represent pieces of a whole, which can
/// have empty space.
class TransactionRallyPieChart extends StatefulWidget {
  const TransactionRallyPieChart(
      {this.arccolor});

    final Color arccolor;

  @override
  _TransactionRallyPieChartState createState() =>
      _TransactionRallyPieChartState();
}

class _TransactionRallyPieChartState extends State<TransactionRallyPieChart>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    animation = CurvedAnimation(
        parent: TweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0, end: 0),
            weight: 1,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0, end: 1),
            weight: 1.5,
          ),
        ]).animate(controller),
        curve: Curves.decelerate);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: _AnimatedTransactionRallyPieChart(
        animation: animation,
        arccolor: widget.arccolor
//        centerLabel: widget.heroLabel,
//        centerAmount: widget.heroAmount,
//        total: widget.wholeAmount,
//        segments: widget.segments,
      ),
    );
  }
}

class _AnimatedTransactionRallyPieChart extends AnimatedWidget {
  const _AnimatedTransactionRallyPieChart({
    Key key,
    this.animation,
//    this.centerLabel,
//    this.centerAmount,
//    this.total,
//    this.segments,
    this.arccolor
  }) : super(key: key, listenable: animation);

  final Animation<double> animation;
//  final String centerLabel;
//  final double centerAmount;
//  final double total;
//  final List<TransactionRallyPieChartSegment> segments;
  final Color arccolor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelTextStyle = textTheme.bodyText2.copyWith(
      fontSize: 14,
      letterSpacing: letterSpacingOrNone(0.5),
    );

    return LayoutBuilder(builder: (context, constraints) {
      // When the widget is larger, we increase the font size.
      var headlineStyle = constraints.maxHeight >= pieChartMaxSize
          ? textTheme.headline5.copyWith(fontSize: 70)
          : textTheme.headline5;

      // With a large text scale factor, we set a max font size.
      if (GalleryOptions.of(context).textScaleFactor(context) > 1.0) {
        headlineStyle = headlineStyle.copyWith(
          fontSize: (headlineStyle.fontSize / reducedTextScale(context)),
        );
      }

      return DecoratedBox(
        decoration: _TransactionRallyPieChartOutlineDecoration(
          maxFraction: animation.value,
          total: 1,
          segments: [TransactionRallyPieChartSegment(
            color: arccolor,
            value: 1,
          )],
        ),
        child: Container(
          height: constraints.maxHeight,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add_circle),
                iconSize: 70,
                color: RallyColors.gray,
//                splashColor: RallyColors.billColor(0),
                onPressed: (){},
//                style: labelTextStyle,
              ),

              IconButton(
                icon: const Icon(Icons.refresh),
                iconSize: 70,
                color: RallyColors.gray,
//                focusColor: RallyColors.billColor(0),
                onPressed: (){},
//                style: labelTextStyle,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _TransactionRallyPieChartOutlineDecoration extends Decoration {
  const _TransactionRallyPieChartOutlineDecoration(
      {this.maxFraction,
        this.total,
        this.segments
      });

  final double maxFraction;
  final double total;
  final List<TransactionRallyPieChartSegment> segments;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _TransactionRallyPieChartOutlineBoxPainter(
      maxFraction: maxFraction,
      wholeAmount: total,
      segments: segments,
    );
  }
}

class _TransactionRallyPieChartOutlineBoxPainter extends BoxPainter {
  _TransactionRallyPieChartOutlineBoxPainter(
      {this.maxFraction, this.wholeAmount, this.segments});

  final double maxFraction;
  final double wholeAmount;
  final List<TransactionRallyPieChartSegment> segments;
  static const double wholeRadians = 2 * math.pi;
  static const double spaceRadians = wholeRadians / 180;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Create two padded reacts to draw arcs in: one for colored arcs and one for
    // inner bg arc.
    const strokeWidth = 4.0;
    final outerRadius = math.min(
          configuration.size.width,
          configuration.size.height,
        ) /
        2;
    final outerRect = Rect.fromCircle(
      center: configuration.size.center(offset),
      radius: outerRadius - strokeWidth * 3,
    );
    final innerRect = Rect.fromCircle(
      center: configuration.size.center(offset),
      radius: outerRadius - strokeWidth * 4,
    );

    // Paint each arc with spacing.
    var cumulativeSpace = 0.0;
    var cumulativeTotal = 0.0;
    for (final segment in segments) {
      final paint = Paint()..color = segment.color;
      final startAngle = _calculateStartAngle(cumulativeTotal, cumulativeSpace);
      final sweepAngle = _calculateSweepAngle(segment.value, 0);
      canvas.drawArc(outerRect, startAngle, sweepAngle, true, paint);
      cumulativeTotal += segment.value;
      cumulativeSpace += spaceRadians;
    }

    // Paint any remaining space black (e.g. budget amount remaining).
    final remaining = wholeAmount - cumulativeTotal;
    if (remaining > 0) {
      final paint = Paint()..color = Colors.black;
      final startAngle =
          _calculateStartAngle(cumulativeTotal, spaceRadians * segments.length);
      final sweepAngle = _calculateSweepAngle(remaining, -spaceRadians);
      canvas.drawArc(outerRect, startAngle, sweepAngle, true, paint);
    }

    // Paint a smaller inner circle to cover the painted arcs, so they are
    // display as segments.
    final bgPaint = Paint()..color = RallyColors.primaryBackground;
    canvas.drawArc(innerRect, 0, 2 * math.pi, true, bgPaint);
  }

  double _calculateAngle(double amount, double offset) {
    final wholeMinusSpacesRadians =
        wholeRadians - (segments.length * spaceRadians);
    return maxFraction *
        (amount / wholeAmount * wholeMinusSpacesRadians + offset);
  }

  double _calculateStartAngle(double total, double offset) =>
      _calculateAngle(total, offset) - math.pi / 2;

  double _calculateSweepAngle(double total, double offset) =>
      _calculateAngle(total, offset);
}

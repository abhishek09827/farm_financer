import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart'; // For date formatting

class DailyExpense {
  final DateTime date;
  final double amount;
  final String type;  // "income" or "expense"

  DailyExpense(this.date, this.amount, this.type);
}
class ExpensePage extends StatelessWidget {
  final List<DailyExpense> expenses;

  ExpensePage({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Expanded(child: ExpenseBarChart(expenses: expenses)),
            Expanded(child: ExpenseLineChart(expenses: expenses)),
          ],
        ),
      ),
    );
  }
}

class ExpenseBarChart extends StatelessWidget {
  final List<DailyExpense> expenses;

  ExpenseBarChart({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SizedBox(
          height: 250,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            color: Colors.grey[900],
            child: BarChart(
              BarChartData(
                maxY: expenses[0].amount * 2,
                barGroups: getBarGroups(),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: SideTitles(
                    showTitles: true,
                    interval: 500,
                    margin: 5,
                    reservedSize: 50,
                    getTextStyles: (context, value) =>
                        TextStyle(color: Colors.cyanAccent[700]),
                    getTitles: (double value) {
                      return value.toInt().toString();
                    },
                  ),
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) =>
                        TextStyle(color: Colors.cyanAccent[700]),
                    getTitles: (double value) {
                      int index = value.toInt();
                      if (index >= 0 && index < expenses.length) {
                        return DateFormat('dd MMM').format(
                            expenses[index].date);
                      }
                      return '';
                    },
                  ),
                ),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey[700],
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          expenses[group.x.toInt()].type + '\n' + rod.y
                              .round()
                              .toString(),
                          TextStyle(color: Colors.white),
                        );
                      }
                  ),
                ),
                gridData: FlGridData(
                  drawHorizontalLine: true,
                  horizontalInterval: 500,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(
                        color: Colors.grey[800],
                        strokeWidth: 0.5,
                      ),
                ),
              ),
            ),
          ).p(24),
        ),
      ),
    );

// ... [Your existing BarChart widget code]
  }

  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    int barIndex = 0;

    expenses.forEach((expense) {
      barGroups.add(
        BarChartGroupData(
          x: barIndex,
          barRods: [
            BarChartRodData(
              y: expense.amount,
              colors: expense.type == "Income" ? [Colors.cyanAccent] : [Colors.redAccent[400]!],
            ),
          ],
        ),
      );
      barIndex++;
    });

    return barGroups;
  }
}

class ExpenseLineChart extends StatelessWidget {
  final List<DailyExpense> expenses;

  ExpenseLineChart({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        color: Colors.grey[900],
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 1,
              ),
            ),
            minX: 0,
            maxX: expenses.length.toDouble(),
            minY: 0,
            maxY: expenses.map((e) => e.amount).reduce((a, b) => a + b),
            lineBarsData: [
              // Line for Income
              LineChartBarData(
                spots: getIncomeSpots(),
                isCurved: true,
                colors: [Colors.blue],
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: true),
              ),
              // Line for Expense
              LineChartBarData(
                spots: getExpenseSpots(),
                isCurved: true,
                colors: [Colors.red],
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> getIncomeSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].type == "Income") {
        spots.add(FlSpot(i.toDouble(), expenses[i].amount));
      }
    }
    return spots;
  }

  List<FlSpot> getExpenseSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < expenses.length; i++) {
      if (expenses[i].type == "Expense") {
        spots.add(FlSpot(i.toDouble(), expenses[i].amount));
      }
    }
    return spots;
  }
}

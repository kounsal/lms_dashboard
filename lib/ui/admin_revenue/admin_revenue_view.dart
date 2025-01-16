import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lms_admin/ui/admin_revenue/revenue_controller.dart';

class AdminRevenueView extends StatefulWidget {
  @override
  _AdminRevenueViewState createState() => _AdminRevenueViewState();
}

class _AdminRevenueViewState extends State<AdminRevenueView> {
  final TransactionController _controller = TransactionController();
  late Future<List<double>> _monthlyRevenue;

  @override
  void initState() {
    super.initState();
    _monthlyRevenue = _controller.getMonthlyRevenue();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<double>>(
      future: _monthlyRevenue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        }

        final revenueData = snapshot.data!;

        return SizedBox(
          height: 300,
          // width: MediaQuery.of(context).size.width * 0.4,
          child: Container(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 25,
                      // showTitles: true,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        List<String> months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                        if (index >= 0 && index < months.length) {
                          return Text(months[index]);
                        }
                        return Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(revenueData.length, (index) {
                      return FlSpot(index.toDouble(), revenueData[index]);
                    }),
                    isCurved: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

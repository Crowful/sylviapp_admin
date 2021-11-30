import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({Key? key}) : super(key: key);

  @override
  _BarGraphState createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: <BarSeries<CampaignData, String>>[
          BarSeries<CampaignData, String>(
              // Bind data source
              dataSource: <CampaignData>[
                CampaignData('Jan', 35),
                CampaignData('Feb', 28),
                CampaignData('Mar', 34),
                CampaignData('Apr', 32),
                CampaignData('May', 40)
              ],
              xValueMapper: (CampaignData volunteers, _) => volunteers.year,
              yValueMapper: (CampaignData volunteers, _) =>
                  volunteers.volunteers)
        ]));
  }
}

class CampaignData {
  CampaignData(this.year, this.volunteers);
  final String year;
  final double volunteers;
}

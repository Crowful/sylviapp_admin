import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<CampaignData> _chartData;

  @override
  void initState() {
    _chartData = getCampaignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Campaign Analytics",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SfCircularChart(
            margin: const EdgeInsets.all(20),
            legend: Legend(
                isVisible: true,
                textStyle: const TextStyle(fontSize: 15),
                overflowMode: LegendItemOverflowMode.none,
                position: LegendPosition.right),
            series: <CircularSeries>[
              DoughnutSeries<CampaignData, String>(
                  dataSource: _chartData,
                  xValueMapper: (CampaignData data, _) => data.campaign,
                  yValueMapper: (CampaignData data, _) => data.status,
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside))
            ],
          ),
        ]);
  }

  List<CampaignData> getCampaignData() {
    final List<CampaignData> chartData = [
      CampaignData('Active', 25),
      CampaignData('Inactive', 10),
      CampaignData('Completed', 30),
    ];

    return chartData;
  }
}

class CampaignData {
  CampaignData(this.campaign, this.status);
  final String campaign;
  final int status;
}

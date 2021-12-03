import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<CampaignData> _chartData = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _chartData.clear();
    _chartData = getCampaignData();
  }

  @override
  Widget build(BuildContext context) {
    _chartData.clear();
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .where('inProgress', isEqualTo: true)
            .snapshots(),
        builder: (context, inProgressSnap) {
          if (inProgressSnap.hasData) {
            _chartData
                .add(CampaignData('In Progress', inProgressSnap.data!.size));
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('campaigns')
                    .where('isCompleted', isEqualTo: true)
                    .snapshots(),
                builder: (context, isDoneSnap) {
                  if (isDoneSnap.hasData) {
                    _chartData
                        .add(CampaignData('Is Done', isDoneSnap.data!.size));
                    return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('campaigns')
                            .where('isActive', isEqualTo: true)
                            .snapshots(),
                        builder: (context, isActiveSnap) {
                          if (isActiveSnap.hasData) {
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          _chartData.add(CampaignData(
                              'Is Active', isActiveSnap.data!.size));
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    "Campaign Analytics",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
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
                                        xValueMapper: (CampaignData data, _) =>
                                            data.campaign,
                                        yValueMapper: (CampaignData data, _) =>
                                            data.status,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true,
                                                labelPosition:
                                                    ChartDataLabelPosition
                                                        .inside))
                                  ],
                                ),
                              ]);
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  List<CampaignData> getCampaignData() {
    final List<CampaignData> chartData = [];

    return chartData;
  }
}

class CampaignData {
  CampaignData(this.campaign, this.status);
  final String campaign;
  final int status;
}

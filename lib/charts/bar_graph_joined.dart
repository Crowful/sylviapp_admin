import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';

class BarGraphJoined extends StatefulWidget {
  const BarGraphJoined({Key? key}) : super(key: key);

  @override
  _BarGraphJoinedState createState() => _BarGraphJoinedState();
}

class _BarGraphJoinedState extends State<BarGraphJoined> {
  late List<CampaignData> _chartData;
  int numJan = 0;
  int numFeb = 0;
  int numMar = 0;
  int numApr = 0;
  int numMay = 0;
  int numJun = 0;
  int numJul = 0;
  int numAug = 0;
  int numSep = 0;
  int numOct = 0;
  int numNov = 0;
  int numDec = 0;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('campaigns')
        .get()
        .then((value) => value.docs.forEach((element) {
              Timestamp value = element.get('date_created');
              DateTime convertedValue =
                  DateTime.parse(value.toDate().toString());

              if (convertedValue.month == 1) {
                setState(() {
                  numJan++;
                });
              }
              if (convertedValue.month == 2) {
                setState(() {
                  numFeb++;
                });
              }
              if (convertedValue.month == 3) {
                setState(() {
                  numMar++;
                });
              }
              if (convertedValue.month == 4) {
                setState(() {
                  numApr++;
                });
              }
              if (convertedValue.month == 5) {
                setState(() {
                  numMay++;
                });
              }
              if (convertedValue.month == 6) {
                setState(() {
                  numJun++;
                });
              }
              if (convertedValue.month == 7) {
                setState(() {
                  numJul++;
                });
              }
              if (convertedValue.month == 8) {
                setState(() {
                  numAug++;
                });
              }
              if (convertedValue.month == 9) {
                setState(() {
                  numSep++;
                });
              }
              if (convertedValue.month == 10) {
                setState(() {
                  numOct++;
                });
              }
              if (convertedValue.month == 11) {
                setState(() {
                  numNov++;
                });
              }
              if (convertedValue.month == 12) {
                setState(() {
                  numDec++;
                });
              }
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: <BarSeries<CampaignData, String>>[
          BarSeries<CampaignData, String>(
              // Bind data source
              dataSource: getCampaignData(),
              xValueMapper: (CampaignData volunteers, _) => volunteers.year,
              yValueMapper: (CampaignData volunteers, _) =>
                  volunteers.volunteers)
        ]));
  }

  List<CampaignData> getCampaignData() {
    final List<CampaignData> chartData = [
      CampaignData('Jan', numJan),
      CampaignData('Feb', numFeb),
      CampaignData('Mar', numMar),
      CampaignData('Apr', numApr),
      CampaignData('May', numMay),
      CampaignData('Jun', numJun),
      CampaignData('Jul', numJul),
      CampaignData('Aug', numAug),
      CampaignData('Sep', numSep),
      CampaignData('Oct', numOct),
      CampaignData('Nov', numNov),
      CampaignData('Dec', numDec),
    ];

    return chartData;
  }
}

class CampaignData {
  CampaignData(this.year, this.volunteers);
  final String year;
  final int volunteers;
}

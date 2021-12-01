import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:easy_localization/easy_localization.dart';

class BarGraphDonated extends StatefulWidget {
  const BarGraphDonated({Key? key}) : super(key: key);

  @override
  _BarGraphDonatedState createState() => _BarGraphDonatedState();
}

class _BarGraphDonatedState extends State<BarGraphDonated> {
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
        .collection('users')
        .doc()
        .collection('recent_activities')
        .where('type', isEqualTo: 'donated')
        .get()
        .then((value) => value.docs.forEach((element) {
              int amount =
                  element.get('amount') == null ? 0 : element.get('amount');
              print('test' + amount.toString());
              Timestamp valueDate = element.get('dateDonated');

              DateTime convertedValue =
                  DateTime.parse(valueDate.toDate().toString());

              if (convertedValue.month == 1) {
                setState(() {
                  numJan = numJan + amount;
                });
              }
              if (convertedValue.month == 2) {
                setState(() {
                  numFeb = numFeb + amount;
                });
              }
              if (convertedValue.month == 3) {
                setState(() {
                  numMar = numMar + amount;
                });
              }
              if (convertedValue.month == 4) {
                setState(() {
                  numApr = numApr + amount;
                });
              }
              if (convertedValue.month == 5) {
                setState(() {
                  numMay = numMay + amount;
                });
              }
              if (convertedValue.month == 6) {
                setState(() {
                  numJun = numJun + amount;
                });
              }
              if (convertedValue.month == 7) {
                setState(() {
                  numJul = numJul + amount;
                });
              }
              if (convertedValue.month == 8) {
                setState(() {
                  numAug = numAug + amount;
                });
              }
              if (convertedValue.month == 9) {
                setState(() {
                  numSep = numSep + amount;
                });
              }
              if (convertedValue.month == 10) {
                setState(() {
                  numOct = numOct + amount;
                });
              }
              if (convertedValue.month == 11) {
                setState(() {
                  numNov = numNov + amount;
                });
              }
              if (convertedValue.month == 12) {
                setState(() {
                  numDec = numDec + amount;
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

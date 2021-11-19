import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Text(
                'Feedbacks Of Users',
                style: TextStyle(
                    color: Color(0xff65BFB8),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('feedbacks')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Container(
                                height: 100,
                                width: 100,
                                child: CircularProgressIndicator()));
                      } else {
                        return SizedBox(
                            child: ListView.builder(
                                itemCount: snapshot.data!.size,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Card(
                                      elevation: 4,
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text("NAME OF THE VOLUNTEER"),
                                              Text("SENTENCE SENTENCE SENTENCE")
                                            ],
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  shape: StadiumBorder()),
                                              onPressed: () {},
                                              child: Text("Delete"))
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: unused_import
import 'package:sylviapp_admin/domain/aes_cryptography.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

// Collections Reference

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference campaignCollection =
      FirebaseFirestore.instance.collection('campaigns');

  final CollectionReference adminCampaignCollection =
      FirebaseFirestore.instance.collection('admin_campaign_requests');

  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection('feedbacks');

  final CollectionReference verificationCollection =
      FirebaseFirestore.instance.collection('verification');

  final CollectionReference polygonCollection =
      FirebaseFirestore.instance.collection('polygon');

//methods

//User
  Future addUserData(
    String email,
    String fullname,
    String address,
    String gender,
    String phoneNumber,
    String username,
  ) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'fullname': fullname,
      'address': address,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'username': username,
    });
  }

  Future deleteUserData() async {
    return await userCollection.doc(uid).delete();
  }

  Future deleteRequestCampaign(campaignID) async {
    return await adminCampaignCollection.doc(campaignID).delete();
  }

  Future deleteCampaign(campaignID) async {
    return await campaignCollection.doc(campaignID).delete();
  }

  Future updateUserData(
    String email,
    String fullname,
    String address,
  ) async {
    return await userCollection.doc(uid).update({
      'email': email,
      'fullname': fullname,
      'address': address,
    });
  }

  Future unVerifyUser(String userUID) async {
    return await userCollection
        .doc(userUID)
        .update({'isVerify': false, 'isApplying': false});
  }

  Future clearFeedback(String userUID) async {
    return await FirebaseFirestore.instance
        .collection('feedbacks')
        .doc(userUID)
        .delete();
  }

  Future verifyTheUser(String userUID) async {
    return await userCollection
        .doc(userUID)
        .update({'isApplying': false, 'isVerify': true}).whenComplete(
            () => Fluttertoast.showToast(msg: "Successfully verified"));
  }

  Future verify(String userUID) async {
    return await verificationCollection.doc(userUID).update({
      'verified': true,
    }).whenComplete(() => Fluttertoast.showToast(msg: "Verified"));
  }

//Campaign
  Future addCampaign(
      String title,
      String description,
      String campaignID,
      DateTime dateCreated,
      String dateStart,
      String dateEnded,
      String address,
      String city,
      String time,
      String userUID,
      String userName,
      double latitude,
      double longitude,
      int numSeeds,
      double currentDonations,
      double maxDonations,
      int currentVolunteers,
      int numberVolunteers,
      double radius,
      bool isActive,
      bool inProgress,
      bool isCompleted,
      String deviceTokenofOrganizer) async {
    return await campaignCollection.doc(campaignID).set({
      'campaignID': campaignID,
      'campaign_name': title,
      'description': description,
      'date_created': dateCreated,
      'date_start': dateStart,
      'date_ended': dateEnded,
      'address': address,
      'city': city,
      'time': time,
      'uid': userUID,
      'username': userName,
      'latitude': latitude,
      'longitude': longitude,
      'number_of_seeds': numSeeds,
      'current_donations': currentDonations,
      'max_donation': maxDonations,
      'current_volunteers': currentVolunteers,
      'number_volunteers': numberVolunteers,
      'radius': radius,
      'isActive': isActive,
      'inProgress': inProgress,
      'isCompleted': isCompleted,
      'deviceTokenofOrganizer': deviceTokenofOrganizer,
      'reportUIW': 0,
      'reportAbuse': 0,
      'reportScam': 0,
    });
  }

  Future saveVerification(
    String validIDUrl,
    String idNumber,
    String pictureURL,
    String reasonForApplication,
    String doHaveExperience,
  ) async {
    return await verificationCollection.doc(uid).set({
      'validIDUrl': validIDUrl,
      'idNumber': idNumber,
      'pictureURL': pictureURL,
      'reasonForApplication': reasonForApplication,
      'doHaveExperience': doHaveExperience,
    });
  }

  Future savePolygonLamesa(
    String forestname,
    points,
  ) async {
    return await polygonCollection
        .doc(forestname)
        .collection('polygons')
        .doc('1')
        .set({
      'points': points,
    });
  }
}

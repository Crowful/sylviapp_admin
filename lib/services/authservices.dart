// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Get Firestore instance
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Get Firestore Collection (USER)
// ignore: unused_element
final CollectionReference _firestoreUser = _firestore.collection('users');

class AuthService extends ChangeNotifier {
  //instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //getUI
  static String? userUid = FirebaseAuth.instance.currentUser!.uid;

  //loggedInUser
  late User? _loggedInUser;

  //Get Reference

  //UserChanges
  Stream<User?> get getauthStateChange {
    return _auth.authStateChanges();
  }

  Future<bool> get userVerified async {
    await _auth.currentUser!.reload();
    return _auth.currentUser!.emailVerified;
  }

  //getters

  User? get getUser {
    _loggedInUser = getauthStateChange as User;

    return _loggedInUser;
  }

  String getCurrentUserUID() {
    var currentUser = _auth.currentUser;

    if (currentUser == null) {
      return "No user";
    } else {
      return currentUser.uid.toString();
    }
  }

  String getCurrentUserDisplayName() {
    var currentUser = _auth.currentUser;
    return currentUser!.displayName.toString();
  }

  //Service Methods

  Future signIn(String email, String password) async {
    try {
      final signedInUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _loggedInUser = signedInUser.user!;
    }
    // ignore: unused_catch_clause
    on FirebaseAuthException catch (e) {
    }
    // ignore: unused_catch_clause
    on PlatformException catch (e) {}
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    }
    // ignore: unused_catch_clause
    on FirebaseAuthException catch (e) {
    }
    // ignore: unused_catch_clause
    on PlatformException catch (e) {}
  }

  Future signUp(String email, String password, String fullname, String address,
      String gender, String phoneNumber, String username) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _loggedInUser = newUser.user!;
      _loggedInUser!.sendEmailVerification();

      await DatabaseService(uid: _loggedInUser!.uid)
          .addUserData(email, fullname, address, gender, phoneNumber, username);
    }
    // ignore: unused_catch_clause
    on FirebaseAuthException catch (e) {
    }
    // ignore: unused_catch_clause
    on PlatformException catch (e) {}
  }

  Future resetPass(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .whenComplete(() => print("Successully Sent"));
    }
    // ignore: unused_catch_clause
    on FirebaseAuthException catch (e) {
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  Future deleteAcc() async {
    try {
      await DatabaseService(uid: _loggedInUser!.uid)
          .deleteUserData()
          .whenComplete(() => _loggedInUser!.delete());
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      // ignore: unused_catch_clause
    } on PlatformException catch (e) {}
  }

  Future updateAcc(
      String newFullName, String newAddress, String newEmail) async {
    try {
      await _loggedInUser!.updateEmail(newEmail);
      await DatabaseService(uid: _loggedInUser!.uid)
          .updateUserData(newEmail, newFullName, newAddress);
    } catch (e) {}
  }

  Future updatePassword(String newpass) async {
    try {
      await _loggedInUser!.updatePassword(newpass).whenComplete(
          () => Fluttertoast.showToast(msg: "Password Sucessfully Changed"));
      // ignore: empty_catches
    } catch (e) {}
  }

  Future createCampaign(
      String title,
      String description,
      String campaignID,
      String dateCreated,
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
    try {
      await DatabaseService(uid: "admin")
          .addCampaign(
              title,
              description,
              campaignID,
              dateCreated,
              dateStart,
              dateEnded,
              address,
              city,
              time,
              userUID,
              userName,
              latitude,
              longitude,
              numSeeds,
              currentDonations,
              maxDonations,
              currentVolunteers,
              numberVolunteers,
              radius,
              isActive,
              inProgress,
              isCompleted,
              deviceTokenofOrganizer)
          .whenComplete(() =>
              Fluttertoast.showToast(msg: "Campaign Successfully Published"));
      await DatabaseService(uid: "admin").deleteRequestCampaign(campaignID);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future declineCampaign(campaignID) async {
    await DatabaseService(uid: "admin").deleteRequestCampaign(campaignID);
  }

  Future deleteCampaign(campaignID) async {
    await DatabaseService(uid: "admin").deleteCampaign(campaignID);
  }

  Future createApplication(
    String validIDUrl,
    String idNumber,
    String pictureURL,
    String reasonForApplication,
    String doHaveExperience,
  ) async {
    try {
      await DatabaseService(uid: _loggedInUser!.uid)
          .saveVerification(
            validIDUrl,
            idNumber,
            pictureURL,
            reasonForApplication,
            doHaveExperience,
          )
          .whenComplete(() => Fluttertoast.showToast(
              msg: "Application for Organizer is Successfully sent"));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  verifyAUser(String id) async {
    try {
      await DatabaseService(uid: "admin")
          .verifyTheUser(id)
          .whenComplete(() => DatabaseService(uid: "admin").verify(id));
    } catch (e) {}
  }

  removerVerification(String id) async {
    try {
      await DatabaseService(uid: "admin").unVerifyUser(id);
    } catch (e) {}
  }

  removeFeedback(String id) async {
    try {
      await DatabaseService(uid: "admin").clearFeedback(id);
    } catch (e) {}
  }

  createPolygon(String forestname, points) async {
    try {
      await DatabaseService(uid: "admin")
          .savePolygonLamesa(forestname, points)
          .whenComplete(() => Fluttertoast.showToast(msg: "SUCCESS"));
    } catch (e) {}
  }
}

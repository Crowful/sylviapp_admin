import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Get Firestore instance
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Get Firestore Collection (USER)
final CollectionReference _firestoreUser = _firestore.collection('users');

class AuthService extends ChangeNotifier {
  //instance
  FirebaseAuth _auth = FirebaseAuth.instance;

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
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } on PlatformException catch (e) {
      print(e.message);
    }
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
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future resetPass(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .whenComplete(() => print("Successully Sent"));
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future deleteAcc() async {
    try {
      await DatabaseService(uid: _loggedInUser!.uid)
          .deleteUserData()
          .whenComplete(() => _loggedInUser!.delete());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future updateAcc(
      String newFullName, String newAddress, String newEmail) async {
    try {
      await _loggedInUser!.updateEmail(newEmail);
      await DatabaseService(uid: _loggedInUser!.uid)
          .updateUserData(newEmail, newFullName, newAddress);
    } catch (e) {
      print(e);
    }
  }

  Future updatePassword(String newpass) async {
    try {
      await _loggedInUser!.updatePassword(newpass).whenComplete(
          () => Fluttertoast.showToast(msg: "Password Sucessfully Changed"));
    } catch (e) {
      print(e);
    }
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
      int numberVolunteers) async {
    try {
      await DatabaseService(uid: _loggedInUser!.uid)
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
              numberVolunteers)
          .whenComplete(() =>
              Fluttertoast.showToast(msg: "Campaign Successfully Created"));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
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
}

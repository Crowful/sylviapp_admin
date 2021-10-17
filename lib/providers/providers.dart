import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sylviapp_admin/services/authservices.dart';

final authserviceProvider = Provider((ref) => AuthService());

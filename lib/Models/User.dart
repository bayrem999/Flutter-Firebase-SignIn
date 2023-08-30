import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String? fullName;
  final String? email;
  final String? phonenumber;
  final  GeoPoint? location;


  Users({required this.location, required  this.phonenumber, required this.fullName,  required this.uid, required this.email});
}

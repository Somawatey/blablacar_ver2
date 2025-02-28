import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

class RideScreen extends StatefulWidget {
  final RidePref initialRidePref;

  const RideScreen({
    super.key, 
    required this.initialRidePref
  });

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Text("Ride Screen"),
      ),
    );
  }
}
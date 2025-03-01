import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/ride/widget/ride_tile.dart';
import 'package:week_3_blabla_project/screens/ride/widget/search_ride_pref_screen.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

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
  late List<Ride> _matchingRides;

  @override
  void initState() {
    super.initState();
    _loadRides();
  }

  void _loadRides() {
    _matchingRides = RidesService.getRidesFor(widget.initialRidePref);
    debugPrint('Found ${_matchingRides.length} matching rides');
  }
 
  void onSelectMatchingRide(Ride ride) {
    debugPrint('Ride selected: ${ride.departureLocation.name}');  
  }

  void onSelectRidePref() {
    debugPrint('Select Ride Pref');
  }

  void onFilter() {
    debugPrint('Filter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rides'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(BlaSpacings.m),
          child: Column(
            children: [
              // SearchRidePref Widget
              SearchRidePref(
                ridePref: widget.initialRidePref,
                onSelectRidePref: onSelectRidePref,
                onFilter: onFilter,
              ),
              SizedBox(height: BlaSpacings.m), // Spacing
              // List of Rides
              Expanded(
                child: _matchingRides.isEmpty
                    ? Center(
                        child: Text(
                          'No rides available for your search',
                          style: BlaTextStyles.body.copyWith(
                            color: BlaColors.textLight
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _matchingRides.length,
                        itemBuilder: (context, index) => RideTile(
                          ride: _matchingRides[index],
                          onPressed: () => onSelectMatchingRide(_matchingRides[index]),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
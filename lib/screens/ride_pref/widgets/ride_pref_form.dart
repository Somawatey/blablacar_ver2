import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_list.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDepartureSelected() async {
    // 1- Select a location
    Location? selectedLocation = await Navigator.of(context)
        .push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
      initLocation: departure,
    )));
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalSelected() async {
    {
      Location? selectedLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(initLocation: arrival,)));
      if (selectedLocation != null) {
        setState(() {
          arrival = selectedLocation;
        });
      }
    }
  }

  void switchLocations() {

      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
      print("switching locations");
    
  }

  void _handleSearch() {
    if (departure != null && arrival != null) {
      print("Searching for a ride from ${departure!.name} to ${arrival!.name}");
    } else {
      print("Please select a departure and arrival location");
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(BlaSpacings.m),
      padding: EdgeInsets.all(BlaSpacings.m),
      decoration: BoxDecoration(
        color: BlaColors.white,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
        boxShadow: [
          BoxShadow(
            color: BlaColors.neutralLight.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Departure Location
            RidePrefList(
              icon: Icons.radio_button_unchecked,
              text: departureLabel,
              onTap: onDepartureSelected,
              trailing: IconButton(
                icon: Icon(
                  Icons.swap_vert,
                  color: (departure != null || arrival != null)
                      ? BlaColors.primary
                      : BlaColors.neutralLight,
                ),
                onPressed: (departure != null || arrival != null)
                    ? switchLocations
                    : null,
              ),
            ),
            BlaDivider(),
            const SizedBox(height: BlaSpacings.s),
            // Arrival Location
            RidePrefList(
              icon: Icons.radio_button_unchecked,
              text: arrivalLabel,
              onTap: onArrivalSelected,
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaDivider(),
            const SizedBox(height: BlaSpacings.s),

            // Date
            RidePrefList(
              icon: Icons.calendar_today,
              text: dateLabel, // Using getter
              onTap: () => {},
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaDivider(),
            const SizedBox(height: BlaSpacings.s),
            // Number of Seats
            RidePrefList(
              icon: Icons
                  .person_2_outlined, // Use 'icon' instead of 'leftIcon' for consistency
              text: numberLabel,
              onTap: () => {},
            ),
            const SizedBox(height: BlaSpacings.s),
            BlaDivider(),

            const SizedBox(height: BlaSpacings.m),
            // Search Button
            SizedBox(
              width: double.infinity,
              child: BlaButton(
                text: "Search",
                type: BlaButtonType.primary,
                leftIcon: Icons.search,
                onPressed: _handleSearch,
              ),
            ),
          ]),
    );
  }
}

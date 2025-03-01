import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final VoidCallback onPressed;

  const RideTile({
    super.key, 
    required this.ride, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(ride.departureLocation.name),
          Text(
            '${ride.pricePerSeat}€',
            style: TextStyle(color: BlaColors.primary),
          ),
        ],
      ),
      subtitle: Text(ride.arrivalLocation.name),
      leading: CircleAvatar(
        backgroundColor: BlaColors.backgroundAccent,
        child: Icon(Icons.person, color: BlaColors.primary),
      ),
      trailing: Text(DateTimeUtils.formatTime(ride.departureDate)),
    );
  }
}
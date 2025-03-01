import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

class SearchRidePref extends StatelessWidget {
  final RidePref ridePref;
  final VoidCallback onSelectRidePref;
  final VoidCallback onFilter;

  const SearchRidePref({
    super.key,
    required this.ridePref,
    required this.onSelectRidePref,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BlaSpacings.s),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onSelectRidePref,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Departure → Arrival
                  Text(
                    '${ridePref.departure.name} → ${ridePref.arrival.name}',
                    style: BlaTextStyles.body,
                  ),
                  SizedBox(height: BlaSpacings.xs),
                  Text(
                    DateTimeUtils.formatDateTime(ridePref.departureDate),
                    style: BlaTextStyles.label.copyWith(
                      color: BlaColors.textLight,
                    ),
                  ),
                  SizedBox(height: BlaSpacings.xs), 
                  Text(
                    '${ridePref.requestedSeats} passenger(s)',
                    style: BlaTextStyles.label.copyWith(
                      color: BlaColors.textLight,
                    ),
                  ),
                ],
              ),
            ),
          ),

          IconButton(
            icon: Icon(
              Icons.tune,
              color: BlaColors.primary,
              size: 24,
            ),
            onPressed: onFilter,
          ),
        ],
      ),
    );
  }
}
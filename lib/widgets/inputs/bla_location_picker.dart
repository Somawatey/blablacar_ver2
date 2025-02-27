import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;

  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onSearchChanged(String searchText) {
    if (searchText.length <= 1) {
      setState(() => filteredLocations = []);
      return;
    }

    setState(() {
      filteredLocations = LocationsService.availableLocations
          .where((location) =>
              location.name.toUpperCase().contains(searchText.toUpperCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: BlaSpacings.m, 
            right: BlaSpacings.m, 
            top: BlaSpacings.s
          ),
          child: Column(
            children: [
              BlaSearchBar(
                onBackPressed: onBackSelected,
                onSearchChanged: onSearchChanged,
              ),
              const SizedBox(height: BlaSpacings.m),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (ctx, index) => LocationTile(
                    location: filteredLocations[index],
                    onSelected: onLocationSelected,
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

class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile({
    super.key, 
    required this.location, 
    required this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(
        location.name,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)
      ),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
    );
  }
}

class BlaSearchBar extends StatefulWidget {
  final Function(String text) onSearchChanged;
  final VoidCallback onBackPressed;

  const BlaSearchBar({
    super.key, 
    required this.onSearchChanged, 
    required this.onBackPressed
  });

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconLight,
                size: 16,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              style: TextStyle(color: BlaColors.textLight),
              decoration: const InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none,
                filled: false,
              ),
              onChanged: widget.onSearchChanged,
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.close, color: BlaColors.iconLight),
              onPressed: () {
                _controller.clear();
                _focusNode.requestFocus();
                widget.onSearchChanged("");
              },
            ),
        ],
      ),
    );
  }
}
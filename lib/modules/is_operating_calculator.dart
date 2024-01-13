import 'package:intl/intl.dart';

bool isStoreOpen(Map<String, List<int>> operatingHours) {
  // Get the current day and time
  DateTime now = DateTime.now();
  String currentDay = DateFormat('EEEE').format(now); // Returns the full weekday name

  // Check if the store is open on the current day
  if (operatingHours.containsKey(currentDay.toLowerCase())) {
    List<int> hours = operatingHours[currentDay.toLowerCase()]!;

    // Get the current hour in 24-hour format
    int currentHour = now.hour;

    // Check if the store is open based on the current time
    if (currentHour >= hours[0] && currentHour < hours[1]) {
      return true; // Store is open
    }
  }

  return false; // Store is closed
}
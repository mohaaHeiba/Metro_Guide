// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "Error getting coordinates from address: ${error}";

  static String m1(query) => "Location not found: ${query}";

  static String m2(stationName) => "You are near: ${stationName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "Shortest_route_details": MessageLookupByLibrary.simpleMessage(
      "Shortest Route Details",
    ),
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accessibility": MessageLookupByLibrary.simpleMessage("Accessibility"),
    "accessibility_desc": MessageLookupByLibrary.simpleMessage(
      "All stations are wheelchair accessible with elevators and ramps",
    ),
    "all_history_cleared": MessageLookupByLibrary.simpleMessage(
      "All history cleared",
    ),
    "app_desc": MessageLookupByLibrary.simpleMessage(
      "Your smart companion for metro travel.\nFind routes, stations, and arrival times easily.",
    ),
    "app_name": MessageLookupByLibrary.simpleMessage("Metro Guide"),
    "ar": MessageLookupByLibrary.simpleMessage("Arabic"),
    "book_journey": MessageLookupByLibrary.simpleMessage(
      "Book your journey with ease",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "change": MessageLookupByLibrary.simpleMessage("Change"),
    "clear": MessageLookupByLibrary.simpleMessage("Clear"),
    "clear_history": MessageLookupByLibrary.simpleMessage("Clear History"),
    "clear_history_confirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to clear all route history?",
    ),
    "comfortable_route_details": MessageLookupByLibrary.simpleMessage(
      "comfortable Route Details",
    ),
    "confirme_location": MessageLookupByLibrary.simpleMessage(
      "confirme location",
    ),
    "contact_us": MessageLookupByLibrary.simpleMessage("Contact Us"),
    "contact_us_desc": MessageLookupByLibrary.simpleMessage(
      "You can reach us via email anytime. We will get back to you as soon as possible.",
    ),
    "dark_mode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "direct_route": MessageLookupByLibrary.simpleMessage("Direct Route"),
    "distance": MessageLookupByLibrary.simpleMessage("Distance"),
    "duration": MessageLookupByLibrary.simpleMessage("Duration:"),
    "egp": MessageLookupByLibrary.simpleMessage("EGP"),
    "email_error": MessageLookupByLibrary.simpleMessage(
      "Could not launch Email",
    ),
    "emergency_contacts": MessageLookupByLibrary.simpleMessage(
      "Emergency Contacts",
    ),
    "emergency_contacts_desc": MessageLookupByLibrary.simpleMessage(
      "Call 911 for emergencies or use emergency phones on platforms",
    ),
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "end": MessageLookupByLibrary.simpleMessage("END"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "error_getting_coordinates": m0,
    "from": MessageLookupByLibrary.simpleMessage("From"),
    "from_card": MessageLookupByLibrary.simpleMessage("From"),
    "get_started": MessageLookupByLibrary.simpleMessage("Get Started"),
    "hour": MessageLookupByLibrary.simpleMessage("hr"),
    "hours": MessageLookupByLibrary.simpleMessage("5:00 AM - 12:00 AM"),
    "instructions": MessageLookupByLibrary.simpleMessage("Instructions"),
    "journey_details": MessageLookupByLibrary.simpleMessage("Journey Details"),
    "journey_history": MessageLookupByLibrary.simpleMessage("Journey History"),
    "just_now": MessageLookupByLibrary.simpleMessage("Just now"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "last_updated": MessageLookupByLibrary.simpleMessage("Last Updated"),
    "light_mode": MessageLookupByLibrary.simpleMessage("Light Mode"),
    "location_not_found": m1,
    "metro_map": MessageLookupByLibrary.simpleMessage("Full Metro Map"),
    "metro_ticket": MessageLookupByLibrary.simpleMessage("Metro Ticket"),
    "min": MessageLookupByLibrary.simpleMessage("min"),
    "nav_history": MessageLookupByLibrary.simpleMessage("History"),
    "nav_home": MessageLookupByLibrary.simpleMessage("Home"),
    "nav_instructions": MessageLookupByLibrary.simpleMessage("Instructions"),
    "nav_settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "nearest_station": MessageLookupByLibrary.simpleMessage("Nearest Station"),
    "nearest_station_cached": MessageLookupByLibrary.simpleMessage(
      "Nearest Station (Cached)",
    ),
    "nearest_station_online": MessageLookupByLibrary.simpleMessage(
      "Nearest Station (Online)",
    ),
    "need_help": MessageLookupByLibrary.simpleMessage("Need Help?"),
    "no_history": MessageLookupByLibrary.simpleMessage(
      "No journey history yet",
    ),
    "no_history_desc": MessageLookupByLibrary.simpleMessage(
      "Your recent routes will appear here",
    ),
    "no_location_selected": MessageLookupByLibrary.simpleMessage(
      "No location selected",
    ),
    "no_routes_found": MessageLookupByLibrary.simpleMessage("No routes found"),
    "operating_hours": MessageLookupByLibrary.simpleMessage("Operating Hours"),
    "price": MessageLookupByLibrary.simpleMessage("Price:"),
    "prohibited_actions": MessageLookupByLibrary.simpleMessage(
      "Prohibited Actions",
    ),
    "prohibited_actions_desc": MessageLookupByLibrary.simpleMessage(
      "Smoking, carrying flammable materials, and vandalism are prohibited",
    ),
    "recent_journeys": MessageLookupByLibrary.simpleMessage(
      "Your recent metro journeys",
    ),
    "route_details": MessageLookupByLibrary.simpleMessage("Route Details"),
    "route_loaded": MessageLookupByLibrary.simpleMessage("Route Loaded"),
    "route_loaded_desc": MessageLookupByLibrary.simpleMessage(
      "Route has been loaded",
    ),
    "route_path": MessageLookupByLibrary.simpleMessage("Route Path"),
    "route_removed": MessageLookupByLibrary.simpleMessage(
      "Route removed from history",
    ),
    "safety_guidelines": MessageLookupByLibrary.simpleMessage(
      "Safety Guidelines",
    ),
    "safety_guidelines_desc": MessageLookupByLibrary.simpleMessage(
      "Stand behind the yellow line, hold the handrail on escalators",
    ),
    "search_location": MessageLookupByLibrary.simpleMessage(
      "Search for a location...",
    ),
    "select_location": MessageLookupByLibrary.simpleMessage("Select location"),
    "select_route": MessageLookupByLibrary.simpleMessage("Select Your Route"),
    "send_email": MessageLookupByLibrary.simpleMessage("Send Email"),
    "service_status": MessageLookupByLibrary.simpleMessage("Service Status"),
    "show_more": MessageLookupByLibrary.simpleMessage("Show More"),
    "show_ticket": MessageLookupByLibrary.simpleMessage("Show Ticket"),
    "show_ticket_card": MessageLookupByLibrary.simpleMessage("Metro \nTicket"),
    "start": MessageLookupByLibrary.simpleMessage("START"),
    "stations": MessageLookupByLibrary.simpleMessage("Stations"),
    "status_all_operational": MessageLookupByLibrary.simpleMessage(
      "All lines operational",
    ),
    "symbol": MessageLookupByLibrary.simpleMessage("→"),
    "ticketing": MessageLookupByLibrary.simpleMessage("Ticketing"),
    "ticketing_desc": MessageLookupByLibrary.simpleMessage(
      "Use contactless cards or tokens at entry gates",
    ),
    "to": MessageLookupByLibrary.simpleMessage("To"),
    "to_card": MessageLookupByLibrary.simpleMessage("To"),
    "towards": MessageLookupByLibrary.simpleMessage("Towards"),
    "tranfers": MessageLookupByLibrary.simpleMessage(" Transfer"),
    "tranfers_2": MessageLookupByLibrary.simpleMessage("Double Transfer Route"),
    "transfer_at": MessageLookupByLibrary.simpleMessage("TRANSFER at"),
    "transfers": MessageLookupByLibrary.simpleMessage("Transfers"),
    "type": MessageLookupByLibrary.simpleMessage("Type"),
    "unknown": MessageLookupByLibrary.simpleMessage("UnKnown "),
    "valid": MessageLookupByLibrary.simpleMessage("Valid"),
    "view_full_map": MessageLookupByLibrary.simpleMessage("View Full Map"),
    "you_are_near": m2,
  };
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the 'welcom page' key

  /// `Metro Guide`
  String get app_name {
    return Intl.message('Metro Guide', name: 'app_name', desc: '', args: []);
  }

  /// `Your smart companion for metro travel.\nFind routes, stations, and arrival times easily.`
  String get app_desc {
    return Intl.message(
      'Your smart companion for metro travel.\nFind routes, stations, and arrival times easily.',
      name: 'app_desc',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message('Get Started', name: 'get_started', desc: '', args: []);
  }

  // skipped getter for the 'Navigation page' key

  /// `Home`
  String get nav_home {
    return Intl.message('Home', name: 'nav_home', desc: '', args: []);
  }

  /// `Instructions`
  String get nav_instructions {
    return Intl.message(
      'Instructions',
      name: 'nav_instructions',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get nav_history {
    return Intl.message('History', name: 'nav_history', desc: '', args: []);
  }

  /// `Settings`
  String get nav_settings {
    return Intl.message('Settings', name: 'nav_settings', desc: '', args: []);
  }

  // skipped getter for the 'Home page' key

  /// `Metro Ticket`
  String get metro_ticket {
    return Intl.message(
      'Metro Ticket',
      name: 'metro_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Book your journey with ease`
  String get book_journey {
    return Intl.message(
      'Book your journey with ease',
      name: 'book_journey',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Route`
  String get select_route {
    return Intl.message(
      'Select Your Route',
      name: 'select_route',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `To`
  String get to {
    return Intl.message('To', name: 'to', desc: '', args: []);
  }

  /// `Show Ticket`
  String get show_ticket {
    return Intl.message('Show Ticket', name: 'show_ticket', desc: '', args: []);
  }

  /// `No routes found`
  String get no_routes_found {
    return Intl.message(
      'No routes found',
      name: 'no_routes_found',
      desc: '',
      args: [],
    );
  }

  /// `Search for a location...`
  String get search_location {
    return Intl.message(
      'Search for a location...',
      name: 'search_location',
      desc: '',
      args: [],
    );
  }

  /// `Journey Details`
  String get journey_details {
    return Intl.message(
      'Journey Details',
      name: 'journey_details',
      desc: '',
      args: [],
    );
  }

  /// `Duration:`
  String get duration {
    return Intl.message('Duration:', name: 'duration', desc: '', args: []);
  }

  /// `Price:`
  String get price {
    return Intl.message('Price:', name: 'price', desc: '', args: []);
  }

  /// `Stations`
  String get stations {
    return Intl.message('Stations', name: 'stations', desc: '', args: []);
  }

  /// `Transfers`
  String get transfers {
    return Intl.message('Transfers', name: 'transfers', desc: '', args: []);
  }

  /// `Show More`
  String get show_more {
    return Intl.message('Show More', name: 'show_more', desc: '', args: []);
  }

  /// `Metro \nTicket`
  String get show_ticket_card {
    return Intl.message(
      'Metro \nTicket',
      name: 'show_ticket_card',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from_card {
    return Intl.message('From', name: 'from_card', desc: '', args: []);
  }

  /// `To`
  String get to_card {
    return Intl.message('To', name: 'to_card', desc: '', args: []);
  }

  /// `Valid`
  String get valid {
    return Intl.message('Valid', name: 'valid', desc: '', args: []);
  }

  /// `UnKnown `
  String get unknown {
    return Intl.message('UnKnown ', name: 'unknown', desc: '', args: []);
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
  }

  /// `min`
  String get min {
    return Intl.message('min', name: 'min', desc: '', args: []);
  }

  /// `hr`
  String get hour {
    return Intl.message('hr', name: 'hour', desc: '', args: []);
  }

  // skipped getter for the 'details page' key

  /// `Direct Route`
  String get direct_route {
    return Intl.message(
      'Direct Route',
      name: 'direct_route',
      desc: '',
      args: [],
    );
  }

  /// ` Transfer`
  String get tranfers {
    return Intl.message(' Transfer', name: 'tranfers', desc: '', args: []);
  }

  /// `Double Transfer Route`
  String get tranfers_2 {
    return Intl.message(
      'Double Transfer Route',
      name: 'tranfers_2',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message('Distance', name: 'distance', desc: '', args: []);
  }

  /// `Route Details`
  String get route_details {
    return Intl.message(
      'Route Details',
      name: 'route_details',
      desc: '',
      args: [],
    );
  }

  /// `Towards`
  String get towards {
    return Intl.message('Towards', name: 'towards', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Route Path`
  String get route_path {
    return Intl.message('Route Path', name: 'route_path', desc: '', args: []);
  }

  /// `START`
  String get start {
    return Intl.message('START', name: 'start', desc: '', args: []);
  }

  /// `END`
  String get end {
    return Intl.message('END', name: 'end', desc: '', args: []);
  }

  /// `TRANSFER at`
  String get transfer_at {
    return Intl.message('TRANSFER at', name: 'transfer_at', desc: '', args: []);
  }

  /// `→`
  String get symbol {
    return Intl.message('→', name: 'symbol', desc: '', args: []);
  }

  // skipped getter for the 'instructions page' key

  /// `View Full Map`
  String get view_full_map {
    return Intl.message(
      'View Full Map',
      name: 'view_full_map',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: '',
      args: [],
    );
  }

  /// `Operating Hours`
  String get operating_hours {
    return Intl.message(
      'Operating Hours',
      name: 'operating_hours',
      desc: '',
      args: [],
    );
  }

  /// `Service Status`
  String get service_status {
    return Intl.message(
      'Service Status',
      name: 'service_status',
      desc: '',
      args: [],
    );
  }

  /// `Last Updated`
  String get last_updated {
    return Intl.message(
      'Last Updated',
      name: 'last_updated',
      desc: '',
      args: [],
    );
  }

  /// `5:00 AM - 12:00 AM`
  String get hours {
    return Intl.message(
      '5:00 AM - 12:00 AM',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `All lines operational`
  String get status_all_operational {
    return Intl.message(
      'All lines operational',
      name: 'status_all_operational',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get just_now {
    return Intl.message('Just now', name: 'just_now', desc: '', args: []);
  }

  /// `Ticketing`
  String get ticketing {
    return Intl.message('Ticketing', name: 'ticketing', desc: '', args: []);
  }

  /// `Use contactless cards or tokens at entry gates`
  String get ticketing_desc {
    return Intl.message(
      'Use contactless cards or tokens at entry gates',
      name: 'ticketing_desc',
      desc: '',
      args: [],
    );
  }

  /// `Safety Guidelines`
  String get safety_guidelines {
    return Intl.message(
      'Safety Guidelines',
      name: 'safety_guidelines',
      desc: '',
      args: [],
    );
  }

  /// `Stand behind the yellow line, hold the handrail on escalators`
  String get safety_guidelines_desc {
    return Intl.message(
      'Stand behind the yellow line, hold the handrail on escalators',
      name: 'safety_guidelines_desc',
      desc: '',
      args: [],
    );
  }

  /// `Prohibited Actions`
  String get prohibited_actions {
    return Intl.message(
      'Prohibited Actions',
      name: 'prohibited_actions',
      desc: '',
      args: [],
    );
  }

  /// `Smoking, carrying flammable materials, and vandalism are prohibited`
  String get prohibited_actions_desc {
    return Intl.message(
      'Smoking, carrying flammable materials, and vandalism are prohibited',
      name: 'prohibited_actions_desc',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contacts`
  String get emergency_contacts {
    return Intl.message(
      'Emergency Contacts',
      name: 'emergency_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Call 911 for emergencies or use emergency phones on platforms`
  String get emergency_contacts_desc {
    return Intl.message(
      'Call 911 for emergencies or use emergency phones on platforms',
      name: 'emergency_contacts_desc',
      desc: '',
      args: [],
    );
  }

  /// `Accessibility`
  String get accessibility {
    return Intl.message(
      'Accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `All stations are wheelchair accessible with elevators and ramps`
  String get accessibility_desc {
    return Intl.message(
      'All stations are wheelchair accessible with elevators and ramps',
      name: 'accessibility_desc',
      desc: '',
      args: [],
    );
  }

  /// `Full Metro Map`
  String get metro_map {
    return Intl.message(
      'Full Metro Map',
      name: 'metro_map',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'history page' key

  /// `Journey History`
  String get journey_history {
    return Intl.message(
      'Journey History',
      name: 'journey_history',
      desc: '',
      args: [],
    );
  }

  /// `Your recent metro journeys`
  String get recent_journeys {
    return Intl.message(
      'Your recent metro journeys',
      name: 'recent_journeys',
      desc: '',
      args: [],
    );
  }

  /// `Clear History`
  String get clear_history {
    return Intl.message(
      'Clear History',
      name: 'clear_history',
      desc: '',
      args: [],
    );
  }

  /// `No journey history yet`
  String get no_history {
    return Intl.message(
      'No journey history yet',
      name: 'no_history',
      desc: '',
      args: [],
    );
  }

  /// `Your recent routes will appear here`
  String get no_history_desc {
    return Intl.message(
      'Your recent routes will appear here',
      name: 'no_history_desc',
      desc: '',
      args: [],
    );
  }

  /// `Route removed from history`
  String get route_removed {
    return Intl.message(
      'Route removed from history',
      name: 'route_removed',
      desc: '',
      args: [],
    );
  }

  /// `All history cleared`
  String get all_history_cleared {
    return Intl.message(
      'All history cleared',
      name: 'all_history_cleared',
      desc: '',
      args: [],
    );
  }

  /// `Route Loaded`
  String get route_loaded {
    return Intl.message(
      'Route Loaded',
      name: 'route_loaded',
      desc: '',
      args: [],
    );
  }

  /// `Route has been loaded`
  String get route_loaded_desc {
    return Intl.message(
      'Route has been loaded',
      name: 'route_loaded_desc',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear all route history?`
  String get clear_history_confirm {
    return Intl.message(
      'Are you sure you want to clear all route history?',
      name: 'clear_history_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  // skipped getter for the 'map page' key

  /// `Select location`
  String get select_location {
    return Intl.message(
      'Select location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `confirme location`
  String get confirme_location {
    return Intl.message(
      'confirme location',
      name: 'confirme_location',
      desc: '',
      args: [],
    );
  }

  /// `No location selected`
  String get no_location_selected {
    return Intl.message(
      'No location selected',
      name: 'no_location_selected',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'settings page' key

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message('Dark Mode', name: 'dark_mode', desc: '', args: []);
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message('Light Mode', name: 'light_mode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Arabic`
  String get ar {
    return Intl.message('Arabic', name: 'ar', desc: '', args: []);
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Need Help?`
  String get need_help {
    return Intl.message('Need Help?', name: 'need_help', desc: '', args: []);
  }

  /// `You can reach us via email anytime. We will get back to you as soon as possible.`
  String get contact_us_desc {
    return Intl.message(
      'You can reach us via email anytime. We will get back to you as soon as possible.',
      name: 'contact_us_desc',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get send_email {
    return Intl.message('Send Email', name: 'send_email', desc: '', args: []);
  }

  /// `Could not launch Email`
  String get email_error {
    return Intl.message(
      'Could not launch Email',
      name: 'email_error',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'snackbar messages' key

  /// `Nearest Station`
  String get nearest_station {
    return Intl.message(
      'Nearest Station',
      name: 'nearest_station',
      desc: '',
      args: [],
    );
  }

  /// `Nearest Station (Cached)`
  String get nearest_station_cached {
    return Intl.message(
      'Nearest Station (Cached)',
      name: 'nearest_station_cached',
      desc: '',
      args: [],
    );
  }

  /// `Nearest Station (Online)`
  String get nearest_station_online {
    return Intl.message(
      'Nearest Station (Online)',
      name: 'nearest_station_online',
      desc: '',
      args: [],
    );
  }

  /// `You are near: {stationName}`
  String you_are_near(Object stationName) {
    return Intl.message(
      'You are near: $stationName',
      name: 'you_are_near',
      desc: '',
      args: [stationName],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Error getting coordinates from address: {error}`
  String error_getting_coordinates(Object error) {
    return Intl.message(
      'Error getting coordinates from address: $error',
      name: 'error_getting_coordinates',
      desc: '',
      args: [error],
    );
  }

  /// `Location not found: {query}`
  String location_not_found(Object query) {
    return Intl.message(
      'Location not found: $query',
      name: 'location_not_found',
      desc: '',
      args: [query],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

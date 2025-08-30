# Metro Guide

A Flutter app for metro travel navigation with route planning, location services, and journey history.

## Features

### Route Planning
- Find optimal metro routes between stations
- Support for direct routes, transfers, and double transfers
- Real-time pricing and journey time calculation
- Auto-complete station selection

### Location Services
- Detect current location and find nearest station
- Convert addresses to nearest metro stations
- Geocoding integration for location search
- Cached results for faster access

### Interactive Map
- Complete metro network visualization
- Full-screen zoomable map view
- Station information and service status

### Journey History
- Save and track previous journeys
- Quick route reuse from history
- Smart duplicate removal

### Settings & Customization
- Dark/light theme toggle
- English and Arabic language support
- Contact support integration

## Architecture

```
lib/
├── core/           # Services and utilities
├── data/           # Database and data sources
├── domain/         # Business logic and entities
├── presentation/   # UI pages and controllers
└── generated/      # Localization files
```

## Tech Stack

- **Flutter** 3.8.1+
- **GetX** - State management
- **Floor** - SQLite database ORM
- **Geolocator** - Location services
- **Geocoding** - Address conversion

## Installation

1. Clone the repository
2. Install dependencies: `flutter pub get`
3. Generate database files: `flutter packages pub run build_runner build`
4. Run the app: `flutter run`

## Build

**Android:** `flutter build apk --release`
**iOS:** `flutter build ios --release`

## Key Features

### Smart Route Finding
- Direct routes on same line
- Transfer routes with optimal points
- Multiple transfer scenarios
- Shortest route prioritization

### Location Intelligence
- GPS location detection
- Address to coordinates conversion
- Nearest station calculation
- Performance caching

### Multi-language Support
- English and Arabic interface
- RTL layout support
- Dynamic language switching

## Database

- **MetroStations** - Station data (ID, name, coordinates, line)
- **NearestStreets** - Cached address mappings
- **Route History** - User journey records

## Performance

- Efficient database queries
- Smart caching strategy
- Memory management optimization
- Background processing

## Troubleshooting

- **Location issues** - Check GPS permissions
- **Routes not found** - Verify station names
- **App crashes** - Clear app data
- **Slow performance** - Check storage space

## Developer

**Mohamed Heiba**

## License

MIT License

---

Metro Guide - Your smart companion for metro travel!

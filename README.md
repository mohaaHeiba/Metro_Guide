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
## images
<img src="https://github.com/user-attachments/assets/af21a5ba-d023-4924-94d3-411e6c1a15a5" width="180"/>
<img src="https://github.com/user-attachments/assets/c9aead87-9ac8-4586-8eb2-271734b7889d" width="180"/>
<img src="https://github.com/user-attachments/assets/61dddb1b-07a0-4260-bac0-3eaf25c4541a" width="180"/>
<img src="https://github.com/user-attachments/assets/cee5fcf4-5b08-4903-9416-53ea533c826b" width="180"/>
<img src="https://github.com/user-attachments/assets/ecd3ac24-0b9a-4fad-bfdb-c4aeace1f473" width="180"/>
<img src="https://github.com/user-attachments/assets/6d510c13-7cff-4d21-9e0d-5acf283047ca" width="180"/>
<img src="https://github.com/user-attachments/assets/bd2e56c0-f1cc-4283-a4e6-ae4a2f3c8622" width="180"/>
<img src="https://github.com/user-attachments/assets/fb308394-a4af-4161-9108-c94adad3fe3a" width="180"/>



## Developer

**Mohamed Heiba**

## License

MIT License

---

Metro Guide - Your smart companion for metro travel!

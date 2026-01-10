# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**pjatka** is a Flutter-based student companion app for PJATK (Polish-Japanese Academy of Information Technology) that provides an enhanced timetable experience. The app scrapes the university's ASP.NET WebForms-based schedule website to provide native mobile/web experiences with additional features.

**Key characteristic**: There is NO backend - the app directly scrapes and parses the PJATK schedule server.

## Development Commands

### Version control
This repo uses Jujutsu (jj) version control system. Docs: https://docs.jj-vcs.dev/latest/
This repo also uses conventionall commits notation

###
```
jj log # List of all 'visibile' commits
jj commit -m "refactor(db): added ability to cordon classes # describe current commit, create a child and move to it
jj tug # updated 'nearest' bookmark to previous commit
```

### Setup
```bash
# Get dependencies
flutter pub get

# Generate code (freezed, riverpod, drift, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running
```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome          # Web
flutter run -d macos          # macOS
flutter run -d android        # Android
```

### Building
```bash
# Build for release
flutter build apk --release           # Android APK
flutter build web --release           # Web
flutter build macos --release         # macOS
```

### Code Generation
When adding or modifying models with `@freezed`, `@riverpod`, `@JsonSerializable`, or Drift tables, regenerate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Linting
```bash
flutter analyze
```

## Architecture

### Core Features Structure

The codebase follows a feature-based architecture under `lib/features/`:

1. **parsing/** - Web scraping and HTML parsing
   - `parsers/asp_emulator.dart`: Emulates ASP.NET WebForms state management (ViewState, EventTarget, etc.) to interact with the legacy PJATK schedule system
   - `parsers/pjatk_parser.dart`: Main parser that extracts schedule data from HTML responses
   - `parsers/class_deductor.dart`: Deducts class information from parsed data
   - Implements rate limiting via semaphores to avoid overwhelming the PJATK server

2. **database/** - Local data persistence with Drift (SQLite)
   - `database.dart`: Defines schema with tables: Subject, ClassAppointment, Teacher, Group, ClassGroup, ClassTeacher
   - Uses decomposed normalized schema (recent refactor: commit 6cb3990)
   - Foreign key relationships and unique constraints enforced
   - WAL mode enabled for better concurrency

3. **schedule/** - Schedule management and data access
   - `data/schedule_dao.dart`: Data Access Object for schedule queries and CRUD operations
   - `providers/schedule_providers.dart`: Riverpod providers for schedule state management
   - `models.dart`: Core domain models (ScheduledClass, ClassKind, StudyMode, etc.) using Freezed

4. **settings/** - App configuration and persistence
   - Uses Riverpod's experimental persist feature with SharedPreferences
   - Stores user preferences like cache TTL, date range offsets, selected groups

### State Management

- **Riverpod** is used throughout for dependency injection and state management
- Providers use code generation via `@riverpod` annotation
- Key providers:
  - `globalLoader`: Orchestrates schedule parsing and caching logic
  - `userClassesProvider`: Stream-based provider watching user's filtered classes
  - `settingsProvider`: Persisted settings state
  - `parserProvider`: Singleton PjatkParser instance

### Parsing Flow

The app parses the schedule in an optimized order to improve UX:
1. Parse today's schedule first
2. Parse future days (controlled by `maxDateDaysOffset` setting)
3. Parse past days (controlled by `minDateDaysOffset` setting)
4. Each day checks cache freshness via `cacheTTLHours` setting before re-parsing

### Data Models

- **Freezed** is used for immutable data classes with union types (sealed classes)
- **json_serializable** handles JSON serialization for API models
- Models are split between:
  - Parse models (what comes from HTML scraping)
  - Database models (Drift tables and companions)
  - Domain models (what the UI consumes)

### ASP.NET Emulation

The PJATK schedule system uses ASP.NET WebForms, which requires:
- Maintaining ViewState across requests (hidden form fields)
- Simulating postback events with `__EVENTTARGET` and `__EVENTARGUMENT`
- Parsing and updating form state for each request
- The `AspEmulator` class handles this complexity transparently

### Caching Strategy

- Schedule data is cached in local SQLite database
- Cache invalidation based on `lastUpdated` timestamp per appointment
- Configurable TTL (Time To Live) in hours via settings
- Allows offline viewing and reduces server load

## UI Structure

- `lib/screens/`: Top-level screen widgets
  - `schedule.dart`: Main timetable view
  - `settings/`: Settings screens and components
- `lib/home.dart`: Main navigation/routing using `canonical_adaptive_scaffold`
- Uses Material Design with dark theme

## Important Conventions

### Code Generation Files
- `*.g.dart`: Generated by build_runner (json_serializable, riverpod_generator, drift_dev)
- `*.freezed.dart`: Generated by freezed for immutable data classes
- **Never edit these files manually** - they are regenerated on each build_runner execution

### Imports
- Use relative imports within features
- Export barrel files (e.g., `parsing.dart`) to expose feature APIs

### Database Migrations
- Schema version is tracked in `AppDatabase.schemaVersion`
- Migrations handled in `MigrationStrategy`
- Current version: 1 (after schema refactor)

## CI/CD

- `.github/workflows/android-pre-release.yml`: Builds and publishes Android APK as pre-release on every main branch push
- `.github/workflows/web-deploy.yml`: Deploys web version

## Known Constraints

1. **No PJATK API**: The app scrapes HTML from an ASP.NET WebForms application, making parsing fragile and slow
2. **Rate limiting**: Concurrency is limited via semaphores to avoid overwhelming the server (~300 classes per day need individual requests)
3. **Large request payloads**: ASP.NET ViewState causes each request to be several KB in size
4. **No official affiliation**: Use at your own risk - not affiliated with PJATK

## Testing

Tests are located in `test/` directory but currently minimal. Test structure mirrors `lib/` with feature-based organization.

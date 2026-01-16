# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter-based student companion app for PJATK (Polish-Japanese Academy of Information Technology). Scrapes PJATK's ASP.NET WebForms timetable website to provide a native mobile experience with day/week/month schedule views.

## Monorepo Structure

- `packages/app/` - Flutter client app (UI, features, platform projects)
- `packages/pjatk_core/` - Shared Dart library for parsing, database models, and reconciliation logic
- `packages/server/` - Dart cache server built on Relic framework
- `packages/flutter_adaptive_scaffold/` - Custom responsive layout package
- Generated code lives alongside sources as `*.g.dart` and `*.freezed.dart` files

## Build & Development Commands

```bash
flutter pub get                                                    # Install workspace dependencies
flutter pub run build_runner build --delete-conflicting-outputs   # Regenerate Freezed, Riverpod, Drift, JSON code
flutter run -d chrome|android|macos                               # Run app on target platform
flutter build apk|web|macos --release                             # Production builds
flutter analyze                                                   # Linting and static analysis
dart test                                                         # Run tests (from packages/pjatk_core/)
```

## Architecture

**State Management**: Riverpod with code generation (`@riverpod` annotations)

**Data Layer**: Drift ORM for SQLite with schema versioning. Tables: Subject, ClassAppointment, Teacher, Group, ClassGroup, ClassTeacher, DayInfo

**Parsing**: ASP.NET WebForms state emulation (`asp_emulator.dart`) to scrape PJATK schedules. Parser is in `packages/pjatk_core/lib/parsing/`

**API Configuration**: Compile-time `--dart-define=API_URL` for environment-specific endpoints

## Code Style

- 2-space indentation (Dart default)
- Prefer single quotes in app code
- `lower_snake_case` for filenames
- Never edit generated files (`*.g.dart`, `*.freezed.dart`) directly

## Testing

- Framework: `package:test`
- Tests use `_test.dart` suffix mirroring source paths
- Run from package directory: `cd packages/pjatk_core && dart test`

## VCS & Commits

- Uses **Jujutsu (jj)** for version control, not git
- Commands: `jj log`, `jj commit -m "type(scope): msg"`
- Conventional Commits format: `feat(parser): add delta parsing`

## Critical Notes

- **Parser safety**: Parsing relies on PJATK's ASP.NET WebForms state. Avoid changing parser behavior without tests
- **Rate limiting**: Keep scraping concurrency conservative to avoid overloading upstream server (Semaphore-based)
- **No backend API**: App directly scrapes PJATK's website, caches locally with configurable TTL

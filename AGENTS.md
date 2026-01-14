# Repository Guidelines

## Project Structure & Module Organization
- `packages/app/`: Flutter client app (UI, features, platform projects in `android/`, `ios/`, `macos/`, `windows/`).
- `packages/pjatk_core/`: Shared Dart library for parsing, database models, and reconciliation logic.
- `packages/server/`: Dart cache server built on top of `pjatk_core`.
- `assets/`: Shared repo-level assets (e.g., branding).
- Generated code lives alongside sources as `*.g.dart` and `*.freezed.dart` files.

## Build, Test, and Development Commands
- `flutter pub get`: Install dependencies for the workspace.
- `flutter pub run build_runner build --delete-conflicting-outputs`: Regenerate Freezed, Riverpod, Drift, and JSON code.
- `flutter run -d chrome` / `flutter run -d android` / `flutter run -d macos`: Run the app on a target platform.
- `flutter build apk --release` / `flutter build web --release` / `flutter build macos --release`: Produce release builds.
- `flutter analyze`: Run linting and static analysis.
- `dart test` (from `packages/pjatk_core/`): Run core library unit tests.

## Coding Style & Naming Conventions
- Dart/Flutter formatting defaults apply (2-space indentation).
- Linting: `packages/app/analysis_options.yaml` uses `flutter_lints` with a few overrides; core/server use `package:lints/recommended`.
- Prefer single quotes in app code; keep filenames and types in `lower_snake_case` (Dart standard).
- Do not edit generated files (`*.g.dart`, `*.freezed.dart`) directly; regenerate via build_runner.

## Testing Guidelines
- Framework: `package:test` (see `packages/pjatk_core/test/`).
- Name tests with a `_test.dart` suffix and mirror feature paths (e.g., `features/parsing/..._test.dart`).
- Run targeted tests from the package directory to keep feedback fast.

## Commit & Pull Request Guidelines
- Commits follow Conventional Commits (e.g., `feat(parser): add delta parsing`).
- This repo uses Jujutsu (`jj`) for VCS; `jj log` and `jj commit -m "type(scope): msg"` are standard.
- PRs should include a clear summary, linked issue (if any), and screenshots for UI changes.

## Agent-Specific Notes
- Parsing relies on PJATK’s ASP.NET WebForms state; avoid changing parser behavior without tests.
- Keep scraping concurrency conservative to avoid overloading the upstream server.

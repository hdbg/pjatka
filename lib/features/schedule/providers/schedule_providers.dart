import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../parsing/parsing.dart';

part 'schedule_providers.g.dart';

/// Provider for the parser singleton instance
@riverpod
PjatkParser parser(Ref ref) {
  return PjatkParser();
}

/// Family provider for fetching classes by date
@riverpod
Future<List<Class>> classes(Ref ref, DateTime date, ) async {
  final parser = ref.watch(parserProvider);

  


  return parser.parseDay(date);
}
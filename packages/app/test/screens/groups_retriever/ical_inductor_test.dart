import 'package:flutter_test/flutter_test.dart';
import 'package:pjatka/screens/groups_retriever/ics_resolver/ical_resolver.dart';

void main() {
  group('resolveGroupsFromSets', () {
    test('returns all distinct groups when each set has one group', () {
      final result = resolveGroupsFromSets([
        {'G1'},
        {'G2'},
        {'G3'},
      ]);

      expect(result, equals({'G1', 'G2', 'G3'}));
    });

    test(
        'prefers confirmed single group when a multi-group set overlaps it',
        () {
      final result = resolveGroupsFromSets([
        {'G1', 'G2'},
        {'G1'},
        {'G3'},
      ]);

      expect(result, equals({'G1', 'G3'}));
    });

    test('chooses common group across multiple ambiguous sets', () {
      final result = resolveGroupsFromSets([
        {'G1', 'G2'},
        {'G1', 'G3'},
        {'G1', 'G4'},
      ]);

      expect(result, equals({'G1'}));
    });

    test('handles a mix of singletons, overlaps, and shared ambiguous groups',
        () {
      final result = resolveGroupsFromSets([
        {'G1'},
        {'G2', 'G3'},
        {'G2', 'G4'},
        {'G2', 'G5'},
        {'G1', 'G6'},
        {'G7'},
      ]);

      expect(result, equals({'G1', 'G2', 'G7'}));
    });
  });
}

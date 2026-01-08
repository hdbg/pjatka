import 'package:canonical_adaptive_scaffold/canonical_adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class AdaptiveDispatcher {
  Widget build(BuildContext context);

  Widget buildSmall(BuildContext context) {
    return build(context);
  }

  Widget buildMediumLarge(BuildContext context) {
    return build(context);
  }

  Widget buildLarge(BuildContext context) {
    return build(context);
  }

  Widget buildExtraLarge(BuildContext context) {
    return build(context);
  }
}

typedef AdaptiveDispatcherBuilder = AdaptiveDispatcher Function();

class Destination {
  final String label;
  final String? tooltip;
  final Icon icon;
  final Icon? selectedIcon;

  final AdaptiveDispatcherBuilder main;
  final AdaptiveDispatcherBuilder? secondary;

  Destination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    required this.main,
    this.secondary,
    this.tooltip,
  });
}

final int _transitionDuration = 300;

class HomeRouter extends HookWidget {
  final List<Destination> destinations;

  HomeRouter({super.key, required this.destinations})
    : assert(destinations.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    final destination = useMemoized(() => destinations[selectedIndex.value], [
      selectedIndex.value,
    ]);
    final dispatcher = useMemoized(
      () => destinations[selectedIndex.value].main(),
      [selectedIndex.value],
    );
    final secondaryDispatcher = useMemoized(
      () => destination.secondary?.call(),
      [selectedIndex.value],
    );

    return AdaptiveScaffold(
      destinations: destinations
          .map(
            (destination) => NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.tooltip,
            ),
          )
          .toList(),

      selectedIndex: selectedIndex.value,
      onSelectedIndexChange: (index) => selectedIndex.value = index,
      transitionDuration: Duration(milliseconds: _transitionDuration),
      useDrawer: false,
      // actual render
      smallBody: dispatcher.buildSmall,
      body: dispatcher.build,
      mediumLargeBody: dispatcher.buildMediumLarge,
      largeBody: dispatcher.buildLarge,
      extraLargeBody: dispatcher.buildExtraLarge,

      smallSecondaryBody: secondaryDispatcher?.buildSmall,
      secondaryBody: secondaryDispatcher?.build,
      mediumLargeSecondaryBody: secondaryDispatcher?.buildMediumLarge,
      largeSecondaryBody: secondaryDispatcher?.buildLarge,
      extraLargeSecondaryBody: secondaryDispatcher?.buildExtraLarge,
    );
  }
}

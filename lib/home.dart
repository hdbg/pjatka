import 'package:canonical_adaptive_scaffold/canonical_adaptive_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

abstract class AdaptiveDispatcher {
  Widget build(BuildContext context);

  Widget buildSmall(BuildContext context) {
    return build(context);
  }

  Widget buildMediumLarge(BuildContext context) {
    return build(context);
  }

  Widget buildLarge(BuildContext context) {
    return buildMediumLarge(context);
  }

  Widget buildExtraLarge(BuildContext context) {
    return buildExtraLarge(context);
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

class Switcher extends StatelessWidget {
  final Widget? child;

  const Switcher({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: _transitionDuration),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: child,
    );
  }
}

WidgetBuilder? patchAnimated<T>(WidgetBuilder? input) {
  if (input == null) return null;
  return (context) => Switcher(child: input(context));
}

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
      useDrawer: true,
      // actual render
      leadingExtendedNavRail: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/icon.png'), height: 10.w),
          Text(
            ' PJATK ',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      smallBody: patchAnimated(dispatcher.buildSmall),
      body: patchAnimated(dispatcher.build),
      mediumLargeBody: patchAnimated(dispatcher.buildMediumLarge),
      largeBody: patchAnimated(dispatcher.buildLarge),
      extraLargeBody: patchAnimated(dispatcher.buildExtraLarge),

      smallSecondaryBody: patchAnimated(secondaryDispatcher?.buildSmall),
      secondaryBody: patchAnimated(secondaryDispatcher?.build),
      mediumLargeSecondaryBody: patchAnimated(
        secondaryDispatcher?.buildMediumLarge,
      ),
      largeSecondaryBody: patchAnimated(secondaryDispatcher?.buildLarge),
      extraLargeSecondaryBody: patchAnimated(
        secondaryDispatcher?.buildExtraLarge,
      ),
    );
  }
}

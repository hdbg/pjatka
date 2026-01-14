import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_adaptive_scaffold/src/rail/navrail.dart';

class DragRail extends StatefulWidget {
  final List<NavigationRailDestination> destinations;
  final double collapsedWidth;
  final double expandedWidth;
  final int? selectedIndex;
  final bool extended;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? leadingExtended;
  final Widget? leadingCollapsed;
  final Widget? trailing;
  final void Function(int)? onDestinationSelected;
  final void Function(bool)? onExtendedChanged;
  final double? groupAlignment;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final TextStyle? selectedLabelTextStyle;
  final TextStyle? unSelectedLabelTextStyle;
  final NavigationRailLabelType? labelType;

  /// Threshold (0.0 to 1.0) at which the rail snaps to expanded/collapsed state.
  final double snapThreshold;

  const DragRail({
    super.key,
    required this.destinations,
    this.collapsedWidth = 72,
    this.expandedWidth = 200,
    this.selectedIndex,
    this.extended = false,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(kNavigationRailDefaultPadding),
    this.leadingExtended,
    this.leadingCollapsed,
    this.trailing,
    this.onDestinationSelected,
    this.onExtendedChanged,
    this.groupAlignment,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedLabelTextStyle,
    this.unSelectedLabelTextStyle,
    this.labelType = NavigationRailLabelType.none,
    this.snapThreshold = 0.8,
  });

  @override
  State<DragRail> createState() => _DragRailState();
}

class _DragRailState extends State<DragRail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  bool _isExtended = false;
  bool _isDragging = false;
  double _dragProgress = 0.0;

  double get _widthRange => widget.expandedWidth - widget.collapsedWidth;

  double get _currentWidth {
    if (_isDragging) {
      return widget.collapsedWidth + (_widthRange * _dragProgress);
    }
    return widget.collapsedWidth + (_widthRange * _widthAnimation.value);
  }

  @override
  void initState() {
    super.initState();
    _isExtended = widget.extended;
    _animationController = AnimationController(
      vsync: this,
      duration:  kThemeAnimationDuration,
      value: widget.extended ? 1.0 : 0.0,
    );
    _animationController.addListener(() {
      setState(() {});
    });
    _widthAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  void didUpdateWidget(DragRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.extended != widget.extended && !_isDragging) {
      _setExtended(widget.extended, notify: false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setExtended(bool extended, {bool notify = true}) {
    if (_isExtended == extended) return;

    setState(() {
      _isExtended = extended;
    });

    if (extended) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    if (notify) {
      widget.onExtendedChanged?.call(extended);
    }
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragProgress = _isExtended ? 1.0 : 0.0;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      // Calculate progress change based on drag delta
      final delta = details.delta.dx / _widthRange;
      _dragProgress = (_dragProgress + delta).clamp(0.0, 1.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!_isDragging) return;

    final shouldExpand = _dragProgress >= widget.snapThreshold;

    // Set animation controller to current drag position before animating
    _animationController.value = _dragProgress;

    setState(() {
      _isDragging = false;
    });

    // Always animate to target state (even if state doesn't change)
    if (shouldExpand) {
      _animationController.forward();
      if (!_isExtended) {
        _isExtended = true;
        widget.onExtendedChanged?.call(true);
      }
    } else {
      _animationController.reverse();
      if (_isExtended) {
        _isExtended = false;
        widget.onExtendedChanged?.call(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // During drag, base extended state purely on drag progress
    // Otherwise, use the actual extended state
    final showExtendedLabels = _isDragging
        ? _dragProgress >= widget.snapThreshold
        : _isExtended;

    final navrail = IntrinsicHeight(
      child: ControllableNavRail(
        minWidth: widget.collapsedWidth,
        minExtendedWidth: widget.expandedWidth,
        labelType: widget.labelType,
        leading: showExtendedLabels
            ? widget.leadingExtended
            : widget.leadingCollapsed,
        trailing: widget.trailing,
        onDestinationSelected: widget.onDestinationSelected,
        groupAlignment: widget.groupAlignment,
        backgroundColor: widget.backgroundColor,
        extended: showExtendedLabels,
        extendedController: _animationController,
        selectedIndex: widget.selectedIndex,
        selectedIconTheme: widget.selectedIconTheme,
        unselectedIconTheme: widget.unselectedIconTheme,
        selectedLabelTextStyle: widget.selectedLabelTextStyle,
        unselectedLabelTextStyle: widget.unSelectedLabelTextStyle,
        destinations: widget.destinations,
        scrollable: false,
      ),
    );

    return Padding(
      padding: widget.padding,
      child: SizedBox(
        width: _currentWidth,
        height: MediaQuery.sizeOf(context).height,
        child: GestureDetector(
          onHorizontalDragStart: _onHorizontalDragStart,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          behavior: HitTestBehavior.opaque,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: navrail,
              );
            },
          ),
        ),
      ),
    );
  }
}

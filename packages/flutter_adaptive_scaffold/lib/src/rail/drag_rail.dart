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

  /// Maximum opacity of the scrim overlay when the rail is fully expanded.
  final double scrimMaxOpacity;

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
    this.scrimMaxOpacity = 0.5,
    this.snapThreshold = 0.8,
  });

  @override
  State<DragRail> createState() => _DragRailState();
}

class _DragRailState extends State<DragRail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _layerLink = LayerLink();

  bool _isExtended = false;
  bool _isDragging = false;
  double _dragProgress = 0.0;

  double get _widthRange => widget.expandedWidth - widget.collapsedWidth;

  double get _expandProgress {
    if (_isDragging) return _dragProgress;
    return _widthAnimation.value;
  }

  double get _currentWidth {
    return widget.collapsedWidth + (_widthRange * _expandProgress);
  }

  @override
  void initState() {
    super.initState();
    _isExtended = widget.extended;
    _animationController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: widget.extended ? 1.0 : 0.0,
    );
    _animationController.addListener(_onAnimationTick);
    _animationController.addStatusListener(_onAnimationStatus);
    _widthAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeOut,
    );
    if (widget.extended) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showOverlay();
      });
    }
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

  void _onAnimationTick() {
    setState(() {});
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.dismissed && !_isDragging) {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    if (!_overlayController.isShowing) {
      _overlayController.show();
    }
  }

  void _hideOverlay() {
    if (_overlayController.isShowing) {
      _overlayController.hide();
    }
  }

  void _setExtended(bool extended, {bool notify = true}) {
    if (_isExtended == extended) return;

    setState(() {
      _isExtended = extended;
    });

    if (extended) {
      _showOverlay();
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
    _showOverlay();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      final delta = details.delta.dx / _widthRange;
      _dragProgress = (_dragProgress + delta).clamp(0.0, 1.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!_isDragging) return;

    final shouldExpand = _dragProgress >= widget.snapThreshold;

    _animationController.value = _dragProgress;

    setState(() {
      _isDragging = false;
    });

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

  Widget _buildNavRail({
    required bool showExtendedLabels,
    bool showLeadingTrailing = true,
  }) {
    return IntrinsicHeight(
      child: ControllableNavRail(
        minWidth: widget.collapsedWidth,
        minExtendedWidth: widget.expandedWidth,
        labelType: widget.labelType,
        leading: showLeadingTrailing
            ? (showExtendedLabels
                ? widget.leadingExtended
                : widget.leadingCollapsed)
            : null,
        trailing: showLeadingTrailing ? widget.trailing : null,
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
  }

  @override
  Widget build(BuildContext context) {
    final showExtendedLabels = _isDragging
        ? _dragProgress >= widget.snapThreshold
        : _isExtended;

    final screenHeight = MediaQuery.sizeOf(context).height;
    final overlayActive = _overlayController.isShowing;
    final resolvedPadding =
        widget.padding.resolve(Directionality.of(context));

    return Padding(
      padding: widget.padding,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: OverlayPortal(
          controller: _overlayController,
          overlayChildBuilder: (BuildContext context) {
            final progress = _expandProgress;
            return Stack(
              children: [
                // Scrim: dims main content, tapping collapses the rail
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => _setExtended(false),
                    child: ColoredBox(
                      color: Colors.black.withValues(
                        alpha: widget.scrimMaxOpacity * progress,
                      ),
                    ),
                  ),
                ),
                // Expanded rail positioned at the same location as the collapsed rail,
                // offset by negative padding so the overlay covers the full area
                CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: Offset(-resolvedPadding.left, -resolvedPadding.top),
                  child: SizedBox(
                    width: _currentWidth,
                    height: screenHeight,
                    child: GestureDetector(
                      onHorizontalDragStart: _onHorizontalDragStart,
                      onHorizontalDragUpdate: _onHorizontalDragUpdate,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      behavior: HitTestBehavior.opaque,
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints constraints) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: _buildNavRail(
                                showExtendedLabels: showExtendedLabels),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: SizedBox(
            width: widget.collapsedWidth,
            height: screenHeight,
            child: GestureDetector(
              onTap: () => _setExtended(true),
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              behavior: HitTestBehavior.opaque,
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints constraints) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: _buildNavRail(
                      showExtendedLabels: false,
                      showLeadingTrailing: !overlayActive,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

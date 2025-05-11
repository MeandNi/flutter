library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

/// Recognizes drag gestures at the edge boundaries of a scrollable widget and allows
/// the gesture to pass through to parent widgets.
///
/// In contrast to standard [HorizontalDragGestureRecognizer], this recognizer
/// can selectively reject handling certain drag gestures based on the scroll position
/// and drag direction, allowing parent widgets to handle these gestures instead.
///
/// This is particularly useful for nested scrollable widgets where you want to
/// allow edge swipes to control a parent widget (like a drawer or page view)
/// when the child scrollable is at its boundaries.
class ScrollableHorizontalDragGestureRecognizer extends HorizontalDragGestureRecognizer {
  /// Creates a gesture recognizer that detects drags and conditionally passes them through
  /// at scroll boundaries.
  ///
  /// The [scrollController], [passThroughAtStart], and [passThroughAtEnd] arguments
  /// must not be null.
  ScrollableHorizontalDragGestureRecognizer({
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
    required this.scrollController,
    this.enableStartEdgeAwareness = false,
    this.enableEndEdgeAwareness = false,
  });

  /// The scroll controller used to determine the current scroll position.
  ///
  /// This controller is used to check if the scrollable widget is at its
  /// start or end boundary.
  final ScrollController scrollController;

  /// Whether to allow right drag gestures to pass through when at the start boundary.
  ///
  /// When true, horizontal drags to the right will be ignored by this recognizer
  /// if the scrollable is at its left edge (minimum scroll extent), allowing parent
  /// widgets to handle the gesture. This is useful for nested scrollable widgets
  /// where you want to allow edge swipes to control a parent widget.
  ///
  /// Defaults to false, which means all right drag gestures will be handled by
  /// this recognizer regardless of the scroll position.
  final bool enableStartEdgeAwareness;

  /// Whether to allow left drag gestures to pass through when at the end boundary.
  ///
  /// When true, horizontal drags to the left will be ignored by this recognizer
  /// if the scrollable is at its right edge (maximum scroll extent), allowing parent
  /// widgets to handle the gesture. This is useful for nested scrollable widgets
  /// where you want to allow edge swipes to control a parent widget.
  ///
  /// Defaults to false, which means all left drag gestures will be handled by
  /// this recognizer regardless of the scroll position.
  final bool enableEndEdgeAwareness;

  /// Checks if the scrollable is at its start boundary.
  ///
  /// Returns true if the scroll offset is at or below the minimum scroll extent.
  bool get _isAtStartEdge {
    return scrollController.hasClients &&
        scrollController.offset <= scrollController.position.minScrollExtent;
  }

  /// Checks if the scrollable is at its end boundary.
  ///
  /// Returns true if the scroll offset is at or above the maximum scroll extent.
  bool get _isAtEndEdge {
    return scrollController.hasClients &&
        scrollController.offset >= (scrollController.position.maxScrollExtent) - 1;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      if (enableStartEdgeAwareness && _isAtStartEdge && event.delta.dx > 0) {
        giveUpPointer(event.pointer);
        return;
      }

      if (enableEndEdgeAwareness && _isAtEndEdge && event.delta.dx < 0) {
        giveUpPointer(event.pointer);
        return;
      }
    }
    super.handleEvent(event);
  }
}

/// Recognizes vertical drag gestures at the edge boundaries of a scrollable widget and allows
/// the gesture to pass through to parent widgets.
///
/// In contrast to standard [VerticalDragGestureRecognizer], this recognizer
/// can selectively reject handling certain drag gestures based on the scroll position
/// and drag direction, allowing parent widgets to handle these gestures instead.
///
/// This is particularly useful for nested scrollable widgets where you want to
/// allow edge swipes to control a parent widget (like a nested scroll view)
/// when the child scrollable is at its boundaries.
class ScrollableVerticalDragGestureRecognizer extends VerticalDragGestureRecognizer {
  /// Creates a gesture recognizer that detects vertical drags and conditionally passes them through
  /// at scroll boundaries.
  ///
  /// The [scrollController], [passThroughAtStart], and [passThroughAtEnd] arguments
  /// must not be null.
  ScrollableVerticalDragGestureRecognizer({
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
    required this.scrollController,
    this.enableStartEdgeAwareness = false,
    this.enableEndEdgeAwareness = false,
  });

  /// The scroll controller used to determine the current scroll position.
  ///
  /// This controller is used to check if the scrollable widget is at its
  /// top or bottom boundary.
  final ScrollController scrollController;

  /// Whether to allow right drag gestures to pass through when at the start boundary.
  ///
  /// When true, horizontal drags to the right will be ignored by this recognizer
  /// if the scrollable is at its left edge (minimum scroll extent), allowing parent
  /// widgets to handle the gesture. This is useful for nested scrollable widgets
  /// where you want to allow edge swipes to control a parent widget.
  ///
  /// Defaults to false, which means all right drag gestures will be handled by
  /// this recognizer regardless of the scroll position.
  final bool enableStartEdgeAwareness;

  /// Whether to allow left drag gestures to pass through when at the end boundary.
  ///
  /// When true, horizontal drags to the left will be ignored by this recognizer
  /// if the scrollable is at its right edge (maximum scroll extent), allowing parent
  /// widgets to handle the gesture. This is useful for nested scrollable widgets
  /// where you want to allow edge swipes to control a parent widget.
  ///
  /// Defaults to false, which means all left drag gestures will be handled by
  /// this recognizer regardless of the scroll position.
  final bool enableEndEdgeAwareness;

  bool get _isAtStartEdge {
    return scrollController.hasClients &&
        scrollController.offset <= scrollController.position.minScrollExtent;
  }

  bool get _isAtEndEdge {
    return scrollController.hasClients &&
        scrollController.offset >= (scrollController.position.maxScrollExtent) - 1;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      if (enableStartEdgeAwareness && _isAtStartEdge && event.delta.dy < 0) {
        giveUpPointer(event.pointer);
        return;
      }

      if (enableEndEdgeAwareness && _isAtEndEdge && event.delta.dy > 0) {
        giveUpPointer(event.pointer);
        return;
      }
    }
    super.handleEvent(event);
  }
}

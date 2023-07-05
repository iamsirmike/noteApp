import 'dart:ui';

import 'package:flutter/material.dart';

class AlertDialogueRoute<T> extends ModalRoute<T> {
  final bool closable;
  final Widget child;
  final String? routeName;

  AlertDialogueRoute({
    this.closable = false,
    required this.child,
    this.routeName,
  }) : super(
          settings: RouteSettings(name: routeName ?? 'CustomDialog'),
          filter: ImageFilter.blur(),
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (closable) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            _buildOverlayContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      child: Center(child: child),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

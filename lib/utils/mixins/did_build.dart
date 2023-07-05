import 'package:flutter/material.dart';

mixin DidBuild<T extends StatefulWidget> on State<T> {
  @protected
  void didBuild(BuildContext context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      didBuild(context);
    });
  }
}

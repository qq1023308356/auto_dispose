import 'dart:async';

import 'package:flutter/material.dart';

mixin StreamAutoDispose<T extends StatefulWidget> on State<T> {
  Set<StreamSubscription<dynamic>> set = <StreamSubscription<dynamic>>{};

  @override
  void dispose() {
    super.dispose();
    for (final StreamSubscription<dynamic> element in set) {
      element.cancel();
    }
  }
}

extension StreamSubscriptionExtension on StreamSubscription<dynamic> {
  StreamSubscription<dynamic> autoDispose(StreamAutoDispose<dynamic> state) {
    state.set.add(this);
    return this;
  }
}

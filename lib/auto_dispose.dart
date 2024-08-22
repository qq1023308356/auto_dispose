import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

@optionalTypeArgs
mixin StreamAutoDispose<T extends StatefulWidget> on State<T> {
  final Set<VoidCallback> set = <VoidCallback>{};

  @override
  void dispose() {
    super.dispose();
    for (final VoidCallback element in set) {
      element();
    }
    set.clear();
  }
}

extension ObjectExtension<T> on T {
  T autoDispose(StreamAutoDispose<dynamic> state, {VoidCallback? dispose}) {
    final T obj = this;
    if (dispose != null) {
      state.set.add(dispose);
    } else if (obj is StreamSubscription) {
      state.set.add(obj.cancel);
    } else if (obj is AnimationController) {
      state.set.add(obj.dispose);
    } else if (obj is FocusNode) {
      state.set.add(obj.dispose);
    } else if (obj is TextEditingController) {
      state.set.add(obj.dispose);
    } else if (obj is ScrollController) {
      state.set.add(obj.dispose);
    } else if (obj is Ticker) {
      state.set.add(obj.dispose);
    } else if (obj is OverlayEntry) {
      state.set.add(() {
        obj.remove();
        obj.dispose();
      });
    } else if (obj is Timer) {
      state.set.add(obj.cancel);
    } else if (obj is StreamController) {
      state.set.add(obj.close);
    } else if (obj is ChangeNotifier) {
      state.set.add(obj.dispose);
    }
    return obj;
  }
}

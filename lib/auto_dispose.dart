import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

@optionalTypeArgs
mixin StreamAutoDispose<T extends StatefulWidget> on State<T> {
  final Set<VoidCallback> set = <VoidCallback>{};

  @override
  void dispose() {
    for (final VoidCallback element in set) {
      element();
    }
    set.clear();
    super.dispose();
  }
}

extension ObjectExtension<T> on T {
  T autoDispose(StreamAutoDispose<dynamic> state, {void Function(T value)? dispose}) {
    final T obj = this;
    if (dispose != null) {
      state.set.add(() {
        dispose.call(this);
      });
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

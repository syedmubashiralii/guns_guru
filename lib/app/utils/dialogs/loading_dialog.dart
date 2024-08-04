import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation(),
        child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/images/app-icon.png"))
            ),
        )
      ),
    );
  }

  Animation<double> _animation() {
    final controller = AnimationController(
      vsync: const _AlwaysStoppedAnimation(),
      duration: const Duration(seconds: 2),
    )..repeat();
    return Tween(begin: 0.0, end: 1.0).animate(controller);
  }
}

// This is a helper class to provide a `TickerProvider`
class _AlwaysStoppedAnimation extends TickerProvider {
  const _AlwaysStoppedAnimation();

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

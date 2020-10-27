import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tet/Variables.dart';

enum FlipDirection {
  VERTICAL,
  HORIZONTAL,
}

class AnimationCard extends StatelessWidget {
  AnimationCard({this.child, this.animation, this.direction});

  final Widget child;
  final Animation<double> animation;
  final FlipDirection direction;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        if (direction == FlipDirection.VERTICAL) {
          transform.rotateX(animation.value);
        } else {
          transform.rotateY(animation.value);
        }
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef void BoolCallback(bool isFront);

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  /// The amount of milliseconds a turn animation will take.
  final int speed;
  final FlipDirection direction;
  final VoidCallback onFlip;
  final BoolCallback onFlipDone;

  /// When enabled, the card will flip automatically when touched. This behavior
  /// can be disabled if this is not desired. To manually flip a card from your
  /// code, you could do this:
  ///```dart
  /// GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  ///
  /// @override
  /// Widget build(BuildContext context) {
  ///   return FlipCard(
  ///     key: cardKey,
  ///     flipOnTouch: false,
  ///     front: Container(
  ///       child: RaisedButton(
  ///         onPressed: () => cardKey.currentState.toggleCard(),
  ///         child: Text('Toggle'),
  ///       ),
  ///     ),
  ///     back: Container(
  ///       child: Text('Back'),
  ///     ),
  ///   );
  /// }
  ///```
  final bool flipOnTouch;

  const FlipCard(
      {Key key,
      @required this.front,
      @required this.back,
      this.speed = 500,
      this.onFlip,
      this.onFlipDone,
      this.direction = FlipDirection.HORIZONTAL,
      this.flipOnTouch = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FlipCardState();
  }
}

class FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller1;
  Animation<double> _frontRotation;
  Animation<double> _backRotation;
  Animation<double> _translate;

  bool isFront = true;

  _updateRotations(bool isRightTap) {
    setState(() {
      bool rotateToLeft = (isFront && !isRightTap) || !isFront && isRightTap;
      _frontRotation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween(begin: 0.0, end: rotateToLeft ? (pi / 2) : (-pi / 2))
                .chain(CurveTween(curve: Curves.linear)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (-pi / 2) : (pi / 2)),
            weight: 50.0,
          ),
        ],
      ).animate(controller);
      _backRotation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(rotateToLeft ? (pi / 2) : (-pi / 2)),
            weight: 50.0,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: rotateToLeft ? (-pi / 2) : (pi / 2), end: 0.0)
                .chain(CurveTween(curve: Curves.linear)),
            weight: 50.0,
          ),
        ],
      ).animate(controller);
    });
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _updateRotations(true);
    _translate = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 0,
            end: -5 * boxSizeV,
          ),
          weight: 15),
      TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: -5 * boxSizeV,
            end: 15 * boxSizeV,
          ),
          weight: 25),
      TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: 15 * boxSizeV,
            end: -15 * boxSizeV,
          ),
          weight: 25),
      TweenSequenceItem<double>(
          tween: Tween<double>(
            begin: -15 * boxSizeV,
            end: 0,
          ),
          weight: 15),
    ]).animate(controller1);
    controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.reset();
        controller1.reset();
      }
    });
  }

  void leftRotation() {
    _toggleSide(false);
  }

  void rightRotation() {
    _toggleSide(true);
  }

  void _toggleSide(bool isRightTap) {
    _updateRotations(isRightTap);
    if (isFront) {
      controller.forward();
      isFront = false;
    } else {
      controller.reverse();
      isFront = true;
    }
  }

  void centerSpin() {
    controller1.forward();
    controller.duration = Duration(milliseconds: 100);
    controller.forward();
    controller.repeat();
    controller.duration = Duration(milliseconds: 500);
  }

  @override
  Widget build(BuildContext context) {
    final child = Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        _buildContent(front: true),
        _buildContent(front: false),
      ],
    );

    // if we need to flip the card on taps, wrap the content
    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: rightRotation,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({@required bool front}) {
    // pointer events that would reach the backside of the card should be
    // ignored
    return IgnorePointer(
      // absorb the front card when the background is active (!isFront),
      // absorb the background when the front is active
      ignoring: front ? !isFront : isFront,
      child: AnimatedBuilder(
        animation: front ? _frontRotation : _backRotation,
        builder: (BuildContext context, Widget child) {
          var transform = Matrix4.identity();
          transform.setEntry(3, 2, 0.001);
          if (widget.direction == FlipDirection.VERTICAL) {
            transform
                .rotateX(front ? _frontRotation.value : _backRotation.value);
          } else {
            transform
                .rotateY(front ? _frontRotation.value : _backRotation.value);
          }
          print(_translate.value);
          return Container(
            height: 92 * boxSizeV,
            child: Stack(children: [
              Positioned(
                  bottom: _translate.value,
                  child: Transform(
                    transform: transform,
                    alignment: Alignment.center,
                    child: child,
                  ))
            ]),
          );
        },
        child: front ? widget.front : widget.back,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }
}

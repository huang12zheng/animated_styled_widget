import 'dart:math';

import 'package:dimension/dimension.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:responsive_styled_widget/smooth_matrix4.dart';
import 'package:responsive_styled_widget/styled_widget.dart';
import 'package:simple_animations/simple_animations.dart';

import '../named_animation.dart';
import 'base.dart';

class FlipAnimation extends PresetAnimation {
  Axis direction;
  double angle;
  FlipAnimation(
      {this.direction = Axis.vertical,
      this.angle = pi,
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    SmoothMatrix4 transform = SmoothMatrix4();
    switch (direction) {
      case Axis.vertical:
        transform.rotateY(angle);
        break;
      case Axis.horizontal:
        transform.rotateX(angle);
        break;
    }

    return MultiAnimationSequence(control: control, sequences: {
      AnimationProperty
          .transform: AnimationSequence<SmoothMatrix4>(animationData: [])
        ..add(value: transform, duration: duration, delay: delay, curve: curve),
    });
  }
}

class FlashAnimation extends PresetAnimation {
  int repeats;
  FlashAnimation(
      {this.repeats = 3,
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear})
      : super(duration: duration, delay: delay, curve: curve);

  MultiAnimationSequence getAnimationSequences() {
    Duration singleDuration =
        Duration(milliseconds: (duration.inMilliseconds / repeats / 2).round());
    var sequence = AnimationSequence<double>(animationData: []);

    for (int i = 0; i < repeats; i++) {
      if (i == 0) {
        sequence.add(value: 1, duration: Duration.zero, delay: delay);
      } else {
        sequence.add(value: 1, duration: singleDuration, curve: curve);
      }
      sequence.add(value: 0, duration: singleDuration, curve: curve);
    }
    sequence.add(value: 1, duration: singleDuration, curve: curve);

    return MultiAnimationSequence(control: control, sequences: {
      AnimationProperty.opacity: sequence,
    });
  }
}

class PulseAnimation extends PresetAnimation {
  double scale;
  PulseAnimation(
      {this.scale = 1.5,
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    SmoothMatrix4 transform = SmoothMatrix4();
    transform.scale(scale);

    Duration halfDuration =
        Duration(milliseconds: (duration.inMilliseconds / 2).round());

    return MultiAnimationSequence(control: control, sequences: {
      AnimationProperty.transform:
          AnimationSequence<SmoothMatrix4>(animationData: [])
            ..add(
                value: transform,
                duration: halfDuration,
                delay: delay,
                curve: curve)
            ..add(value: SmoothMatrix4(), duration: halfDuration, curve: curve),
    });
  }
}

class SwingAnimation extends PresetAnimation {
  int repeats;
  double angle;
  Alignment alignment;
  SwingAnimation(
      {this.alignment = Alignment.topCenter,
      this.repeats = 2,
      this.angle = pi / 12,
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    Duration singleDuration =
        Duration(milliseconds: (duration.inMilliseconds / repeats / 2).round());
    var sequence = AnimationSequence<SmoothMatrix4>(animationData: []);

    for (int i = 0; i < repeats; i++) {
      if (i == 0) {
        sequence.add(
            value: SmoothMatrix4()..rotateZ(angle),
            duration: Duration.zero,
            delay: delay);
      } else {
        sequence.add(
            value: SmoothMatrix4()..rotateZ(angle - i / repeats * angle),
            duration: singleDuration,
            curve: curve);
      }

      sequence.add(
          value: SmoothMatrix4()..rotateZ(-(angle - i / repeats * angle)),
          duration: singleDuration,
          curve: curve);
    }
    sequence.add(
        value: SmoothMatrix4()..rotateZ(0),
        duration: singleDuration,
        curve: curve);

    return MultiAnimationSequence(control: control, sequences: {
      AnimationProperty.transformAlignment:
          AnimationSequence<Alignment>(animationData: [])
            ..add(value: alignment, duration: Duration.zero),
      AnimationProperty.transform: sequence,
    });
  }
}

class WobbleAnimation extends PresetAnimation {
  int repeats;
  double angle;
  Dimension translation;
  Alignment alignment;
  WobbleAnimation(
      {this.alignment = Alignment.bottomCenter,
      this.repeats = 3,
      this.angle = pi / 30,
      this.translation = const Length(5),
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    Duration singleDuration =
        Duration(milliseconds: (duration.inMilliseconds / repeats / 2).round());
    var sequence = AnimationSequence<SmoothMatrix4>(animationData: []);

    for (int i = 0; i < repeats; i++) {
      if (i == 0) {
        sequence.add(
            value: SmoothMatrix4()
              ..translate(translation)
              ..rotateZ(angle),
            duration: Duration.zero,
            delay: delay);
      } else {
        sequence.add(
            value: SmoothMatrix4()
              ..translate(translation..scale(i / repeats))
              ..rotateZ(angle - i / repeats * angle),
            duration: singleDuration,
            curve: curve);
      }

      sequence.add(
          value: SmoothMatrix4()
            ..translate(-translation
              ..scale(i / repeats))
            ..rotateZ(-(angle - i / repeats * angle)),
          duration: singleDuration,
          curve: curve);
    }
    sequence.add(
        value: SmoothMatrix4(), duration: singleDuration, curve: curve);

    return MultiAnimationSequence(control: control, sequences: {
      AnimationProperty.transformAlignment:
          AnimationSequence<Alignment>(animationData: [])
            ..add(value: alignment, duration: Duration.zero),
      AnimationProperty.transform: sequence,
    });
  }
}

class RainbowAnimation extends PresetAnimation {
  RainbowAnimation(
      {Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    Duration singleDuration =
        Duration(milliseconds: (duration.inMilliseconds / 7).round());
    var sequence = AnimationSequence<BoxDecoration>(animationData: []);

    sequence.add(
        value: BoxDecoration(color: Colors.red),
        duration: Duration.zero,
        delay: delay);
    sequence.add(
        value: BoxDecoration(color: Colors.orange),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(color: Colors.yellow),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(color: Colors.green),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(color: Colors.blue),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(color: Colors.indigo),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(color: Colors.purple),
        duration: singleDuration,
        curve: curve);

    return MultiAnimationSequence(
        control: control,
        sequences: {AnimationProperty.backgroundDecoration: sequence});
  }
}

class RainbowLinearGradientAnimation extends PresetAnimation {
  RainbowLinearGradientAnimation(
      {Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    Duration singleDuration =
        Duration(milliseconds: (duration.inMilliseconds / 7).round());
    var sequence = AnimationSequence<BoxDecoration>(animationData: []);

    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red, Colors.orange])),
        duration: Duration.zero,
        delay: delay);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.orange, Colors.yellow])),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.yellow, Colors.green])),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.green, Colors.blue])),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.indigo])),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.indigo, Colors.purple])),
        duration: singleDuration,
        curve: curve);
    sequence.add(
        value: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
        duration: singleDuration,
        curve: curve);

    return MultiAnimationSequence(
        control: control,
        sequences: {AnimationProperty.backgroundDecoration: sequence});
  }
}

class ElevateAnimation extends PresetAnimation {
  int beginElevation;
  int endElevation;
  ElevateAnimation(
      {this.beginElevation = 1,
      this.endElevation = 6,
      Duration duration = const Duration(seconds: 1),
      Duration delay = Duration.zero,
      Curve curve = Curves.linear,
      CustomAnimationControl control = CustomAnimationControl.PLAY})
      : assert(preDefinedDynamicShapeShadow.containsKey(beginElevation)),
        assert(preDefinedDynamicShapeShadow.containsKey(endElevation)),
        super(duration: duration, delay: delay, curve: curve, control: control);

  MultiAnimationSequence getAnimationSequences() {
    var sequence = AnimationSequence<List<DynamicShadow>>(animationData: []);

    sequence.add(
        value: preDefinedDynamicShapeShadow[beginElevation]!,
        delay: delay,
        duration: Duration.zero);
    sequence.add(
        value: preDefinedDynamicShapeShadow[endElevation]!, duration: duration);

    return MultiAnimationSequence(
        control: control, sequences: {AnimationProperty.shadows: sequence});
  }
}

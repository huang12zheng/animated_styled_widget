import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'animation_sequence.dart';
import 'global_animation.dart';

class GlobalAnimationNotifier extends ChangeNotifier {
  Map<String, GlobalAnimation> animationPool = {};

  Map<String, String> currentAnimationNames = {};
  Map<String, MultiAnimationSequence> currentAnimations = {};
  Map<String, CustomAnimationControl> currentAnimationsControl = {};

  Map<String, MultiAnimationSequence> currentContinuousAnimations = {};
  Map<String, String> currentContinuousAnimationNames = {};
  Map<String, ContinuousAnimationProgressNotifier> animationProgressNotifiers =
      {};
  GlobalAnimationNotifier({required this.animationPool});

  void updateAnimationStatus(
      String animationId, CustomAnimationControl newStatus) {
    animationPool[animationId]?.sequences.forEach((applier, value) {
      currentAnimations[applier] = value;
      currentAnimationsControl[applier] = newStatus;
    });
    notifyListeners();
  }

  void updateContinuousAnimationStatus(String animationId, bool running) {
    animationPool[animationId]?.sequences.forEach((applier, value) {
      if (running) {
        currentContinuousAnimationNames[applier] = animationId;
        currentContinuousAnimations[applier] = value;
      } else {
        currentContinuousAnimationNames.remove(applier);
        currentContinuousAnimations.remove(applier);
      }
    });
    notifyListeners();
  }
}

class LocalAnimationNotifier extends ChangeNotifier {
  MultiAnimationSequence? currentAnimation;
  CustomAnimationControl? currentAnimationControl;

  MultiAnimationSequence? currentContinuousAnimation;
  ContinuousAnimationProgressNotifier? animationProgressNotifier;

  LocalAnimationNotifier();

  void updateAnimationStatus(MultiAnimationSequence animationSequence,
      CustomAnimationControl newStatus) {
    currentAnimation = animationSequence;
    currentAnimationControl = newStatus;
    notifyListeners();
  }

  void updateContinuousAnimationStatus(
      MultiAnimationSequence? animationSequence, bool running) {
    if (running) {
      currentContinuousAnimation = animationSequence;
    } else {
      currentContinuousAnimation = null;
    }

    notifyListeners();
  }
}

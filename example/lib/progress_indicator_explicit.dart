import 'dart:math';

import 'package:dimension/dimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:responsive_styled_widget/styled_widget.dart';
import 'package:simple_animations/simple_animations.dart';

class ProgressIndicatorExplicitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisibilityDetectorController.instance.updateInterval =
        Duration(milliseconds: 1);
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text("Explicit Progress Container"),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: MyHomePage()));
    });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    DynamicBorderSide startBorder = DynamicBorderSide(
        width: 10,
        begin: 0.toPercentLength,
        end: 0.toPercentLength,
        gradient: SweepGradient(startAngle: pi, colors: [
          Colors.amberAccent,
          Colors.redAccent,
          Colors.redAccent,
          Colors.amberAccent,
        ]));
    DynamicBorderSide middleBorder = DynamicBorderSide(
        width: 10,
        begin: 0.toPercentLength,
        end: 50.toPercentLength,
        shift: 50.toPercentLength,
        gradient: SweepGradient(startAngle: pi, colors: [
          Colors.amberAccent,
          Colors.redAccent,
          Colors.redAccent,
          Colors.amberAccent,
        ]));
    DynamicBorderSide endBorder = DynamicBorderSide(
        width: 10,
        begin: 100.toPercentLength,
        end: 100.toPercentLength,
        shift: 100.toPercentLength,
        gradient: SweepGradient(startAngle: pi, colors: [
          Colors.amberAccent,
          Colors.redAccent,
          Colors.redAccent,
          Colors.amberAccent,
        ]));

    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: [
            ExplicitAnimatedStyledContainer(
              style: Style(
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                width: 150.toPXLength,
                height: 150.toPXLength,
                padding: DynamicEdgeInsets.symmetric(vertical: 20.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: CircleShape(border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder:
                          AnimationSequence<MorphableShapeBorder>()
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: CircleShape(border: middleBorder),
                                ))
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: CircleShape(border: endBorder),
                                )),
                    }),
              },
              child: Text("LOADING"),
            ),
            ExplicitAnimatedStyledContainer(
              style: Style(
                width: 150.toPXLength,
                height: 150.toPXLength,
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                padding: DynamicEdgeInsets.symmetric(vertical: 20.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: RectangleShape(border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder:
                          AnimationSequence<MorphableShapeBorder>()
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: RectangleShape(border: middleBorder),
                                ))
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: RectangleShape(border: endBorder),
                                )),
                    }),
              },
              child: Text("LOADING"),
            ),
            ExplicitAnimatedStyledContainer(
              style: Style(
                width: 150.toPXLength,
                height: 150.toPXLength,
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                padding: DynamicEdgeInsets.symmetric(vertical: 30.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: PolygonShape(
                        sides: 6,
                        cornerRadius: 20.toPercentLength,
                        border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder:
                          AnimationSequence<MorphableShapeBorder>()
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: PolygonShape(
                                      sides: 6,
                                      cornerRadius: 30.toPercentLength,
                                      border: middleBorder),
                                ))
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: PolygonShape(
                                      sides: 6,
                                      cornerRadius: 30.toPercentLength,
                                      border: endBorder),
                                )),
                    }),
              },
              child: Text("LOADING"),
            ),
            ExplicitAnimatedStyledContainer(
              style: Style(
                width: 250.toPXLength,
                height: 100.toPXLength,
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                padding: DynamicEdgeInsets.symmetric(vertical: 30.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: RectangleShape(
                        borderRadius: DynamicBorderRadius.all(
                            DynamicRadius.circular(50.toPXLength)),
                        border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder: AnimationSequence<
                          MorphableShapeBorder>()
                        ..add(
                            duration: Duration(milliseconds: 1000),
                            value: MorphableShapeBorder(
                              shape: RectangleShape(
                                  borderRadius: DynamicBorderRadius.all(
                                      DynamicRadius.circular(50.toPXLength)),
                                  border: middleBorder),
                            ))
                        ..add(
                            duration: Duration(milliseconds: 1000),
                            value: MorphableShapeBorder(
                              shape: RectangleShape(
                                  borderRadius: DynamicBorderRadius.all(
                                      DynamicRadius.circular(50.toPXLength)),
                                  border: endBorder),
                            )),
                    }),
              },
              child: Text("LOADING"),
            ),
            ExplicitAnimatedStyledContainer(
              style: Style(
                width: 150.toPXLength,
                height: 150.toPXLength,
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                padding: DynamicEdgeInsets.symmetric(vertical: 30.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: RectangleShape(
                        borderRadius: DynamicBorderRadius.all(
                            DynamicRadius.circular(50.toPercentLength)),
                        border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder:
                          AnimationSequence<MorphableShapeBorder>()
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: RectangleShape(
                                      borderRadius: DynamicBorderRadius.all(
                                          DynamicRadius.circular(
                                              0.toPercentLength)),
                                      border: middleBorder),
                                ))
                            ..add(
                                duration: Duration(milliseconds: 1000),
                                value: MorphableShapeBorder(
                                  shape: RectangleShape(
                                      borderRadius: DynamicBorderRadius.all(
                                          DynamicRadius.circular(
                                              50.toPercentLength)),
                                      border: endBorder),
                                )),
                    }),
              },
              child: Text("LOADING"),
            ),
            ExplicitAnimatedStyledContainer(
              style: Style(
                width: 150.toPXLength,
                height: 150.toPXLength,
                alignment: Alignment.center,
                childAlignment: Alignment.center,
                padding: DynamicEdgeInsets.symmetric(vertical: 30.toPXLength),
                backgroundDecoration: BoxDecoration(color: Colors.white),
                shapeBorder: MorphableShapeBorder(
                    shape: RectangleShape(
                        cornerStyles:
                            RectangleCornerStyles.all(CornerStyle.straight),
                        borderRadius: DynamicBorderRadius.all(
                            DynamicRadius.circular(50.toPXLength)),
                        border: startBorder)),
              ),
              localAnimations: {
                AnimationTrigger.visible: MultiAnimationSequence(
                    control: CustomAnimationControl.LOOP,
                    sequences: {
                      AnimationProperty.shapeBorder: AnimationSequence<
                          MorphableShapeBorder>()
                        ..add(
                            duration: Duration(milliseconds: 1000),
                            value: MorphableShapeBorder(
                              shape: RectangleShape(
                                  cornerStyles: RectangleCornerStyles.all(
                                      CornerStyle.straight),
                                  borderRadius: DynamicBorderRadius.all(
                                      DynamicRadius.circular(0.toPXLength)),
                                  border: middleBorder),
                            ))
                        ..add(
                            duration: Duration(milliseconds: 1000),
                            value: MorphableShapeBorder(
                              shape: RectangleShape(
                                  cornerStyles: RectangleCornerStyles.all(
                                      CornerStyle.straight),
                                  borderRadius: DynamicBorderRadius.all(
                                      DynamicRadius.circular(50.toPXLength)),
                                  border: endBorder),
                            )),
                    }),
              },
              child: Text("LOADING"),
            ),
          ],
        ),
      ),
    );
  }
}

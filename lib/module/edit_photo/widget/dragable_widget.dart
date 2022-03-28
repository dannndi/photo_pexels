import 'package:flutter/material.dart';

abstract class DragableWidgetChild {}

class DragableWidgetTextChild extends DragableWidgetChild {
  DragableWidgetTextChild({
    required this.text,
    this.textAlign,
    this.textStyle,
    this.color = Colors.white,
    this.fontSize = 16,
    this.fontStyle,
    this.fontWeight,
  });

  String text;
  TextAlign? textAlign;
  TextStyle? textStyle;
  Color? color;
  double? fontSize;
  FontStyle? fontStyle;
  FontWeight? fontWeight;

  DragableWidgetTextChild copyWith({
    String? text,
    TextAlign? textAlign,
    TextStyle? textStyle,
    Color? color,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
  }) {
    return DragableWidgetTextChild(
      text: text ?? this.text,
      textAlign: textAlign ?? this.textAlign,
      textStyle: textStyle ?? this.textStyle,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}

class DragableWidget extends StatelessWidget {
  DragableWidget({
    Key? key,
    required this.child,
    required this.uniqueKey,
    this.onTap,
    this.onLongPress,
    this.clickable = true,
    this.dragable = true,
  }) : super(key: key);

  DragableWidgetChild child;
  final int uniqueKey;
  final void Function(int, DragableWidgetChild)? onTap;
  final void Function(int)? onLongPress;
  final bool clickable;
  final bool dragable;

  final ValueNotifier<Offset> possition = ValueNotifier<Offset>(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      key: UniqueKey(),
      valueListenable: possition,
      builder: (context, value, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              value.dx,
              value.dy,
            ),
          child: child,
        );
      },
      child: GestureDetector(
        key: UniqueKey(),
        onTap: () {
          if (!clickable) return;
          if (onTap == null) return;
          onTap!(uniqueKey, child);
        },
        onLongPress: () {
          if (!clickable) return;
          if (onLongPress == null) return;
          onLongPress!(uniqueKey);
        },
        onPanUpdate: (details) {
          if (!dragable) return;
          possition.value += details.delta;
        },
        child: _buildChild(child),
      ),
    );
  }

  Widget _buildChild(DragableWidgetChild child) {
    if (child is DragableWidgetTextChild) {
      return Text(
        child.text,
        key: UniqueKey(),
        textAlign: child.textAlign,
        style: child.textStyle?.copyWith(
          fontSize: child.fontSize,
          color: child.color,
          fontStyle: child.fontStyle,
          fontWeight: child.fontWeight,
        ),
      );
    }
    return Container();
  }
}

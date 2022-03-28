import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_pexels/theme/theme_application.dart';

import '../../widget/dragable_widget.dart';

Future<T?> addText<T>(
  BuildContext context, [
  DragableWidgetTextChild? text,
]) async {
  return showDialog(
    context: context,
    useSafeArea: false,
    builder: (_) {
      return AddTextPage(text: text);
    },
  );
}

class AddTextPage extends StatefulWidget {
  AddTextPage({Key? key, this.text}) : super(key: key);
  DragableWidgetTextChild? text;

  @override
  State<AddTextPage> createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
  late TextEditingController _textController;
  late ValueNotifier<DragableWidgetTextChild> _valueListener;

  final colors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.pink,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.amber,
    Colors.orange,
  ];

  final fonts = [
    GoogleFonts.robotoMono(),
    GoogleFonts.smokum(),
    GoogleFonts.paletteMosaic(),
    GoogleFonts.hurricane(),
    GoogleFonts.redHatMono(),
    GoogleFonts.inconsolata(),
    GoogleFonts.bebasNeue(),
    GoogleFonts.dancingScript(),
    GoogleFonts.pacifico(),
    GoogleFonts.shadowsIntoLight(),
    GoogleFonts.indieFlower(),
  ];

  @override
  void initState() {
    _textController = TextEditingController(text: widget.text?.text ?? "");
    _valueListener = ValueNotifier<DragableWidgetTextChild>(
      widget.text ??
          DragableWidgetTextChild(
            text: "",
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.robotoMono(),
          ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ValueListenableBuilder<DragableWidgetTextChild>(
                  valueListenable: _valueListener,
                  builder: (context, value, _) {
                    return TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      textAlign: value.textAlign ?? TextAlign.center,
                      textInputAction: TextInputAction.newline,
                      style: value.textStyle?.copyWith(
                        color: value.color,
                        fontSize: value.fontSize,
                        fontWeight: value.fontWeight,
                        fontStyle: value.fontStyle,
                      ),
                      autofocus: true,
                      maxLines: 5,
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_textController.text.isEmpty) {
                  return Navigator.pop(context);
                }

                var result = DragableWidgetTextChild(
                  text: _textController.text,
                  color: _valueListener.value.color,
                  fontSize: _valueListener.value.fontSize,
                  fontStyle: _valueListener.value.fontStyle,
                  fontWeight: _valueListener.value.fontWeight,
                  textAlign: _valueListener.value.textAlign,
                  textStyle: _valueListener.value.textStyle,
                );
                Navigator.pop(context, result);
              },
              child: Text(
                "Done",
                style: ThemeApplication.h3.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: ValueListenableBuilder<DragableWidgetTextChild>(
              valueListenable: _valueListener,
              builder: (context, value, _) {
                return Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.format_align_left_rounded,
                        color: value.textAlign == TextAlign.left
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        _valueListener.value = _valueListener.value.copyWith(
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_align_center_rounded,
                        color: value.textAlign == TextAlign.center
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        _valueListener.value = _valueListener.value.copyWith(
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_align_right_rounded,
                        color: value.textAlign == TextAlign.right
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        _valueListener.value = _valueListener.value.copyWith(
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_italic_rounded,
                        color: value.fontStyle == FontStyle.italic
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        if (value.fontStyle == FontStyle.italic) {
                          _valueListener.value = _valueListener.value.copyWith(
                            fontStyle: FontStyle.normal,
                          );
                        } else {
                          _valueListener.value = _valueListener.value.copyWith(
                            fontStyle: FontStyle.italic,
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_bold_rounded,
                        color: value.fontWeight == FontWeight.bold
                            ? Colors.blue
                            : Colors.white,
                      ),
                      onPressed: () {
                        if (value.fontWeight == FontWeight.bold) {
                          _valueListener.value = _valueListener.value.copyWith(
                            fontWeight: FontWeight.normal,
                          );
                        } else {
                          _valueListener.value = _valueListener.value.copyWith(
                            fontWeight: FontWeight.bold,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            left: 16,
            top: MediaQuery.of(context).padding.top + 70,
            bottom: 140,
            child: RotatedBox(
              quarterTurns: 3,
              child: ValueListenableBuilder<DragableWidgetTextChild>(
                valueListenable: _valueListener,
                builder: (context, value, _) {
                  return Slider(
                    value: value.fontSize ?? 0,
                    min: 12,
                    max: 52,
                    onChanged: (fontSize) {
                      _valueListener.value = _valueListener.value.copyWith(
                        fontSize: fontSize,
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 70,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ValueListenableBuilder<DragableWidgetTextChild>(
                valueListenable: _valueListener,
                builder: (context, value, _) {
                  return ListView(
                    padding: const EdgeInsets.only(right: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: fonts.map((font) {
                      return GestureDetector(
                        onTap: () {
                          _valueListener.value = _valueListener.value.copyWith(
                            textStyle: font,
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(
                            left: 16,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: value.textStyle == font
                                ? Colors.white
                                : Colors.black.withOpacity(0.5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Aa",
                            style: font.copyWith(
                              fontSize: 20,
                              color: value.textStyle == font
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 20,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ValueListenableBuilder<DragableWidgetTextChild>(
                valueListenable: _valueListener,
                builder: (context, value, _) {
                  return ListView(
                    padding: const EdgeInsets.only(right: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          _valueListener.value = _valueListener.value.copyWith(
                            color: color,
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: const EdgeInsets.only(
                            left: 16,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                            border: value.color == color
                                ? Border.all(width: 4, color: Colors.blue)
                                : null,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

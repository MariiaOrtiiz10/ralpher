import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

class ColorPickerItem extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerItem({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
  });

  @override
  State<ColorPickerItem> createState() => _ColorPickerItemState();
}

class _ColorPickerItemState extends State<ColorPickerItem> {
  late ValueNotifier<Color> _colorNotifier;

  @override
  void initState() {
    super.initState();
    _colorNotifier = ValueNotifier<Color>(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.4,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            children: [
              // Botón de cerrar (cruz)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context, _colorNotifier.value);
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ValueListenableBuilder<Color>(
                      valueListenable: _colorNotifier,
                      builder: (context, color, child) {
                        return ColorPicker(
                          color: color,
                          onChanged: (value) {
                            _colorNotifier.value = value;
                            widget.onColorChanged(value); // Notifica a HomePage
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

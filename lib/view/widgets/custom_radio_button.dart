import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class CustomRadioButton extends StatefulWidget {
  final Function(bool) onChanged;
  final bool value;
  final bool isRadio;
  final Color? color;
  final Color? fillColor;
  final bool isEnabled;

  const CustomRadioButton({
    Key? key,
    required this.onChanged,
    required this.value,
    this.color,
    this.fillColor,
    this.isRadio = true,
    this.isEnabled = true,
  }) : super(key: key);
  const CustomRadioButton.check({
    Key? key,
    required this.onChanged,
    required this.value,
    this.color,
    this.fillColor,
    this.isRadio = false,
    this.isEnabled = true,
  }) : super(key: key);
  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        !widget.isEnabled;
        setState(() {
          isSelected = !isSelected;
        });
        widget.onChanged(isSelected);
      },
      child: Container(
        height: 23,
        width: 23,
        padding: !widget.isRadio ? EdgeInsets.zero : const EdgeInsets.all(2),
        decoration: BoxDecoration(
            shape: widget.isRadio ? BoxShape.circle : BoxShape.rectangle,
            border: Border.all(
                color: widget.color != null
                    ? widget.color!
                    : !widget.isEnabled || (!widget.value && !widget.isRadio)
                        ? disableColor
                        : Theme.of(context).primaryColor,
                width: 3),
            color: widget.fillColor ?? Colors.transparent,
            borderRadius: widget.isRadio ? null : BorderRadius.circular(6)),
        child: widget.value
            ? widget.isRadio
                ? Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !widget.isEnabled
                            ? disableColor
                            : widget.color ?? Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: !widget.isEnabled
                            ? disableColor
                            : widget.color ?? Theme.of(context).primaryColor,
                        border: Border.all(
                          color: !widget.isEnabled
                              ? disableColor
                              : widget.color ?? Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  )
            : Container(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    required this.parent,
    required this.children,
    this.parentCheckboxColor,
    this.childrenCheckboxColor,
    this.parentCheckboxScale,
    this.childrenCheckboxScale,
    this.gap,
  });

  final Text? parent;
  final List<Text>? children;
  final Color? parentCheckboxColor;
  final Color? childrenCheckboxColor;
  final double? parentCheckboxScale;
  final double? childrenCheckboxScale;
  final double? gap;

  static Map<String?, bool?> _isParentSelected = {};
  static Map<String?, List<String?>> _selectedChildrenMap = {};

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool? _parentValue = false;

  List<bool?> _childrenValue = [];

  @override
  void initState() {
    super.initState();
    _childrenValue = List.filled(widget.children!.length, false);
    CustomCheckbox._selectedChildrenMap.addAll({widget.parent!.data: []});
    CustomCheckbox._isParentSelected.addAll({widget.parent!.data: false});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Transform.scale(
              scale: widget.parentCheckboxScale ?? 1.0,
              child: Checkbox(
                value: _parentValue,
                splashRadius: 0.0,
                activeColor: widget.parentCheckboxColor,
                onChanged: (value) => _parentCheckBoxClick(),
                tristate: true,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            widget.parent!,
          ],
        ),
        SizedBox(
          height: widget.gap ?? 1.0,
        ),
        for (int i = 0; i < widget.children!.length; i++)
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: [
                Transform.scale(
                  scale: widget.childrenCheckboxScale ?? 1.0,
                  child: Checkbox(
                    splashRadius: 0.0,
                    activeColor: widget.childrenCheckboxColor,
                    value: _childrenValue[i],
                    onChanged: (value) => _childCheckBoxClick(i),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                widget.children![i],
              ],
            ),
          ),
      ],
    );
  }

  void _childCheckBoxClick(int i) {
    setState(() {
      _childrenValue[i] = !_childrenValue[i]!;
      if (!_childrenValue[i]!) {
        CustomCheckbox._selectedChildrenMap.update(widget.parent!.data,
            (value) {
          value.removeWhere((element) => element == widget.children![i].data);
          return value;
        });
      } else {
        CustomCheckbox._selectedChildrenMap.update(widget.parent!.data,
            (value) {
          value.add(widget.children![i].data);
          return value;
        });
      }
      _parentCheckboxUpdate();
    });
  }

  void _parentCheckBoxClick() {
    setState(() {
      if (_parentValue != null) {
        _parentValue = !_parentValue!;
        CustomCheckbox._isParentSelected
            .update(widget.parent!.data, (value) => _parentValue);
        CustomCheckbox._selectedChildrenMap.addAll({
          widget.parent!.data: [],
        });
        for (int i = 0; i < widget.children!.length; i++) {
          _childrenValue[i] = _parentValue;
          if (_parentValue!) {
            CustomCheckbox._selectedChildrenMap.update(widget.parent!.data,
                (value) {
              value.add(widget.children![i].data);
              return value;
            });
          }
        }
      } else {
        _parentValue = false;
        CustomCheckbox._isParentSelected
            .update(widget.parent!.data, (value) => _parentValue);
        CustomCheckbox._selectedChildrenMap
            .update(widget.parent!.data, (value) => []);
        for (int i = 0; i < widget.children!.length; i++) {
          _childrenValue[i] = false;
        }
      }
    });
  }

  void _parentCheckboxUpdate() {
    setState(() {
      if (_childrenValue.contains(false) && _childrenValue.contains(true)) {
        _parentValue = null;
        CustomCheckbox._isParentSelected
            .update(widget.parent!.data, (value) => false);
      } else {
        _parentValue = _childrenValue.first;
        CustomCheckbox._isParentSelected
            .update(widget.parent!.data, (value) => _childrenValue.first);
      }
    });
  }
}

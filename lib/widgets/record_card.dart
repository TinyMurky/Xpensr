import 'package:flutter/material.dart';
import 'package:xpensr/core/constants/colors.dart';

import 'package:xpensr/core/dto/record_dto.dart';
import 'package:xpensr/core/utils/color.dart';
import 'package:xpensr/widgets/styles/record_type_style.dart';

class RecordCard extends StatefulWidget {
  final RecordDto recordDto;

  final RecordTypeStyle recordTypeStyle;

  RecordCard({
    super.key,
    required this.recordDto,
  }) : recordTypeStyle = RecordTypeStyle.getStyle(recordDto.type);

  @override
  State<RecordCard> createState() {
    return _RecordCardState();
  }
}

class _RecordCardState extends State<RecordCard> {
  // ListTitle Reference:
  // https://api.flutter.dev/flutter/material/ListTile-class.html
  final bool _enabled = true;
  bool _selected = false;

  /// Set _selected state of listTile Reverse when user tab listTile
  void _listTileOnTab() {
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final Color selectedIconColor = rhoneBlue;
    final Color selectedCircleAvatarBackGroundColor =
        makeColorMorePinky(color: byzantiumBlue, lightenDegree: 2.5);
    final Color circleAvatarBackGroundColor =
        widget.recordTypeStyle.lightenColor;

    Color switchColorBaseOnWidgetState({
      required Color selectedColor,
      required Color defaultColor,
    }) {
      if (!_enabled) return colorScheme.error;
      if (_selected) return selectedColor;
      return defaultColor;
    }

    return Card(
      elevation: _selected ? 1 : 4, // This control shadow
      child: ListTile(
        enabled: _enabled,
        selected: _selected,
        onTap: _listTileOnTab,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: switchColorBaseOnWidgetState(
            selectedColor: selectedCircleAvatarBackGroundColor,
            defaultColor: circleAvatarBackGroundColor,
          ),
          child: Icon(
            widget.recordTypeStyle.icon,
            color: switchColorBaseOnWidgetState(
              selectedColor: selectedIconColor,
              defaultColor: widget.recordTypeStyle.color,
            ),
          ),
        ),
        title: Text(
          // Record name that user input
          widget.recordDto.title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          // Display name of recordType
          widget.recordTypeStyle.displayedName,
          style: TextStyle(
            color: changeColorLightness(
                color: colorScheme.onSurface, amount: -0.2),
          ),
        ),
        trailing: Text(
          widget.recordDto.toLocalAmountString(),
          style: TextStyle(
            color: widget.recordDto.localAmount < 0
                ? colorScheme.error
                : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

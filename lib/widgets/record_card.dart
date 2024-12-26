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
    final Brightness brightness = theme.brightness;
    final ColorScheme colorScheme = theme.colorScheme;

    final Color selectedIconColor = rhoneBlue;
    final Color selectedIconBackGroundColor = brightness == Brightness.light
        ? changeColorLightness(color: rhoneBlue, amount: 0.1)
        : changeColorLightness(color: rhoneBlue, amount: -0.1);

    return Card(
      child: ListTile(
        enabled: _enabled,
        selected: _selected,
        onTap: _listTileOnTab,
        leading: FittedBox(
          child: CircleAvatar(
            backgroundColor: WidgetStateColor.fromMap(
              <WidgetStatesConstraint, Color>{
                WidgetState.disabled: colorScheme.error,
                WidgetState.selected: selectedIconBackGroundColor,
                WidgetState.any: widget.recordTypeStyle.color,
              },
            ),
            child: Icon(
              widget.recordTypeStyle.icon,
              color: WidgetStateColor.fromMap(
                <WidgetStatesConstraint, Color>{
                  WidgetState.disabled: colorScheme.onError,
                  WidgetState.selected: selectedIconColor,
                  WidgetState.any: widget.recordTypeStyle.color,
                },
              ),
            ),
          ),
        ),
        textColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.error;
          }
          if (states.contains(WidgetState.selected)) {
            return rhoneBlue;
          }
          return colorScheme.onSurface;
        }),
        title: Text(
          // Record name that user input
          widget.recordDto.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          // Display name of recordType
          widget.recordTypeStyle.displayedName,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        trailing: Text(
          widget.recordDto.toLocalAmountString(),
          style: TextStyle(
            color: widget.recordDto.localAmount < 0 ? colorScheme.error : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

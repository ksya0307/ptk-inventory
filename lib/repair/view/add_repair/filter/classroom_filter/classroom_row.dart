import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class ClassroomRow extends StatefulWidget {
  final String label;
  final void Function(bool) onSelect;
  const ClassroomRow({Key? key, required this.label, required this.onSelect})
      : super(key: key);

  @override
  State<ClassroomRow> createState() => _ClassroomRowState();
}

class _ClassroomRowState extends State<ClassroomRow> {
  final bool _isSelected = false;
  final Color _color = greyCard;
  final Color _textColor = blackLabels;
  //_color == secondaryGreen
  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipTheme.of(context).copyWith(
        elevation: 0,
        pressElevation: 0,
        backgroundColor: _isSelected ? secondaryGreen : greyCard,
        selectedColor: secondaryGreen,
        checkmarkColor: Colors.white,
      ),
      child: ChoiceChip(
        avatar: _isSelected
            ? const Icon(Icons.done_rounded, color: Colors.white)
            : null,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        selected: _isSelected,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        label: Text(
          widget.label,
        ),
        labelStyle: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: _textColor,
        ),
        onSelected: widget.onSelect,
      ),
    );
  }
}

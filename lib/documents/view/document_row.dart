import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class DocumentRow extends StatelessWidget {
  final String id;
  final String document;
  final bool last;
  const DocumentRow({
    Key? key,
    required this.id,
    required this.document,
    required this.last,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  left: 12,
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    id,
                    style: const TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 16,
                      color: blackLabels,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  document,
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 16,
                    color: blackLabels,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (!last)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Divider(
              color: greyDivider,
              thickness: .75,
            ),
          )
        else
          const Padding(padding: EdgeInsets.only(bottom: 12)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ptk_inventory/config/colors.dart';

class IfoRow extends StatelessWidget {
  final String id;
  final String ifo;
  final bool last;
  const IfoRow({
    Key? key,
    required this.id,
    required this.ifo,
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
                  top: 8 + 4,
                  bottom: 8 + 4,
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
                  ifo,
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

import 'package:flutter/material.dart';

import 'package:ptk_inventory/config/colors.dart';

class EquipmentFilterSheet extends StatelessWidget {
  const EquipmentFilterSheet({
    Key? key,
    required this.widget,
    required this.title,
    this.onTap,
    required this.initialChildSize,
    required this.minChildSize,
    required this.maxChildSize,
  }) : super(key: key);
  final Widget widget;
  final String title;
  final void Function()? onTap;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );
    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (_, controller) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              controller: controller,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    24,
                  ),
                  child: Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 24,
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: onTap,
                                  child: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: primaryBlue,
                                  ),
                                ),
                                Expanded(
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: primaryBlue,
                                          fontFamily: 'Rubik',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      widget
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_row.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_visible_list.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/view/ifo_row.dart';
import 'package:ptk_inventory/ifo/view/ifo_visible_list.dart';
import 'package:ptk_inventory/ifo/view/update_ifo/update_ifo_page.dart';

class SpecsList extends StatelessWidget {
  const SpecsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final specs =
        BlocProvider.of<ClassroomEquipmentBloc>(context).state.globalSpecs;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 16, bottom: 16),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '№',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            color: blackLabels,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Характеристики',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 16,
                          color: blackLabels,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: greyCard,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7.0),
                  bottomRight: Radius.circular(7.0),
                ),
              ),
              child:
                  BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    return const SpecsVisibleList();
                  }
                  if (state.searchText.isNotEmpty &&
                      state.visibleList.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "Оборудование не найдено",
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.center,
                                          // direction: Axis.vertical,
                                          children: [
                                            const Text(
                                              "Используйте",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryBlue,
                                                ),
                                                child: const Icon(
                                                  Icons.add_rounded,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              "для добавления нового оборудования",
                                              style: TextStyle(
                                                color: blackLabels,
                                                fontFamily: 'Rubik',
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: specs.length,
                    itemBuilder: (context, index) {
                      print(specs[index].description.length);
                      return InkWell(
                        onTap: () {
                          // context.read<IfoBloc>().add(
                          //       IfoSelected(
                          //         Ifo(
                          //           id: ifos[index].id,
                          //           name: ifos[index].name,
                          //         ),
                          //       ),
                          //     );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (_) => BlocProvider.value(
                          //       value: context.read<IfoBloc>(),
                          //       child: UpdateIfoPage(),
                          //     ),
                          //   ),
                          // );
                        },
                        child: SpecsRow(
                          id: (index + 1).toString(),
                          specs: specs[index].description.length <= 50
                              ? "${specs[index].description.substring(0, 25)}..."
                              : "${specs[index].description.substring(0, 50)}...",
                          last: index == specs.length - 1,
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';

import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/category_row.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/category/view/visible_category_list.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';

class RepairList extends StatelessWidget {
  const RepairList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repairs =
        BlocProvider.of<RepairBloc>(context).state.globalRepairEquipment;
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
                        'Инвентарный номер',
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
              child: BlocBuilder<RepairBloc, RepairState>(
                builder: (context, state) {
                  if (state.visibleList.isNotEmpty) {
                    //  return const VisibleCategoryList();
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
                                          "Акты приема-передачи не найдены",
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
                                              "для добавления нового акта приема-передачи оборудования в ремонт",
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
                    itemCount: repairs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // context.read<CategoryBloc>().add(
                          //       CategorySelected(
                          //         Category(
                          //           id: repairs[index].id,
                          //           name: repairs[index].name,
                          //         ),
                          //       ),
                          //     );
                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (_) => BlocProvider.value(
                          //       value: context.read<CategoryBloc>(),
                          //       child: UpdateCategoryPage(),
                          //     ),
                          //   ),
                          // );
                        },
                        // child: RepairRow(
                        //   id: repairs[index].id.toString(),
                        //   category: repairs[index].name,
                        //   last: index == repairs.length - 1,
                        // ),
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

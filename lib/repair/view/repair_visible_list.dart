import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/view/repair_row.dart';
import 'package:ptk_inventory/repair/view/update_repair/update_repair_page.dart';

class RepairVisibleList extends StatelessWidget {
  const RepairVisibleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairBloc, RepairState>(
      builder: (context, state) {
        final repairs = state.visibleList;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: greyCard,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7.0),
                      bottomRight: Radius.circular(7.0),
                    ),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: repairs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // context.read<RepairBloc>().add(
                          //       RepairSelected(
                          //         Repair(
                          //           id: categories[index].id,
                          //           name: categories[index].name,
                          //         ),
                          //       ),
                          //     );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: context.read<RepairBloc>(),
                                child: UpdateRepairPage(),
                              ),
                            ),
                          );
                        },
                        child: RepairRow(
                          number: (index + 1).toString(),
                          inventoryNumber: repairs[index]
                              .equipment
                              .inventoryNumber
                              .toString(),
                          dateTime: DateFormat("dd-MM-yyyy")
                              .format(repairs[index].repair.datetime),
                          last: index == repairs.length - 1,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

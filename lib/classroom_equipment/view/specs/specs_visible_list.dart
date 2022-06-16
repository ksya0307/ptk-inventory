import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/category_row.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/specs/specs_row.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';

class SpecsVisibleList extends StatelessWidget {
  const SpecsVisibleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
      builder: (context, state) {
        final specs = state.specsVisibleList;
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
                    itemCount: specs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // context.read<CategoryBloc>().add(
                          //       CategorySelected(
                          //         Category(
                          //           id: ifos[index].id,
                          //           name: ifos[index].name,
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
                        child: SpecsRow(
                          id: (index + 1).toString(),
                          specs: specs[index].description,
                          last: index == specs.length - 1,
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

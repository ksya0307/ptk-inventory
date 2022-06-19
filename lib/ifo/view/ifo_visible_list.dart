import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/model/category.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/view/ifo_row.dart';

class VisibleIfoList extends StatelessWidget {
  const VisibleIfoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IfoBloc, IfoState>(
      builder: (context, state) {
        final ifos = state.visibleList;
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
                    itemCount: ifos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<IfoBloc>().add(
                                IfoSelected(
                                  Ifo(
                                    id: ifos[index].id,
                                    name: ifos[index].name,
                                  ),
                                ),
                              );
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: context.read<IfoBloc>(),
                                child: UpdateCategoryPage(),
                              ),
                            ),
                          );
                        },
                        child: IfoRow(
                          id: (index + 1).toString(),
                          ifo: ifos[index].name,
                          last: index == ifos.length - 1,
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

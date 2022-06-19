import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/category/view/update_category/update_category_page.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/view/ifo_row.dart';
import 'package:ptk_inventory/ifo/view/update_ifo/update_ifo_page.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';

class VisibleIfoList extends StatefulWidget {
  const VisibleIfoList({
    Key? key,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  @override
  State<VisibleIfoList> createState() => _VisibleIfoListState();
}

class _VisibleIfoListState extends State<VisibleIfoList> {
  int groupValue = -1;
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
                      return widget.radioButton == null
                          ? InkWell(
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
                                      child: UpdateIfoPage(),
                                    ),
                                  ),
                                );
                              },
                              child: IfoRow(
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                id: (index + 1).toString(),
                                ifo: ifos[index].name,
                                last: index == ifos.length - 1,
                              ),
                            )
                          : InkWell(
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
                                      child: UpdateIfoPage(),
                                    ),
                                  ),
                                );
                              },
                              child: IfoRow(
                                firstFlexRow: widget.firstFlexRow,
                                secondFlexRow: widget.secondFlexRow,
                                id: (index + 1).toString(),
                                ifo: ifos[index].name,
                                last: index == ifos.length - 1,
                                  radio: Radio<int>(
                                  groupValue: groupValue,
                                  value: index,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                      BlocProvider.of<InventoryBloc>(context)
                                          .add(
                                        InventoryIfoSelected(
                                          selectedIfo: ifos[index],
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ));
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/model/ifo.dart';
import 'package:ptk_inventory/ifo/view/ifo_row.dart';
import 'package:ptk_inventory/ifo/view/ifo_visible_list.dart';
import 'package:ptk_inventory/ifo/view/update_ifo/update_ifo_page.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';

class IfosList extends StatefulWidget {
  final Widget? radioButton;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  const IfosList({
    Key? key,
    this.radioButton,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);

  @override
  State<IfosList> createState() => _IfosListState();
}

class _IfosListState extends State<IfosList> {
  int groupValue = -1;
  @override
  Widget build(BuildContext context) {
    final ifos = BlocProvider.of<IfoBloc>(context).state.globalIfos;
    return SingleChildScrollView(
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
                if (widget.radioButton != null)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  )
                else
                  const SizedBox(
                    height: 0,
                  ),
                Flexible(
                  flex: widget.firstFlex,
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
                  flex: widget.secondFlex,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Наименование',
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
            child: BlocBuilder<IfoBloc, IfoState>(
              builder: (context, state) {
                if (state.visibleList.isNotEmpty) {
                  return VisibleIfoList(
                    radioButton: widget.radioButton,
                    firstFlex: widget.firstFlex,
                    firstFlexRow: widget.firstFlexRow,
                    secondFlex: widget.secondFlex,
                    secondFlexRow: widget.secondFlexRow,
                  );
                }
                if (state.searchText.isNotEmpty && state.visibleList.isEmpty) {
                  return Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                        "ИФО не найдено",
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
                                      child: widget.radioButton == null
                                          ? Wrap(
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  child: Container(
                                                    width: 35,
                                                    height: 35,
                                                    decoration:
                                                        const BoxDecoration(
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
                                                  "для добавления нового ИФО",
                                                  style: TextStyle(
                                                    color: blackLabels,
                                                    fontFamily: 'Rubik',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(
                                              height: 0,
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
                                    BlocProvider.of<InventoryBloc>(context).add(
                                      InventoryIfoSelected(
                                        selectedIfo: ifos[index],
                                      ),
                                    );
                                  });
                                },
                              ),
                            ));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

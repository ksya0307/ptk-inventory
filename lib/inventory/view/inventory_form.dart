import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/inventory_list.dart';

class InventoryForm extends StatelessWidget {
  const InventoryForm({
    Key? key,
    this.widget,
    required this.firstFlex,
    required this.secondFlex,
    required this.firstFlexRow,
    required this.secondFlexRow,
  }) : super(key: key);
  final Widget? widget;
  final int firstFlex;
  final int secondFlex;
  final int firstFlexRow;
  final int secondFlexRow;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              hintText: '101340003313',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChange: (inventoryNumber) => {
                context.read<InventoryBloc>().add(
                      InventorySearch(
                        matchingWord: inventoryNumber,
                      ),
                    ),
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: BlocBuilder<InventoryBloc, InventoryState>(
                buildWhen: (previous, current) =>
                    previous.globalInventory != current.globalInventory,
                builder: (context, state) {
                  if (state.inventoryLoadingStatus ==
                      InventoryLoadingStatus.loadingInProgress) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                CircularProgressIndicator(),
                                Padding(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Text(
                                    "Загрузка оборудования...",
                                    style: TextStyle(
                                      color: greyDark,
                                      fontFamily: 'Rubik',
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state.inventoryLoadingStatus ==
                          InventoryLoadingStatus.loadingSuccess &&
                      state.globalInventory.isNotEmpty) {
                    // print("${state.visibleList}");
                    return InventoryList(
                      firstFlexRow: firstFlexRow,
                      secondFlexRow: secondFlexRow,
                      firstFlex: firstFlex,
                      secondFlex: secondFlex,
                      checkbox: widget,
                    );
                  }
                  if (state.inventoryLoadingStatus ==
                          InventoryLoadingStatus.loadingSuccess &&
                      state.globalInventory.isEmpty) {
                    return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.white,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "Список оборудования пуст",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: blackLabels,
                                            fontFamily: 'Rubik',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Wrap(
                                        runSpacing: 8,
    
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
    
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
                                            padding: const EdgeInsets.symmetric(
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
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text(
                                        "для принятия оборудования к учету",
                                        style: TextStyle(
                                          color: blackLabels,
                                          fontFamily: 'Rubik',
                                          fontSize: 16,
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
    
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(
                                  "Загрузка оборудования...",
                                  style: TextStyle(
                                    color: greyDark,
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

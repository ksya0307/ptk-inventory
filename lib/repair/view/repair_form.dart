import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';
import 'package:ptk_inventory/repair/view/repair_list.dart';

class RepairForm extends StatelessWidget {
  const RepairForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(
              hintText: '101340003313',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChange: (inventoryNumber) => {
                context.read<RepairBloc>().add(
                      RepairSearch(
                        matchingWord: inventoryNumber,
                      ),
                    ),
              },
            ),
            const SizedBox(height: 8),
            BlocBuilder<RepairBloc, RepairState>(
              builder: (context, state) {
                if (state.repairLoadingStatus ==
                    RepairLoadingStatus.loadingInProgress) {
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
                                  "Загрузка актов приема-передачи...",
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
                if (state.repairLoadingStatus ==
                        RepairLoadingStatus.loadingSuccess &&
                    state.globalRepairEquipment.isNotEmpty) {
                  // print("${state.visibleList}");
                  return const RepairList();
                }
                if (state.repairLoadingStatus ==
                        RepairLoadingStatus.loadingSuccess &&
                    state.globalRepairEquipment.isEmpty) {
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
                                        "Список актов приема-передачи пуст",
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
                            ),
                          )
                        ],
                      )
                    ],
                  );
                  
                }
                return const Text("Что-то пошло не так");
              },
            ),
          ],
        );
      },
    );
  }
}

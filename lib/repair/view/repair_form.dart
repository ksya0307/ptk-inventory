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
                return const Text("Что-то пошло не так");
              },
            ),
          ],
        );
      },
    );
  }
}

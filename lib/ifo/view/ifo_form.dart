import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/category_list.dart';
import 'package:ptk_inventory/category/view/search_category.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/ifo/bloc/ifo_bloc.dart';
import 'package:ptk_inventory/ifo/view/ifo_list.dart';

class IfoForm extends StatelessWidget {
  const IfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            hintText: 'Грант А',
            keyboardType: TextInputType.text,
            inputFormatters: const [],
            onChange: (ifo) => {
              context.read<IfoBloc>().add(
                    IfoSearch(matchingWord: ifo),
                  ),
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: BlocBuilder<IfoBloc, IfoState>(
              builder: (context, state) {
                if (state.ifoLoadingStatus ==
                    IfoLoadingStatus.loadingInProgress) {
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
                                  "Загрузка ИФО...",
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
                if (state.ifoLoadingStatus == IfoLoadingStatus.loadingSuccess &&
                    state.globalIfos.isNotEmpty) {
                  // print("${state.visibleList}");
                  return const IfosList();
                }
                if (state.ifoLoadingStatus == IfoLoadingStatus.loadingSuccess &&
                    state.globalIfos.isEmpty) {
                  return const Text("Список ИФО пуст");
                }

                return const Text("Что-то пошло не так");
              },
            ),
          ),
        ],
      ),
    );
  }
}

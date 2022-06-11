import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/authentication/bloc/authentication_bloc.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/repair/bloc/repair_bloc.dart';

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
            //  if (state.user.role == UserRole.teacher)
            // BlocProvider<RepairBloc>.value(
            //   value: context.read<RepairBloc>()
            //     ..add(const RepairUserLoadList()),
            // )
            //else
            // BlocProvider<RepairBloc>.value(
            //   value: context.read<RepairBloc>()
            //     ..add(
            //       const RepairLoadList(),
            //     ),
            // ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ptk_inventory/common/component/property_input.dart';

import 'package:ptk_inventory/common/component/property_label.dart';

class AddSpecsForm extends StatelessWidget {
  const AddSpecsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const PropertyLabel(
            property: 'Характеристики',
            bottomPadding: 8,
          ),
          PropertyInput(
            // propertyInvalid: state.problem.invalid,
            errorText: 'Характеристики не могут быть пустыми',
            // onChange: (problem) => context
            //     .read<RepairBloc>()
            //     .add(RepairProblemChanged(problem)),
            maxLength: 700,
            maxLines: 7,
            hintText: 'Mikrotik D732',
          ),
          // BlocBuilder<IfoBloc, IfoState>(
          //   buildWhen: (previous, current) => previous.name != current.name,
          //   builder: (context, state) {
          //     return PropertyInput(
          //       hintText: 'Грант А',
          //       errorText: 'Название ИФО не может быть пустым',
          //       propertyInvalid: state.name.invalid,
          //       onChange: (ifo) =>
          //           context.read<IfoBloc>().add(IfoNameChanged(ifo)),
          //     );
          //   },
          // ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 8),
          //   child: BlocBuilder<IfoBloc, IfoState>(
          //     buildWhen: (previous, current) =>
          //         previous.formStatus != current.formStatus,
          //     builder: (context, state) {
          //       return state.formStatus.isSubmissionInProgress
          //           ? const InProgress(
          //               inProgressText: "Добавление...",
          //             )
          //           : CommonButton(
          //               fontSize: 18,
          //               buttonText: "Добавить",
          //               onPress: () {
          //                 context.read<IfoBloc>().add(const IfoSubmitted());
          //               },
          //               formValidated: state.formStatus.isValidated,
          //             );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

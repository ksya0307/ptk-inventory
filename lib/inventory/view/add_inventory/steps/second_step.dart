import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/common/component/search_field.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/documents/view/document_form.dart';
import 'package:ptk_inventory/ifo/view/ifo_form.dart';
import 'package:ptk_inventory/inventory/bloc/inventory_bloc.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/components/given_toggle.dart';
import 'package:ptk_inventory/inventory/view/add_inventory/property_inventory.dart';

class SecondStepForm extends StatelessWidget {
  const SecondStepForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InventoryProperty(
          property: "Документ, контракт",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: DocumentForm(
            firstFlex: 2,
            secondFlex: 5,
            firstFlexRow: 2,
            secondFlexRow: 5,
            widget: SizedBox(
              height: 0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        InventoryProperty(
          property: "ИФО",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: IfoForm(
            firstFlex: 2,
            secondFlex: 5,
            firstFlexRow: 2,
            secondFlexRow: 5,
            widget: SizedBox(height: 0),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Divider(
            color: greyDivider,
            thickness: .75,
          ),
        ),
        const InventoryProperty(
          property: "Приобретено по заявке",
          paddingLeft: 16,
          paddingBottom: 8,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 24),
          child: BlocBuilder<InventoryBloc, InventoryState>(
            buildWhen: (previous, current) =>
                previous.byRequest != current.byRequest,
            builder: (context, state) {
              return GivenToggle(
                onToggle: (request) {
                  print(request);
                  if (request == 0) {
                    context
                        .read<InventoryBloc>()
                        .add(const InventoryGivenChanged(given: false));
                  } else if (request == 1) {
                    context
                        .read<InventoryBloc>()
                        .add(const InventoryGivenChanged(given: true));
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}

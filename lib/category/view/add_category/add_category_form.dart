import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/add_category/add_category_button.dart';
import 'package:ptk_inventory/category/view/add_category/category_name_input.dart';
import 'package:ptk_inventory/category/view/common/category_name_label.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("17");
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state.formStatus == FormzStatus.submissionSuccess) {
          snackbarMessage(context, "Категория успешно создана");
          Navigator.of(context).pop();
        } else if (state.formStatus == FormzStatus.submissionFailure) {
          snackbarMessage(context, "Такая категория уже существует");
        }
      },
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CategoryNameLabel(),
            CategoryName(),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: AddCategoryButton(),
            )
          ],
        ),
      ),
    );
  }
}

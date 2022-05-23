import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/common/category_name_label.dart';
import 'package:ptk_inventory/category/view/update_category/category_name_input.dart';
import 'package:ptk_inventory/category/view/update_category/delete_category_button.dart';
import 'package:ptk_inventory/category/view/update_category/save_category_button.dart';
import 'package:ptk_inventory/common/component/snackbar_message_error.dart';
import 'package:ptk_inventory/common/component/snackbar_message_info.dart';

class UpdateCategoryForm extends StatelessWidget {
  const UpdateCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        //print("GLOBAl ${state.globalCategories}");
        if (state.categoryDeleteStatus == CategoryDeleteStatus.saved) {
          snackbarMessage(context, "Категория сохранена");
          context
              .read<CategoryBloc>()
              .add(CategorySaveToList(category: state.selectedCategory!));
          context.read<CategoryBloc>().add(const CategorySelected(null));
        }
        if (state.categoryDeleteStatus == CategoryDeleteStatus.savedOnGlobal) {
          Navigator.of(context).pop();
        }
        if (state.categoryDeleteStatus == CategoryDeleteStatus.notSaved) {
          snackbarMessageError(context, "Такая категория уже существует");
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CategoryNameLabel(),
              CategoryNameInput(),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: SaveCategoryButton(),
              ),
            ],
          ),
          Column(
            children: const [DeleteCategoryButton()],
          )
        ],
      ),
    );
  }
}

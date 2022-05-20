import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/common/category_name_label.dart';
import 'package:ptk_inventory/category/view/update_category/category_name_input.dart';
import 'package:ptk_inventory/category/view/update_category/delete_category_button.dart';
import 'package:ptk_inventory/category/view/update_category/save_category_button.dart';
import 'package:ptk_inventory/common/component/snackbar_message.dart';

class UpdateCategoryPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => UpdateCategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Назад",
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            context.read<CategoryBloc>().add(const CategorySelected(null));
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Изменение категории",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints view) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: const UpdateCategoryForm(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpdateCategoryForm extends StatelessWidget {
  const UpdateCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state.formStatus == FormzStatus.submissionSuccess) {
          snackbarMessage(context, "Данные сохранены");
          Navigator.of(context).pop();
          context.read<CategoryBloc>().add(const CategorySelected(null));
        } else if (state.formStatus == FormzStatus.submissionFailure) {
          snackbarMessage(context, "Данные не удалось сохранить");
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
              CategoryName(),
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

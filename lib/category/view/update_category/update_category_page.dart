import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/category/view/update_category/update_category_form.dart';

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
            context.read<CategoryBloc>().add(const CategorySelected(null));
            Navigator.of(context).pop();
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

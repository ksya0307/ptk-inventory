import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';

class ConfirmDeletingBottomSheet extends StatelessWidget {
  const ConfirmDeletingBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Удалить категорию?",
          style: TextStyle(
            color: blackLabels,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        DeleteButton(),
        CancelButton(),
      ],
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: const SizedBox(
        height: 48,
        width: 160,
        child: Text(
          "Отменить",
          style: TextStyle(
            color: blackLabels,
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.5,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(redCustom),
              ),
              onPressed: () {
                context
                    .read<CategoryBloc>()
                    .add(CategoryDeleted(state.selectedCategory!.id));
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 12 + 2, 0, 12 + 2),
                child: Text(
                  "Удалить",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

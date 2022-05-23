import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';

class SearchCategory extends StatefulWidget {
  const SearchCategory({Key? key}) : super(key: key);

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          previous.visibleList != current.visibleList,
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: greyCard,
            borderRadius: BorderRadius.all(
              Radius.circular(7.0),
            ),
          ),
          child: Theme(
            data: ThemeData(
              textSelectionTheme:
                  const TextSelectionThemeData(selectionColor: blueCustom),
            ),
            child: TextField(
              onChanged: (query) {
                context
                    .read<CategoryBloc>()
                    .add(CategorySearch(matchingWord: query));
              },
              controller: _textController,
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 16,
                color: blackLabels,
              ),
              cursorColor: Theme.of(context).primaryColor,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 18,
                  color: greyDark,
                ),
                contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
                hintText: 'Смартфон',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: primaryBlue,
                ),
                // suffixIcon: _textController.text.isNotEmpty
                //     ? IconButton(
                //         icon: const Icon(
                //           Icons.clear_rounded,
                //           color: primaryBlue,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             _textController.clear();
                //           });
                //         },
                //       )
                //     : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

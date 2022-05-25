import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
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
                context.read<UsersBloc>().add(UsersSearch(query));
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
                hintText: 'Петрова',
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

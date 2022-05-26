import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            initialValue: state.selectedUser!.username,
            onChanged: (username) {
              context.read<UsersBloc>().add(UsersUsernameChanged(username));
            },
            cursorColor: Theme.of(context).primaryColor,
            minLines: 1,
            style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: blackInput,
            ),
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.edit_rounded),
              labelStyle: const TextStyle(fontFamily: 'Rubik', fontSize: 18),
              errorText:
                  state.username.invalid ? 'Логин не может быть пустым' : null,
              errorStyle: const TextStyle(
                color: redCustom,
                fontFamily: 'Rubik',
              ),
              contentPadding: const EdgeInsets.fromLTRB(12, 19 - 4, 12, 19 - 4),
              hintStyle: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: greyDark,
              ),
              border: const OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: redCustom,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: redCustom, width: 1.5),
                borderRadius: BorderRadius.circular(7.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: blueInputFocuced,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: greyDark,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

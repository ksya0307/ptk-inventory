import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

class SaveUserButton extends StatelessWidget {
  const SaveUserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const CircularProgressIndicator(color: primaryBlue),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(0, 47, 167, 0.65);
                        }
                        return const Color.fromRGBO(0, 47, 167, 1.0);
                      }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                    label: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
                      child: Text(
                        "Сохранение...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 0.65),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(0),
                      foregroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(255, 255, 255, 0.65);
                        }
                        return Colors.white;
                      }),
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color.fromRGBO(0, 47, 167, 0.65);
                        }
                        return const Color.fromRGBO(0, 47, 167, 1.0);
                      }),
                    ),
                    onPressed: state.formStatus.isValidated
                        ? () {
                            context.read<UsersBloc>().add(const UsersSaved());
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 12 + 1, 0, 12 + 1),
                      child: Text(
                        "Сохранить",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
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

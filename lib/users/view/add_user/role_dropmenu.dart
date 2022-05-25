import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/common/component/custom_dropdown.dart';
import 'package:ptk_inventory/common/model/user_roles.dart';
import 'package:ptk_inventory/config/colors.dart';
import 'package:ptk_inventory/users/bloc/users_bloc.dart';

class RoleDropDown extends StatefulWidget {
  const RoleDropDown({Key? key}) : super(key: key);

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown> {
  String? role;

  List<String> roles = [];

  @override
  void initState() {
    for (final role in UserRole.values) {
      roles.add(role.userRoleToString);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: CustomDropdown(
            dropDownWidget: Theme(
              data: Theme.of(context).copyWith(canvasColor: greyCard),
              child: DropdownButton<String>(
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: primaryBlue,
                ),
                value: role ?? state.selectedUser!.role.userRoleToString,
                onChanged: (String? value) {
                  setState(() {
                    role = value ?? "";
                  });
                },
                items: roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(
                      role,
                      style: const TextStyle(
                        color: blackInput,
                        fontFamily: 'Rubik',
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            labelText: "Выберите роль",
          ),
        );
      },
    );
  }
}

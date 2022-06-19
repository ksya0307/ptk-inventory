import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/category/bloc/category_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/view/add_equipment/add_equipment_page.dart';
import 'package:ptk_inventory/classrooms/bloc/classroom_bloc.dart';
import 'package:ptk_inventory/config/colors.dart';

class AddContainer extends StatelessWidget {
  const AddContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(blueOverlay),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        alignment: Alignment.centerLeft,
        backgroundColor: MaterialStateProperty.all(
          greyCard,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.fromLTRB(12, 0, 0, 0),
        ),
        elevation: MaterialStateProperty.all(0),
      ),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<ClassroomEquipmentBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<ClassroomBloc>()
                      ,
                  ),
                  BlocProvider.value(
                    value: context.read<CategoryBloc>()
                      ..add(const CategoryLoadList()),
                  ),
                ],
                child: AddEquipmentPage(),
              ))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.add_rounded,
            color: Color.fromRGBO(0, 47, 167, 1.0),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Добавить оборудование",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromRGBO(68, 68, 68, 1.0),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

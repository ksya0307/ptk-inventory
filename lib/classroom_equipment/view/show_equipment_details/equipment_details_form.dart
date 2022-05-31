import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/bloc/classroom_equipment_bloc.dart';
import 'package:ptk_inventory/classroom_equipment/model/equipment_types.dart';

import 'package:ptk_inventory/classroom_equipment/view/show_equipment_details/inputs/property.dart';
import 'package:ptk_inventory/common/component/property_label.dart';

class EquipmentDetailsForm extends StatelessWidget {
  const EquipmentDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PropertyLabel(property: "Инвентарный номер", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.inventoryNumber !=
                current.selectedEquipment!.inventoryNumber,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.inventoryNumber.toString(),
                maxLines: 1,
                screenConstraint: 0.5,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const PropertyLabel(property: "Категория", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.equipment.category.name !=
                current.selectedEquipment!.equipment.category.name,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.equipment.category.name,
                maxLines: 2,
                screenConstraint: 1,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const PropertyLabel(property: "Характеристики", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.equipment.description !=
                current.selectedEquipment!.equipment.description,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.equipment.description,
                maxLines: 30,
                screenConstraint: 1,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const PropertyLabel(property: "Аудитория", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.classroom.number !=
                current.selectedEquipment!.classroom.number,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.classroom.number,
                maxLines: 1,
                screenConstraint: 0.2,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const PropertyLabel(property: "Номер в аудитории", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.numberInClassroom !=
                current.selectedEquipment!.numberInClassroom,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.numberInClassroom,
                screenConstraint: 0.2,
                maxLines: 1,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
          const PropertyLabel(
              property: "Принадлежность оборудования", bottomPadding: 0),
          BlocBuilder<ClassroomEquipmentBloc, ClassroomEquipmentState>(
            buildWhen: (previous, current) =>
                previous.selectedEquipment!.equipmentType !=
                current.selectedEquipment!.equipmentType,
            builder: (context, state) {
              return Property(
                property: state.selectedEquipment!.equipmentType
                    .equipmentBelongingToString,
                maxLines: 3,
                screenConstraint: 1,
              );
            },
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

import 'package:ptk_inventory/classroom_equipment/model/classroom_equipment.dart';
import 'package:ptk_inventory/classroom_equipment/provider/classroom_equipment_api_client.dart';
import 'package:ptk_inventory/common/model/hive_model.dart';
import 'package:ptk_inventory/common/model/requests/auth_header.dart';
import 'package:ptk_inventory/common/provider/hive/hive_provider.dart';
import 'package:ptk_inventory/common/repository/authentication_repository.dart';

class ClassroomEquipmentRepository {
  final ClassroomEquipmentProvider _classroomEquipmentProvider;
  final AuthenticationRepository _authenticationRepository;

  ClassroomEquipmentRepository({
    ClassroomEquipmentProvider? classroomEquipmentProvider,
    AuthenticationRepository? authenticationRepository,
  })  : _classroomEquipmentProvider =
            classroomEquipmentProvider ?? ClassroomEquipmentProvider(),
        _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository();

  Future<List<ClassroomEquipment>> userEquipments() async {
    try {
      final result = await _classroomEquipmentProvider.equipmentInUserClassroom(
          HeaderModel(await HeaderModel.getAccessToken()).toMap());
      return result.result;
    } on EquipmentInUserClassroomRequestFailure {
      return [];
    } on EquipmentInUserClassroomRequestUnauthorized {
      final UserHiveModel? userHiveModel = await getUserProfile();
      if (userHiveModel != null) {
        await _authenticationRepository.refreshToken(userHiveModel);
      }
      final result = await _classroomEquipmentProvider.equipmentInUserClassroom(
        HeaderModel(
          await HeaderModel.getAccessToken(),
        ).toMap(),
      );
      return result.result;
    }
  }
}

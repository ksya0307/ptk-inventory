class CreateRepairEquipmentModelRequest {
  final int repairId;
  final int equipmentId;
  final String problem;

  CreateRepairEquipmentModelRequest(
    this.repairId,
    this.equipmentId,
    this.problem,
  );

  CreateRepairEquipmentModelRequest copyWith({
    int? repairId,
    int? equipmentId,
    String? problem,
  }) {
    return CreateRepairEquipmentModelRequest(
      repairId ?? this.repairId,
      equipmentId ?? this.equipmentId,
      problem ?? this.problem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repair_id': repairId,
      'equipment_id': equipmentId,
      'problem': problem,
    };
  }
}

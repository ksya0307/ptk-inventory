class GeneralModelRequest {
  String name;
  GeneralModelRequest({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }
}

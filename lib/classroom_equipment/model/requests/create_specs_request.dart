class CreateSpecsModelRequest {
  String description;
  int category;
  CreateSpecsModelRequest({required this.description, required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'category': category,
    };
  }
}

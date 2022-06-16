class UpdateSpecsModelRequest {
  int id;
  String description;
  int category;
  UpdateSpecsModelRequest({required this.id ,required this.description, required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'description': description,
      'categoryId': category,
    };
  }
}

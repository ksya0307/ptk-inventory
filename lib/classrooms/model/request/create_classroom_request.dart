class CreateClassroomModelRequest {
  String number;
  int user;
  CreateClassroomModelRequest({required this.number, required this.user});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'number': number, 'user': user};
  }
}

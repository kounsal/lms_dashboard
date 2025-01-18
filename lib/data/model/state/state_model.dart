class StateModel {
  final String? id;
  final String name;
  final String code;
  final bool status;

  StateModel({
     this.id,
    required this.name,
    required this.code,
     this.status = false,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['_id'],
      name: json['name'],
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'status': status,
    };
  }
}

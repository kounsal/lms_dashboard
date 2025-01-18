import 'package:lms_admin/data/model/state/state_model.dart';

class CollegeModel {
  final String? id;
  final String name;
  final String? stateId;
  final StateModel? state;
  final String region;
  final String thumbnail;

  CollegeModel({
     this.id,
    required this.name,
     this.state,
     this.stateId,
    required this.region,
    required this.thumbnail,
  });

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['_id'],
      name: json['name'],
      // state: StateModel.fromJson(json['state']),
      state: json['stateId'],
      region: json['region'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      // 'state': state?.toJson(),
      'state': stateId,
      'region': region,
      'thumbnail': thumbnail,
    };
  }
}

import 'package:lms_admin/data/model/college/college_model.dart';
import 'package:lms_admin/data/services/collegeService.dart';

class CategoryModel {
  final String id;
  final String name;
  final List<String> collegeIds;
  final String keyword;
  final String description;

  late List<CollegeModel> colleges;

  CategoryModel({
    required this.id,
    required this.name,
    required this.collegeIds,
    required this.keyword,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['collegeIds'] as List;
    List<String> collegeIdsList = list.map((i) => i.toString()).toList();

    return CategoryModel(
      id: json['_id'],
      name: json['name'],
      collegeIds: collegeIdsList,
      keyword: json['keyword'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'collegeIds': collegeIds,
      'keyword': keyword,
      'description': description,
    };
  }

  Future<void> fetchColleges(CollegeService collegeService) async {
    colleges = [];
    for (String collegeId in collegeIds) {
      CollegeModel college = await collegeService.getCollegeById(collegeId);
      colleges.add(college);
    }
  }
}

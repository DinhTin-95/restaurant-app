import 'package:hive/hive.dart';
import 'package:restaurant_bbc/models/menu.dart';
part 'table.g.dart';

@HiveType(typeId: 0)
class TableModel {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  bool status;

  @HiveField(2)
  List<MenuModel> oderedfood = [];

  TableModel({this.id, required this.status, required this.oderedfood});

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
        id: json['id'],
        status: json['status'],
        oderedfood: json['oderedfood'] == null
            ? []
            : (json['oderedfood'] as List)
                .map((e) => MenuModel.fromJson(e))
                .toList());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': true,
        'oderedfood': List<dynamic>.from(oderedfood.map((e) => e.toJson()))
      };

  Map<String, dynamic> updatetoJson() =>
      {'id': id, 'status': false, 'oderedfood': []};
}

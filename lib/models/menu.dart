import 'package:hive/hive.dart';
part 'menu.g.dart';

@HiveType(typeId: 1)
class MenuModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int price;

  @HiveField(3)
  String subtitle;

  @HiveField(4)
  int amount = 0;

  MenuModel(
      {this.id,
      required this.name,
      required this.price,
      required this.subtitle,
      required this.amount});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        subtitle: json['subtitle'],
        amount: json['amount']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'subtitle': subtitle,
        'amount': 0,
      };
}

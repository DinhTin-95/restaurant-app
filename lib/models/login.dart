import 'package:hive/hive.dart';
part 'login.g.dart';

@HiveType(typeId: 2)
class Login {
  @HiveField(0)
  String idmember;

  @HiveField(1)
  String password;

  @HiveField(2)
  String fullname;

  @HiveField(3)
  String level;

  @HiveField(4)
  String id;

  Login(
      {required this.idmember,
      required this.password,
      required this.fullname,
      required this.level,
      required this.id});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
        fullname: json['fullname'],
        password: json['password'],
        idmember: json['idmember'],
        level: json['level'],
        id: json['id']);
  }

  Map<String, dynamic> toJson(String ten, String pw, String idmem, String lv) =>
      {
        'fullname': ten,
        'idmember': idmember,
        'password': pw,
        'level': lv,
        'id': id
      };

  Map<String, dynamic> updatetoJson(
          {required String idmem, required String name, required String lv}) =>
      {'fullname': name, 'idmember': idmem, 'level': lv};
}

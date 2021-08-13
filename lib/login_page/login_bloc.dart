import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_bbc/models/login.dart';

final client = http.Client();
// ignore: non_constant_identifier_names
final login_bloc = LoginBloc();

class LoginBloc {
  List<Login> arrayAccount = [];

  List<Login> listAccount(String responseBody) {
    final parse = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return arrayAccount =
        parse.map<Login>((json) => Login.fromJson(json)).toList();
  }

  Future<List<Login>> fetchListAccount() async {
    final response = await client.get(
      Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/account'),
      headers: {"Content-Type": 'application/json'},
    );
    if (response.statusCode == 200) {
      return listAccount(response.body);
    } else
      throw Exception('false');
  }

  Future<Login> updateListAccount(
      {required Login mem,
      required String fullname,
      required String idmember,
      required String level}) async {
    final response = await http.put(
        Uri.parse(
            'https://60dbd2b0801dcb0017291306.mockapi.io/api/account/${mem.id}'),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(
            mem.updatetoJson(name: fullname, idmem: idmember, lv: level)));
    final edit = jsonDecode(response.body);
    final memedited = Login.fromJson(edit);
    final index = arrayAccount.indexWhere((element) => element.id == mem.id);
    if (index >= 0) {
      arrayAccount[index].fullname = memedited.fullname;
      arrayAccount[index].idmember = memedited.idmember;
      arrayAccount[index].level = memedited.level;
    }
    return memedited;
  }

  Future<Login> createAccount(
      {required Login member,
      required String ten,
      required String idmem,
      required String pw,
      required String lv}) async {
    final response = await http.post(
        Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/account'),
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode(member.toJson(ten, pw, idmem, lv)));

    final b = jsonDecode(response.body);

    return Login.fromJson(b);
  }

  Future<Login> deleteListAccount({required Login member}) async {
    final response = await client.delete(
      Uri.parse(
          'https://60dbd2b0801dcb0017291306.mockapi.io/api/account/${member.id}'),
      headers: {"Content-Type": 'application/json'},
    );
    final result = jsonDecode(response.body);
    final memberDeleted = Login.fromJson(result);
    arrayAccount.removeWhere((element) => element.id == memberDeleted.id);
    return memberDeleted;
  }
}

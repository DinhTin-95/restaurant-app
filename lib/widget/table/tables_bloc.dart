import 'dart:convert';
import 'package:restaurant_bbc/models/table.dart';
import 'package:http/http.dart' as http;

final client = http.Client();

class TablesBloc {
  List<TableModel> tables = [];

  List<TableModel> arrayTable(String responseBody) {
    final parse = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parse.map<TableModel>((json) => TableModel.fromJson(json)).toList();
  }

  Future<List<TableModel>> fetchListTable() async {
    final response = await client.get(
        Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/tables'));
    if (response.statusCode == 200) {
      tables = arrayTable(response.body);
      return tables;
    } else {
      throw Exception('load faild');
    }
  }

  Future<TableModel> updateTable(TableModel table) async {
    final response = await client.put(
      Uri.parse(
          'https://60dbd2b0801dcb0017291306.mockapi.io/api/tables/${table.id}'),
      headers: {"Content-Type": 'application/json'},
      body: json.encode((table.toJson())),
    );
    final result = jsonDecode(response.body);
    return TableModel.fromJson(result);
  }

  Future<TableModel> payTable(TableModel table) async {
    final response = await client.put(
        Uri.parse(
            'https://60dbd2b0801dcb0017291306.mockapi.io/api/tables/${table.id}'),
        headers: {"Content-Type": 'application/json'},
        body: json.encode(table.updatetoJson()));
    return TableModel.fromJson(jsonDecode(response.body));
  }
}

// ignore: non_constant_identifier_names
final table_bloc = TablesBloc();

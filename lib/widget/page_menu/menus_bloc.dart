import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_bbc/models/menu.dart';

final client = http.Client();

class MenusBloc {
  List<MenuModel> items = [];
  late Box<MenuModel> historybillpayment;

  List<MenuModel> arrayMenus(String responseBody) {
    final jsonArray = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return jsonArray
        .map<MenuModel>((json) => MenuModel.fromJson(json))
        .toList();
  }

  Future<List<MenuModel>> fetchMenus() async {
    final client = http.Client();
    final response = await client.get(
        Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/menus'));

    items = arrayMenus(response.body);
    return arrayMenus(response.body);
  }

  Future<List<MenuModel>> updateMenus(int amount) async {
    final response = await http.put(
      Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/menus'),
      body: jsonEncode(<String, int>{
        'amount': amount,
      }),
    );
    return arrayMenus(response.body);
  }

  Future<MenuModel> deleteFood(MenuModel food) async {
    final response = await http.delete(
      Uri.parse(
          'https://60dbd2b0801dcb0017291306.mockapi.io/api/menus/${food.id}'),
      headers: {"Content-Type": 'application/json'},
    );
    final resultDelete = jsonDecode(response.body);
    final foodDeleted = MenuModel.fromJson(resultDelete);
    items.removeWhere((element) => element.id == foodDeleted.id);
    return foodDeleted;
  }

  Future<MenuModel> createFood(MenuModel food) async {
    final response = await http.post(
        Uri.parse('https://60dbd2b0801dcb0017291306.mockapi.io/api/menus'),
        headers: {"Content-Type": 'application/json'},
        body: jsonEncode(food.toJson()));
    final resultCreatefood = jsonDecode(response.body);

    return MenuModel.fromJson(resultCreatefood);
  }

  Future<MenuModel> editFood(
      {required MenuModel food,
      required String name,
      required int price,
      required String subtitle}) async {
    final responseedit = await http.put(
      Uri.parse(
          'https://60dbd2b0801dcb0017291306.mockapi.io/api/menus/${food.id}'),
      headers: {"Content-Type": 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'price': price,
        'subtitle': subtitle
      }),
    );
    final resultEdit = jsonDecode(responseedit.body);
    final back = MenuModel.fromJson(resultEdit);
    final index = items.indexWhere((element) => element.id == food.id);
    if (index >= 0) {
      items[index].name = back.name;
      items[index].price = back.price;
      items[index].subtitle = back.subtitle;
    }
    return back;
  }
}

// ignore: non_constant_identifier_names
final menu_bloc = MenusBloc();

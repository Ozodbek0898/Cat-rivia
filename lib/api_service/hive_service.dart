import 'dart:convert';
import 'package:cat_trivia/model/fact_model.dart';
import 'package:hive/hive.dart';

class HiveService {

  late Box _box;

   Future init() async {
     _box = await Hive.openBox("cat_trivia");
  }


  void setFact(Fact fact) {
    var storedData = _box.get(_HiveKeys.facts) as String?;
    var list = <dynamic>[];

    if (storedData != null && storedData.isNotEmpty) {
      list = json.decode(storedData) as List<dynamic>;
    }

    List<Fact> eventsList =
        list.map((e) => Fact.fromJson(e)).toList();

    eventsList.add(fact);


    _box.put(_HiveKeys.facts, json.encode(eventsList));
  }

  List<Fact> getFacts() {
    var storedData = _box.get(_HiveKeys.facts, defaultValue: "[]") as String;

    var lives = json.decode(storedData) as List<dynamic>;

    return lives.map((e) => Fact.fromJson(e)).toList();
  }




}

class _HiveKeys {
  static const String facts = "facts";
}

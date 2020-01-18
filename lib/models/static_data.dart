import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:tree_secure/models/tree.dart';

class StaticData with ChangeNotifier {
  List<Tree> listOfTree = [];
  Map<String, Tree> mapOfTree = Map();

  void loadTreeFromJson() async {
    String data = await rootBundle.loadString("assets/trees.json");
    Map<String, dynamic> jsonResult = json.decode(data);
    jsonResult.forEach((String key, dynamic object) {
      Tree temp = Tree();
      temp = Tree.fromJson(object);
      temp.id = key;
      print(temp.coordinates);
      listOfTree.add(temp);
      mapOfTree[key] = temp;
    });
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';

class UserList with ChangeNotifier {
  List<Tree> listOfAdoptedTree = [];
  List<Tree> listOfVisitedTree = [];

  UserList(this.user, this.mapOfTrees);
  Map<String, Tree> mapOfTrees = Map();
  User user;

  void filterUserTree() {
    user.adoptedTrees.forEach((key) {
      Tree temp = mapOfTrees[key];
      listOfAdoptedTree.add(temp);
    });
    user.visitedTrees.forEach((key) {
      Tree temp = mapOfTrees[key];
      listOfVisitedTree.add(temp);
    });
    notifyListeners();
  }

  void increaseAdoptTree(Tree tree) {
    listOfAdoptedTree.add(tree);
    notifyListeners();
  }

  void increaseVisitedTree(Tree tree) {
    listOfVisitedTree.add(tree);
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RecentlyPlayed with ChangeNotifier{
  static const key = 'recent';
  final SharedPreferences _sharedPreferences;

  RecentlyPlayed(this._sharedPreferences) {

    loadData();
  }



  loadData()  {
    // List<String> decode =  _sharedPreferences.getStringList(key)??[];
    // _recentlyPlayedList =  decode.map((e)=>Book.fromJson(jsonDecode(e))).toSet().toList();
    // notifyListeners();
  }

  Future<void> saveData()async {
   //  print(_recentlyPlayedList);
   //  List<String> encoded =
   //      _recentlyPlayedList.map((obj) => jsonEncode(obj.toJson())).toList();
   //  print('save data $encoded');
   // await _sharedPreferences.setStringList(key, encoded);
  }
}

//

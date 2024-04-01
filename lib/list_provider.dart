 import 'package:flutter/cupertino.dart';

class NumberListProvider with ChangeNotifier{
  List<int> numbers = [1,2,3,4];

  void add(){
    int last = numbers.last;
    numbers.add(last+1);
    notifyListeners();
  }
}
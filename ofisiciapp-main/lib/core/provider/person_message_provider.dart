import 'package:flutter/cupertino.dart';
import 'package:ofisiciapp/core/models/message_model.dart';

class PersonMessageProvider with ChangeNotifier {
  List<MessageModel> _list = [];
  clearList() {
    _list.clear();
    notifyListeners();
  }

  insertMessage(MessageModel message) {
    _list.insert(0, message);
    notifyListeners();
  }

  revereList() {
    _list = _list.reversed.toList();
    notifyListeners();
  }

  addMessage(MessageModel message) {
    _list.add(message);
    notifyListeners();
  }

  List<MessageModel> get list => _list;
}

import 'package:flutter/cupertino.dart';

import '../models/admin_person_model.dart';

class AdminChatListProvider with ChangeNotifier {
  List<AdminPersonModel> _list = [];
  addList(AdminPersonModel model) {
    _list.add(model);
    notifyListeners();
  }

  removeList(String mail) {
    _list.removeWhere((element) => element.mail == mail);
    notifyListeners();
  }

  clearList() {
    _list.clear();
    notifyListeners();
  }

  List<AdminPersonModel> get list => _list;
}

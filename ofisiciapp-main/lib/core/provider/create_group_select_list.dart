import 'package:flutter/material.dart';

import '../models/admin_group_person_model.dart';

class SelectListProvider with ChangeNotifier {
  List<AdminGroupPersonModel> _list = [];
  addAttendee(AdminGroupPersonModel model) {
    _list.add(model);
    notifyListeners();
  }

  clearList() {
    _list.clear();
    notifyListeners();
  }

  removeAttendee(AdminGroupPersonModel model) {
    _list..remove(model);
    notifyListeners();
  }

  List<AdminGroupPersonModel> get list => _list;
}

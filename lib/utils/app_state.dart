import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/utils/constans.dart';

class AppState extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User? _user;
  String? _weekId;
  bool? _updateNotifications;

  User? get user => _user;
  String? get weekId => _weekId;
  bool? get updateNotifications => _updateNotifications;

  Future<void> setUser({
    required User user,
  }) async {
    _user = user;
    await _storage.write(
      key: kStorageUser,
      value: jsonEncode(user.toMapStorage()),
    );
    notifyListeners();
  }

  Future<void> setWeekId({
    required String weekId,
  }) async {
    _weekId = weekId;
    await _storage.write(
      key: kStorageWeekId,
      value: jsonEncode({
        'weekId': weekId,
      }),
    );
    notifyListeners();
  }

  Future<void> setUpdateNotifications({
    required bool updateNotifications,
  }) async {
    _updateNotifications = updateNotifications;
    notifyListeners();
  }

  Future<bool> userExists() async {
    final storageUserValue = await _storage.read(key: kStorageUser);
    final storageWeekIdValue = await _storage.read(key: kStorageWeekId);
    if (storageUserValue != null &&
        storageUserValue.isNotEmpty &&
        storageWeekIdValue != null &&
        storageWeekIdValue.isNotEmpty) {
      _user = User.fromMapStorage(jsonDecode(storageUserValue));
      _weekId = jsonDecode(storageWeekIdValue)['weekId'];
      return true;
    }
    return false;
  }

  Future<bool> refresh() async {
    final storageRefreshValue = await _storage.read(key: kStorageRefresh);
    if (storageRefreshValue != null && storageRefreshValue.isNotEmpty) {
      return jsonDecode(storageRefreshValue)['actualizar'];
    }
    return false;
  }

  Future<void> deleteRefresh() async {
    await _storage.delete(key: kStorageRefresh);
  }

  Future<void> resetAppState() async {
    _user = null;
    _weekId = null;
    _updateNotifications = null;
    await _storage.delete(key: kStorageUser);
    await _storage.delete(key: kStorageWeekId);
    await _storage.delete(key: kStorageRefresh);
  }
}

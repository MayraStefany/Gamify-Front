import 'package:gamify_app/models/user.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class UserService {
  final loginUserPath = 'users/login';
  final createUserPath = 'users';
  final recoverCodePath = 'users/recover-code';
  final recoverPasswordPath = 'users/recover-password';

  static final UserService _instance = UserService._privateConstructor();
  static UserService get instance => _instance;
  UserService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = await _httpService.post(
        loginUserPath,
        params: {
          'email': email,
          'password': password,
        },
      );
      return User.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'UserService.signIn');
      throw ServiceException(e.message);
    }
  }

  Future<void> addToken({
    required String token,
    required String userId,
  }) async {
    try {
      await _httpService.put(
        'users/$userId/add-token',
        params: {
          'token': token,
        },
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'UserService.addToken');
      throw ServiceException(e.message);
    }
  }

  Future<User> createUser({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = await _httpService.post(
        createUserPath,
        params: {
          'email': email,
          'password': password,
        },
      );
      return User.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'UserService.createUser');
      throw ServiceException(e.message);
    }
  }

  Future<bool> recoverCodeToEmail({
    required String email,
  }) async {
    try {
      bool sent = await _httpService.post(
        recoverCodePath,
        params: {
          'email': email,
        },
      );
      return sent;
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'UserService.recoverCodeToEmail');
      throw ServiceException(e.message);
    }
  }

  Future<void> recoverPassword({
    required String email,
    required String password,
    required String recoverCode,
  }) async {
    try {
      await _httpService.post(
        recoverPasswordPath,
        params: {
          'email': email,
          'password': password,
          'recoverCode': recoverCode,
        },
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'UserService.recoverPassword');
      throw ServiceException(e.message);
    }
  }
}

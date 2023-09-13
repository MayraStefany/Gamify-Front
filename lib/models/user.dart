class User {
  String userId;
  String email;
  String password;
  int points;
  bool? isGlobalSurveyDone;
  String? token;
  bool? isAdmin;

  User({
    required this.userId,
    required this.email,
    required this.password,
    required this.points,
    this.isGlobalSurveyDone = false,
    this.token,
    this.isAdmin = false,
  });

  User.fromMap(Map<String, dynamic> userData)
      : userId = userData['_id'],
        email = userData['email'],
        points = userData['points'],
        password = userData['password'],
        isGlobalSurveyDone = userData['isGlobalSurveyDone'],
        token = userData['token'],
        isAdmin = userData['isAdmin'] ?? false;

  User.fromMapStorage(Map<String, dynamic> userData)
      : userId = userData['userId'],
        email = userData['email'],
        points = userData['points'],
        password = userData['password'],
        isGlobalSurveyDone = userData['isGlobalSurveyDone'],
        token = userData['token'],
        isAdmin = userData['isAdmin'];

  Map<String, dynamic> toMapStorage() => {
        'userId': userId,
        'email': email,
        'points': points,
        'password': password,
        'isGlobalSurveyDone': isGlobalSurveyDone,
        'token': token,
        'isAdmin': isAdmin,
      };

  @override
  String toString() {
    return 'User{userId: $userId, email: $email, password: $password, points: $points, isGlobalSurveyDone: $isGlobalSurveyDone, token: $token, isAdmin: $isAdmin}';
  }
}

class NewPasswordModel {
  final String password;

  NewPasswordModel({required this.password});

  Map<String, dynamic> toJson() {
    return {
      'new_password': password,
    };
  }
}

class SignUpRequest {
  final String email;
  final String password;
  final String firstname;
  final String lastname;
  final String birthdate;
  final String address;

  SignUpRequest({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.address,
    required this.birthdate,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "first name": firstname,
      "last name": lastname,
      "address": address,
      "birthdate": birthdate,
    };
  }
}

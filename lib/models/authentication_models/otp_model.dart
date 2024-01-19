class OTPCheck {
  final String otp;

  OTPCheck({
    required this.otp,
  });

  Map<String, String> toJson() {
    return {
      'otp': otp,
    };
  }
}

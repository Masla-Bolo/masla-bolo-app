class Otp {
  void Function(String value)? onChanged;
  int index;
  String code;
  Otp({
    this.code = "",
    this.index = 0,
    this.onChanged,
  });
}

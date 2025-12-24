class Validators {
  Validators._(); // private constructor (no instantiation)

  static bool isValidQr(String code) {
    return code.trim().isNotEmpty && code.length > 5;
  }
}

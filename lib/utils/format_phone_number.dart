String formatPhoneNumber(String phoneNumber) {
  return phoneNumber.replaceFirst(RegExp(r'^0'), '+84');
}

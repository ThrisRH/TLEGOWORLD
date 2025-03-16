import 'dart:math';

int getRandomAmount() {
  Random random = Random();
  int amount = (random.nextInt((30000 - 10000) ~/ 1000 + 1) * 1000) + 10000;
  return amount;
}

int getRandomVoucher() {
  Random random = Random();
  int amount = (random.nextInt((1000000 - 50000) ~/ 1000 + 1) * 1000) + 10000;
  return amount;
}

String getRandomIDItem() {
  const String chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();
  return List.generate(10, (index) => chars[random.nextInt(chars.length)])
      .join();
}

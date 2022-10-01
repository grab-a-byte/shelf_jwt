extension DateTimeExtensions on DateTime {
  static DateTime fromSecondsSinceEpoch(int value) =>
      DateTime.fromMillisecondsSinceEpoch(value * 1000);

  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).floor();
}

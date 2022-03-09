extension PadZero on int {
  String get padLeadingZero => this < 10 ? "0$this" : toString();
}

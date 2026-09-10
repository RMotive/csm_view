/// Extensions for [int] type.
extension IntDuration on int {
  /// Gets the convertion to [Duration] object with the value as [seconds].
  Duration get seconds => Duration(seconds: this);

  /// Gets the convertion to [Duration] object with the value as [miliseconds].
  Duration get miliseconds => Duration(milliseconds: this);
}

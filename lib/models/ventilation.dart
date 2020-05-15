

class Ventilation {
  static final unitOfMeasurement = ' m³/h';

  final bool enabled;
  final int value;

  Ventilation({
    this.enabled,
    this.value,
  });

  String getReadableValue() {
    return '$value$unitOfMeasurement';
  }
}
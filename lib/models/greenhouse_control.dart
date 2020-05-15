abstract class GreenhouseControl {

  final String unit;
  final bool enabled;
  final int value;

  GreenhouseControl({
    this.enabled,
    this.value,
    this.unit
  });

  String getReadableValue() {
    return '$value$unit';
  }
}
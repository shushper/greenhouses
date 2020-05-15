class Greenhouse {
  final int id;
  final String name;
  final String image;
  final String thumb;

  final bool lightningToggled;
  final bool temperatureToggled;
  final bool wateringToggled;
  final bool ventilationToggled;

  final String lightning;
  final String temperature;
  final String watering;
  final String ventilation;

  Greenhouse({
    this.id,
    this.name,
    this.image,
    this.thumb,
    this.lightningToggled,
    this.temperatureToggled,
    this.wateringToggled,
    this.ventilationToggled,
    this.lightning,
    this.temperature,
    this.watering,
    this.ventilation,
  });
}

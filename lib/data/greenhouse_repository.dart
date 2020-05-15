
import 'package:greenhouses/models/greenhouse.dart';

class GreenhouseRepository {

  final greenhouses = <Greenhouse>[
    Greenhouse(
      id: 1,
      name: 'Greenhouse 1',
      image: 'assets/images/greenhouse_1.jpeg',
      thumb: 'assets/images/greenhouse_thumb_1.jpeg',
      lightningToggled: true,
      temperatureToggled: true,
      wateringToggled: false,
      ventilationToggled: false,
      lightning: '59%',
      temperature: '30°C',
      watering: null,
      ventilation: null,
    ),

    Greenhouse(
      id: 2,
      name: 'Greenhouse 2',
      image: 'assets/images/greenhouse_2.jpeg',
      thumb: 'assets/images/greenhouse_thumb_2.jpeg',
      lightningToggled: true,
      temperatureToggled: true,
      wateringToggled: false,
      ventilationToggled: true,
      lightning: '23%',
      temperature: '42°C',
      watering: null,
      ventilation: '20 m³/h',
    )
  ];


  Future<List<Greenhouse>> getGreenhouses() async {
    return greenhouses;
  }

  Future<Greenhouse> getGreenhouse(int id) async {
    return greenhouses.firstWhere((element) => element.id == id);
  }
}
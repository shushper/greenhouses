import 'package:greenhouses/models/greenhouse.dart';
import 'package:greenhouses/models/lightning.dart';
import 'package:greenhouses/models/temperature.dart';
import 'package:greenhouses/models/ventilation.dart';
import 'package:greenhouses/models/watering.dart';

class GreenhouseRepository {
  final greenhouses = <Greenhouse>[
    Greenhouse(
      id: 1,
      name: 'Greenhouse 1',
      image: 'assets/images/greenhouse_1.jpeg',
      thumb: 'assets/images/greenhouse_thumb_1.jpeg',
      images: [
        'assets/images/greenhouse_1.jpeg',
        'assets/images/greenhouse_1.jpeg',
        'assets/images/greenhouse_1.jpeg'
      ],
      lightning: Lightning(enabled: true, value: 59),
      temperature: Temperature(enabled: true, value: 30),
      watering: Watering(enabled: false, value: 0),
      ventilation: Ventilation(enabled: false, value: 0),
    ),
    Greenhouse(
      id: 2,
      name: 'Greenhouse 2',
      image: 'assets/images/greenhouse_2.jpeg',
      thumb: 'assets/images/greenhouse_thumb_2.jpeg',
      images: [
        'assets/images/greenhouse_2.jpeg',
        'assets/images/greenhouse_2.jpeg',
        'assets/images/greenhouse_2.jpeg'
      ],
      lightning: Lightning(enabled: true, value: 23),
      temperature: Temperature(enabled: true, value: 42),
      watering: Watering(enabled: false, value: 0),
      ventilation: Ventilation(enabled: true, value: 20),
    ),
    Greenhouse(
      id: 3,
      name: 'Greenhouse 3',
      image: 'assets/images/greenhouse_3.jpeg',
      thumb: 'assets/images/greenhouse_thumb_3.jpeg',
      images: [
        'assets/images/greenhouse_3.jpeg',
        'assets/images/greenhouse_3.jpeg',
        'assets/images/greenhouse_3.jpeg'
      ],
      lightning: Lightning(enabled: false, value: 0),
      temperature: Temperature(enabled: true, value: 23),
      watering: Watering(enabled: true, value: 12),
      ventilation: Ventilation(enabled: false, value: 0),
    )
  ];

  Future<List<Greenhouse>> getGreenhouses() async {
    return greenhouses;
  }

  Future<Greenhouse> getGreenhouse(int id) async {
    return greenhouses.firstWhere((element) => element.id == id);
  }

  Future<Greenhouse> setLightning(int id, Lightning lightning) async {
    final index = greenhouses.indexWhere((element) => element.id == id);
    if (index >= 0) {
      final greenhouse = greenhouses[index];
      greenhouses[index] = greenhouse.copyWith(lightning: lightning);
      return greenhouses[index];
    } else {
      throw Exception('Greenhouse with id $id does not exist');
    }
  }
}

class SensorReadLiveModel {
  final double oxygen;
  final double humidity;
  final double temperature;

  SensorReadLiveModel(
      {required this.oxygen,
      required this.humidity,
      required this.temperature});

  factory SensorReadLiveModel.fromString(String rawRead) {
    var splits = rawRead.split(",");
    return SensorReadLiveModel(
        oxygen: double.parse(splits[2]),
        humidity: double.parse(splits[1]),
        temperature: double.parse(splits[0]));
  }

  factory SensorReadLiveModel.empty() =>
      SensorReadLiveModel(oxygen: -1, humidity: -1, temperature: -1);

  @override
  String toString() {
    return 'SensorReadLiveModel{oxygen: $oxygen, humidity: $humidity, temperature: $temperature}';
  }
}

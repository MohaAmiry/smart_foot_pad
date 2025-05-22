typedef SingleValueRead = ({DateTime date, double val});
typedef ReadTypeOverall = ({
  double avg,
  double? mostCritical,
  List<SingleValueRead> outOfRangeReads
});

enum ReadType {
  oxygen("Oxygenation", "SpO2"),
  humidity("Humidity", "RH"),
  temperature("Temperature", "C");

  final String title;
  final String unit;

  const ReadType(this.title, this.unit);
}

class ReportModel {
  final int readsNumber;
  final Map<ReadType, ReadTypeOverall> reads;

  ReportModel({required this.readsNumber, required this.reads});
}

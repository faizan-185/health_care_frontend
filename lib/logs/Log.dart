class Log {
  final int? id;
  final String name;
  final String datetime;
  final String type;
  final String bill;

  Log(
      { this.id,
        required this.name,
        required this.datetime,
        required this.type,
        required this.bill});

  Log.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        datetime = res["datetime"],
        type = res["type"],
        bill = res["bill"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'datetime': datetime, 'type': type, 'bill': bill};
  }
}

class DrLog {
  final int? id;
  final String name;
  final String datetime;
  final String type;

  DrLog(
      { this.id,
        required this.name,
        required this.datetime,
        required this.type});

  DrLog.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        datetime = res["datetime"],
        type = res["type"];

  Map<String, Object?> toMap() {
    return {'id':id,'name': name, 'datetime': datetime, 'type': type};
  }
}
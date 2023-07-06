import 'dart:convert';
import 'package:equatable/equatable.dart';

Weekday weekdayFromJson(String str) => Weekday.fromJson(json.decode(str));

String weekdayToJson(Weekday data) => json.encode(data.toJson());

// ignore: must_be_immutable
class Weekday extends Equatable {
  Weekday({
    this.id,
    this.dayBn,
    this.dayEn,
    this.status,
  });

  int? id;
  String? dayBn;
  String? dayEn;
  bool? status;

  Weekday copyWith({
    int? id,
    String? dayBn,
    String? dayEn,
    bool? status,
  }) =>
      Weekday(
        id: id ?? this.id,
        dayBn: dayBn ?? this.dayBn,
        dayEn: dayEn ?? this.dayEn,
        status: status ?? this.status,
      );

  factory Weekday.fromJson(Map<String, dynamic> json) => Weekday(
        id: json["id"],
        dayBn: json["day_bn"],
        dayEn: json["day_en"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_bn": dayBn,
        "day_en": dayEn,
        "status": status,
      };

  @override
  List<Object?> get props => [id];
}

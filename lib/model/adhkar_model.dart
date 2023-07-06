import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

enum ItemsView { list, grid }

Adhkar adhkarFromJson(String str) => Adhkar.fromJson(json.decode(str));

String adhkarToJson(Adhkar data) => json.encode(data.toJson());

// ignore: must_be_immutable
class Adhkar extends Equatable {
  Adhkar({
    this.id,
    this.titleBn,
    this.titleEn,
    this.contentColor,
    this.backdrop,
    this.background,
    this.itemsBackground,
    this.itemView,
    this.progress,
    this.brightness,
    this.weekdays,
    this.items,
  });

  int? id;
  String? titleBn;
  String? titleEn;
  Color? contentColor;
  String? backdrop;
  LinearGradient? background;
  Color? itemsBackground;
  ItemsView? itemView;
  double? progress;
  Brightness? brightness;
  List<int>? weekdays;
  List<AdhkarItem>? items;

  Adhkar copyWith({
    int? id,
    String? titleBn,
    String? titleEn,
    Color? contentColor,
    String? backdrop,
    LinearGradient? background,
    Color? itemsBackground,
    ItemsView? itemView,
    double? progress,
    Brightness? brightness,
    List<int>? weekdays,
    List<AdhkarItem>? items,
  }) =>
      Adhkar(
        id: id ?? this.id,
        titleBn: titleBn ?? this.titleBn,
        titleEn: titleEn ?? this.titleEn,
        contentColor: contentColor ?? this.contentColor,
        backdrop: backdrop ?? this.backdrop,
        background: backdrop as LinearGradient? ?? this.background,
        itemsBackground: backdrop as Color? ?? this.itemsBackground,
        itemView: itemView ?? this.itemView,
        progress: progress ?? this.progress,
        brightness: brightness ?? this.brightness,
        weekdays: weekdays ?? this.weekdays,
        items: items ?? this.items,
      );

  factory Adhkar.fromJson(Map<String, dynamic> json) => Adhkar(
        id: json["id"],
        titleBn: json["title_bn"],
        titleEn: json["title_en"],
        contentColor: json["content_color"],
        backdrop: json["backdrop"],
        background: json["background"],
        itemsBackground: json["items_background"],
        itemView: json["item_view"],
        progress: json["progress"],
        brightness: json["brightness"],
        weekdays: json["weekdays"] == null
            ? null
            : List<int>.from(json["weekdays"].map((x) => x)),
        items: json["items"] == null
            ? null
            : List<AdhkarItem>.from(
                json["items"].map((x) => AdhkarItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title_bn": titleBn,
        "title_en": titleEn,
        "content_color": contentColor,
        "backdrop": backdrop,
        "background": background,
        "items_background": itemsBackground,
        "item_view": itemView,
        "progress": progress,
        "brightness": brightness,
        "weekdays": weekdays == null
            ? null
            : List<dynamic>.from(weekdays!.map((x) => x)),
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [id];
}

// ignore: must_be_immutable
class AdhkarItem extends Equatable {
  AdhkarItem({
    this.id,
    this.adhkarIds,
    this.icon,
    this.titleBn,
    this.titleEn,
    this.detailBn,
    this.detailEn,
    this.read = false,
  });

  int? id;
  List<int>? adhkarIds;
  String? icon;
  String? titleBn;
  String? titleEn;
  Detail? detailBn;
  Detail? detailEn;
  bool? read;

  AdhkarItem copyWith({
    int? id,
    List<int>? azkarIds,
    String? icon,
    String? titleBn,
    String? titleEn,
    Detail? detailBn,
    Detail? detailEn,
    bool? read,
  }) =>
      AdhkarItem(
        id: id ?? this.id,
        adhkarIds: azkarIds ?? adhkarIds,
        icon: icon ?? this.icon,
        titleBn: titleBn ?? this.titleBn,
        titleEn: titleEn ?? this.titleEn,
        detailBn: detailBn ?? this.detailBn,
        detailEn: detailEn ?? this.detailEn,
        read: read ?? this.read,
      );

  factory AdhkarItem.fromJson(Map<String, dynamic> json) => AdhkarItem(
        id: json["id"],
        adhkarIds: json["adhkar_ids"] == null
            ? null
            : List<int>.from(json["adhkar_ids"].map((x) => x)),
        icon: json["icon"],
        titleBn: json["title_bn"],
        titleEn: json["title_en"],
        detailBn: json["detail_bn"] == null
            ? null
            : Detail.fromJson(json["detail_bn"]),
        detailEn: json["detail_en"] == null
            ? null
            : Detail.fromJson(json["detail_en"]),
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "adhkar_ids": adhkarIds == null
            ? null
            : List<dynamic>.from(adhkarIds!.map((x) => x)),
        "icon": icon,
        "title_bn": titleBn,
        "title_en": titleEn,
        "detail_bn": detailBn == null ? null : detailBn!.toJson(),
        "detail_en": detailEn == null ? null : detailEn!.toJson(),
        "read": read,
      };

  @override
  List<Object?> get props => [id];
}

class Detail {
  Detail({
    this.title,
    this.times,
    this.verses,
    this.source,
    this.explanation,
  });

  String? title;
  String? times;
  String? source;
  List<Verse>? verses;
  String? explanation;

  Detail copyWith({
    String? title,
    String? times,
    List<Verse>? verses,
    String? source,
    String? explanation,
  }) =>
      Detail(
        title: title ?? this.title,
        times: times ?? this.times,
        verses: verses ?? this.verses,
        source: source ?? this.source,
        explanation: explanation ?? this.explanation,
      );

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        title: json["title"],
        times: json["times"],
        verses: json["verses"] == null
            ? null
            : List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
        source: json["source"],
        explanation: json["explanation"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "times": times,
        "verses": verses == null
            ? null
            : List<dynamic>.from(verses!.map((x) => x.toJson())),
        "source": source,
        "explanation": explanation,
      };
}

class Verse {
  Verse({
    this.id,
    this.title,
    this.times,
    this.arabic,
    this.pronounce,
    this.meaning,
  });

  int? id;
  String? title;
  String? times;
  String? arabic;
  String? pronounce;
  String? meaning;

  Verse copyWith({
    int? id,
    String? title,
    String? times,
    String? arabic,
    String? pronounce,
    String? meaning,
  }) =>
      Verse(
        id: id ?? this.id,
        title: title ?? this.title,
        times: times ?? this.times,
        arabic: arabic ?? this.arabic,
        pronounce: pronounce ?? this.pronounce,
        meaning: meaning ?? this.meaning,
      );

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        title: json["title"],
        times: json["times"],
        arabic: json["arabic"],
        pronounce: json["pronounce"],
        meaning: json["meaning"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "times": times,
        "arabic": arabic,
        "pronounce": pronounce,
        "meaning": meaning,
      };
}

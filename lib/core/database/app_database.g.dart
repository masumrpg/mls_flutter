// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SurahsTableTable extends SurahsTable
    with TableInfo<$SurahsTableTable, SurahsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameLatinMeta = const VerificationMeta(
    'nameLatin',
  );
  @override
  late final GeneratedColumn<String> nameLatin = GeneratedColumn<String>(
    'name_latin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfAyahsMeta = const VerificationMeta(
    'numberOfAyahs',
  );
  @override
  late final GeneratedColumn<int> numberOfAyahs = GeneratedColumn<int>(
    'number_of_ayahs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationMeta = const VerificationMeta(
    'revelation',
  );
  @override
  late final GeneratedColumn<String> revelation = GeneratedColumn<String>(
    'revelation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    number,
    name,
    nameLatin,
    numberOfAyahs,
    translation,
    revelation,
    description,
    audioUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surahs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SurahsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_latin')) {
      context.handle(
        _nameLatinMeta,
        nameLatin.isAcceptableOrUnknown(data['name_latin']!, _nameLatinMeta),
      );
    } else if (isInserting) {
      context.missing(_nameLatinMeta);
    }
    if (data.containsKey('number_of_ayahs')) {
      context.handle(
        _numberOfAyahsMeta,
        numberOfAyahs.isAcceptableOrUnknown(
          data['number_of_ayahs']!,
          _numberOfAyahsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfAyahsMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('revelation')) {
      context.handle(
        _revelationMeta,
        revelation.isAcceptableOrUnknown(data['revelation']!, _revelationMeta),
      );
    } else if (isInserting) {
      context.missing(_revelationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  SurahsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurahsTableData(
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameLatin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_latin'],
      )!,
      numberOfAyahs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_ayahs'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      revelation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      )!,
    );
  }

  @override
  $SurahsTableTable createAlias(String alias) {
    return $SurahsTableTable(attachedDatabase, alias);
  }
}

class SurahsTableData extends DataClass implements Insertable<SurahsTableData> {
  final int number;
  final String name;
  final String nameLatin;
  final int numberOfAyahs;
  final String translation;
  final String revelation;
  final String description;
  final String audioUrl;
  const SurahsTableData({
    required this.number,
    required this.name,
    required this.nameLatin,
    required this.numberOfAyahs,
    required this.translation,
    required this.revelation,
    required this.description,
    required this.audioUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['name'] = Variable<String>(name);
    map['name_latin'] = Variable<String>(nameLatin);
    map['number_of_ayahs'] = Variable<int>(numberOfAyahs);
    map['translation'] = Variable<String>(translation);
    map['revelation'] = Variable<String>(revelation);
    map['description'] = Variable<String>(description);
    map['audio_url'] = Variable<String>(audioUrl);
    return map;
  }

  SurahsTableCompanion toCompanion(bool nullToAbsent) {
    return SurahsTableCompanion(
      number: Value(number),
      name: Value(name),
      nameLatin: Value(nameLatin),
      numberOfAyahs: Value(numberOfAyahs),
      translation: Value(translation),
      revelation: Value(revelation),
      description: Value(description),
      audioUrl: Value(audioUrl),
    );
  }

  factory SurahsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurahsTableData(
      number: serializer.fromJson<int>(json['number']),
      name: serializer.fromJson<String>(json['name']),
      nameLatin: serializer.fromJson<String>(json['nameLatin']),
      numberOfAyahs: serializer.fromJson<int>(json['numberOfAyahs']),
      translation: serializer.fromJson<String>(json['translation']),
      revelation: serializer.fromJson<String>(json['revelation']),
      description: serializer.fromJson<String>(json['description']),
      audioUrl: serializer.fromJson<String>(json['audioUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'name': serializer.toJson<String>(name),
      'nameLatin': serializer.toJson<String>(nameLatin),
      'numberOfAyahs': serializer.toJson<int>(numberOfAyahs),
      'translation': serializer.toJson<String>(translation),
      'revelation': serializer.toJson<String>(revelation),
      'description': serializer.toJson<String>(description),
      'audioUrl': serializer.toJson<String>(audioUrl),
    };
  }

  SurahsTableData copyWith({
    int? number,
    String? name,
    String? nameLatin,
    int? numberOfAyahs,
    String? translation,
    String? revelation,
    String? description,
    String? audioUrl,
  }) => SurahsTableData(
    number: number ?? this.number,
    name: name ?? this.name,
    nameLatin: nameLatin ?? this.nameLatin,
    numberOfAyahs: numberOfAyahs ?? this.numberOfAyahs,
    translation: translation ?? this.translation,
    revelation: revelation ?? this.revelation,
    description: description ?? this.description,
    audioUrl: audioUrl ?? this.audioUrl,
  );
  SurahsTableData copyWithCompanion(SurahsTableCompanion data) {
    return SurahsTableData(
      number: data.number.present ? data.number.value : this.number,
      name: data.name.present ? data.name.value : this.name,
      nameLatin: data.nameLatin.present ? data.nameLatin.value : this.nameLatin,
      numberOfAyahs: data.numberOfAyahs.present
          ? data.numberOfAyahs.value
          : this.numberOfAyahs,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      revelation: data.revelation.present
          ? data.revelation.value
          : this.revelation,
      description: data.description.present
          ? data.description.value
          : this.description,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SurahsTableData(')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('nameLatin: $nameLatin, ')
          ..write('numberOfAyahs: $numberOfAyahs, ')
          ..write('translation: $translation, ')
          ..write('revelation: $revelation, ')
          ..write('description: $description, ')
          ..write('audioUrl: $audioUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    number,
    name,
    nameLatin,
    numberOfAyahs,
    translation,
    revelation,
    description,
    audioUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurahsTableData &&
          other.number == this.number &&
          other.name == this.name &&
          other.nameLatin == this.nameLatin &&
          other.numberOfAyahs == this.numberOfAyahs &&
          other.translation == this.translation &&
          other.revelation == this.revelation &&
          other.description == this.description &&
          other.audioUrl == this.audioUrl);
}

class SurahsTableCompanion extends UpdateCompanion<SurahsTableData> {
  final Value<int> number;
  final Value<String> name;
  final Value<String> nameLatin;
  final Value<int> numberOfAyahs;
  final Value<String> translation;
  final Value<String> revelation;
  final Value<String> description;
  final Value<String> audioUrl;
  const SurahsTableCompanion({
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.nameLatin = const Value.absent(),
    this.numberOfAyahs = const Value.absent(),
    this.translation = const Value.absent(),
    this.revelation = const Value.absent(),
    this.description = const Value.absent(),
    this.audioUrl = const Value.absent(),
  });
  SurahsTableCompanion.insert({
    this.number = const Value.absent(),
    required String name,
    required String nameLatin,
    required int numberOfAyahs,
    required String translation,
    required String revelation,
    required String description,
    this.audioUrl = const Value.absent(),
  }) : name = Value(name),
       nameLatin = Value(nameLatin),
       numberOfAyahs = Value(numberOfAyahs),
       translation = Value(translation),
       revelation = Value(revelation),
       description = Value(description);
  static Insertable<SurahsTableData> custom({
    Expression<int>? number,
    Expression<String>? name,
    Expression<String>? nameLatin,
    Expression<int>? numberOfAyahs,
    Expression<String>? translation,
    Expression<String>? revelation,
    Expression<String>? description,
    Expression<String>? audioUrl,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (nameLatin != null) 'name_latin': nameLatin,
      if (numberOfAyahs != null) 'number_of_ayahs': numberOfAyahs,
      if (translation != null) 'translation': translation,
      if (revelation != null) 'revelation': revelation,
      if (description != null) 'description': description,
      if (audioUrl != null) 'audio_url': audioUrl,
    });
  }

  SurahsTableCompanion copyWith({
    Value<int>? number,
    Value<String>? name,
    Value<String>? nameLatin,
    Value<int>? numberOfAyahs,
    Value<String>? translation,
    Value<String>? revelation,
    Value<String>? description,
    Value<String>? audioUrl,
  }) {
    return SurahsTableCompanion(
      number: number ?? this.number,
      name: name ?? this.name,
      nameLatin: nameLatin ?? this.nameLatin,
      numberOfAyahs: numberOfAyahs ?? this.numberOfAyahs,
      translation: translation ?? this.translation,
      revelation: revelation ?? this.revelation,
      description: description ?? this.description,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameLatin.present) {
      map['name_latin'] = Variable<String>(nameLatin.value);
    }
    if (numberOfAyahs.present) {
      map['number_of_ayahs'] = Variable<int>(numberOfAyahs.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (revelation.present) {
      map['revelation'] = Variable<String>(revelation.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahsTableCompanion(')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('nameLatin: $nameLatin, ')
          ..write('numberOfAyahs: $numberOfAyahs, ')
          ..write('translation: $translation, ')
          ..write('revelation: $revelation, ')
          ..write('description: $description, ')
          ..write('audioUrl: $audioUrl')
          ..write(')'))
        .toString();
  }
}

class $AyahsTableTable extends AyahsTable
    with TableInfo<$AyahsTableTable, AyahsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabMeta = const VerificationMeta('arab');
  @override
  late final GeneratedColumn<String> arab = GeneratedColumn<String>(
    'arab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioUrlMeta = const VerificationMeta(
    'audioUrl',
  );
  @override
  late final GeneratedColumn<String> audioUrl = GeneratedColumn<String>(
    'audio_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    arab,
    translation,
    audioUrl,
    imageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayahs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AyahsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('arab')) {
      context.handle(
        _arabMeta,
        arab.isAcceptableOrUnknown(data['arab']!, _arabMeta),
      );
    } else if (isInserting) {
      context.missing(_arabMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('audio_url')) {
      context.handle(
        _audioUrlMeta,
        audioUrl.isAcceptableOrUnknown(data['audio_url']!, _audioUrlMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AyahsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AyahsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      arab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arab'],
      )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      )!,
      audioUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_url'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
    );
  }

  @override
  $AyahsTableTable createAlias(String alias) {
    return $AyahsTableTable(attachedDatabase, alias);
  }
}

class AyahsTableData extends DataClass implements Insertable<AyahsTableData> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final String arab;
  final String translation;
  final String? audioUrl;
  final String? imageUrl;
  const AyahsTableData({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.arab,
    required this.translation,
    this.audioUrl,
    this.imageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['arab'] = Variable<String>(arab);
    map['translation'] = Variable<String>(translation);
    if (!nullToAbsent || audioUrl != null) {
      map['audio_url'] = Variable<String>(audioUrl);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    return map;
  }

  AyahsTableCompanion toCompanion(bool nullToAbsent) {
    return AyahsTableCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      arab: Value(arab),
      translation: Value(translation),
      audioUrl: audioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(audioUrl),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
    );
  }

  factory AyahsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AyahsTableData(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      arab: serializer.fromJson<String>(json['arab']),
      translation: serializer.fromJson<String>(json['translation']),
      audioUrl: serializer.fromJson<String?>(json['audioUrl']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'arab': serializer.toJson<String>(arab),
      'translation': serializer.toJson<String>(translation),
      'audioUrl': serializer.toJson<String?>(audioUrl),
      'imageUrl': serializer.toJson<String?>(imageUrl),
    };
  }

  AyahsTableData copyWith({
    int? id,
    int? surahNumber,
    int? ayahNumber,
    String? arab,
    String? translation,
    Value<String?> audioUrl = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
  }) => AyahsTableData(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    arab: arab ?? this.arab,
    translation: translation ?? this.translation,
    audioUrl: audioUrl.present ? audioUrl.value : this.audioUrl,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
  );
  AyahsTableData copyWithCompanion(AyahsTableCompanion data) {
    return AyahsTableData(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      arab: data.arab.present ? data.arab.value : this.arab,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      audioUrl: data.audioUrl.present ? data.audioUrl.value : this.audioUrl,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AyahsTableData(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('arab: $arab, ')
          ..write('translation: $translation, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    surahNumber,
    ayahNumber,
    arab,
    translation,
    audioUrl,
    imageUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AyahsTableData &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.arab == this.arab &&
          other.translation == this.translation &&
          other.audioUrl == this.audioUrl &&
          other.imageUrl == this.imageUrl);
}

class AyahsTableCompanion extends UpdateCompanion<AyahsTableData> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> arab;
  final Value<String> translation;
  final Value<String?> audioUrl;
  final Value<String?> imageUrl;
  const AyahsTableCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.arab = const Value.absent(),
    this.translation = const Value.absent(),
    this.audioUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  AyahsTableCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required String arab,
    required String translation,
    this.audioUrl = const Value.absent(),
    this.imageUrl = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       arab = Value(arab),
       translation = Value(translation);
  static Insertable<AyahsTableData> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? arab,
    Expression<String>? translation,
    Expression<String>? audioUrl,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (arab != null) 'arab': arab,
      if (translation != null) 'translation': translation,
      if (audioUrl != null) 'audio_url': audioUrl,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  AyahsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? arab,
    Value<String>? translation,
    Value<String?>? audioUrl,
    Value<String?>? imageUrl,
  }) {
    return AyahsTableCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      arab: arab ?? this.arab,
      translation: translation ?? this.translation,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (arab.present) {
      map['arab'] = Variable<String>(arab.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (audioUrl.present) {
      map['audio_url'] = Variable<String>(audioUrl.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahsTableCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('arab: $arab, ')
          ..write('translation: $translation, ')
          ..write('audioUrl: $audioUrl, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTableTable extends BookmarksTable
    with TableInfo<$BookmarksTableTable, BookmarksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _surahNameMeta = const VerificationMeta(
    'surahName',
  );
  @override
  late final GeneratedColumn<String> surahName = GeneratedColumn<String>(
    'surah_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    surahNumber,
    ayahNumber,
    surahName,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarksTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('surah_name')) {
      context.handle(
        _surahNameMeta,
        surahName.isAcceptableOrUnknown(data['surah_name']!, _surahNameMeta),
      );
    } else if (isInserting) {
      context.missing(_surahNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookmarksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarksTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      surahName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surah_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTableTable createAlias(String alias) {
    return $BookmarksTableTable(attachedDatabase, alias);
  }
}

class BookmarksTableData extends DataClass
    implements Insertable<BookmarksTableData> {
  final int id;
  final int surahNumber;
  final int ayahNumber;
  final String surahName;
  final DateTime createdAt;
  const BookmarksTableData({
    required this.id,
    required this.surahNumber,
    required this.ayahNumber,
    required this.surahName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['surah_name'] = Variable<String>(surahName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksTableCompanion toCompanion(bool nullToAbsent) {
    return BookmarksTableCompanion(
      id: Value(id),
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      surahName: Value(surahName),
      createdAt: Value(createdAt),
    );
  }

  factory BookmarksTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarksTableData(
      id: serializer.fromJson<int>(json['id']),
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      surahName: serializer.fromJson<String>(json['surahName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'surahName': serializer.toJson<String>(surahName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BookmarksTableData copyWith({
    int? id,
    int? surahNumber,
    int? ayahNumber,
    String? surahName,
    DateTime? createdAt,
  }) => BookmarksTableData(
    id: id ?? this.id,
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    surahName: surahName ?? this.surahName,
    createdAt: createdAt ?? this.createdAt,
  );
  BookmarksTableData copyWithCompanion(BookmarksTableCompanion data) {
    return BookmarksTableData(
      id: data.id.present ? data.id.value : this.id,
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      surahName: data.surahName.present ? data.surahName.value : this.surahName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksTableData(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('surahName: $surahName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surahNumber, ayahNumber, surahName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarksTableData &&
          other.id == this.id &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.surahName == this.surahName &&
          other.createdAt == this.createdAt);
}

class BookmarksTableCompanion extends UpdateCompanion<BookmarksTableData> {
  final Value<int> id;
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> surahName;
  final Value<DateTime> createdAt;
  const BookmarksTableCompanion({
    this.id = const Value.absent(),
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.surahName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksTableCompanion.insert({
    this.id = const Value.absent(),
    required int surahNumber,
    required int ayahNumber,
    required String surahName,
    this.createdAt = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       surahName = Value(surahName);
  static Insertable<BookmarksTableData> custom({
    Expression<int>? id,
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? surahName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (surahName != null) 'surah_name': surahName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksTableCompanion copyWith({
    Value<int>? id,
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? surahName,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksTableCompanion(
      id: id ?? this.id,
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      surahName: surahName ?? this.surahName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (surahName.present) {
      map['surah_name'] = Variable<String>(surahName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksTableCompanion(')
          ..write('id: $id, ')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('surahName: $surahName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahsTableTable surahsTable = $SurahsTableTable(this);
  late final $AyahsTableTable ayahsTable = $AyahsTableTable(this);
  late final $BookmarksTableTable bookmarksTable = $BookmarksTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahsTable,
    ayahsTable,
    bookmarksTable,
  ];
}

typedef $$SurahsTableTableCreateCompanionBuilder =
    SurahsTableCompanion Function({
      Value<int> number,
      required String name,
      required String nameLatin,
      required int numberOfAyahs,
      required String translation,
      required String revelation,
      required String description,
      Value<String> audioUrl,
    });
typedef $$SurahsTableTableUpdateCompanionBuilder =
    SurahsTableCompanion Function({
      Value<int> number,
      Value<String> name,
      Value<String> nameLatin,
      Value<int> numberOfAyahs,
      Value<String> translation,
      Value<String> revelation,
      Value<String> description,
      Value<String> audioUrl,
    });

class $$SurahsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SurahsTableTable> {
  $$SurahsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameLatin => $composableBuilder(
    column: $table.nameLatin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfAyahs => $composableBuilder(
    column: $table.numberOfAyahs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get revelation => $composableBuilder(
    column: $table.revelation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SurahsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahsTableTable> {
  $$SurahsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameLatin => $composableBuilder(
    column: $table.nameLatin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfAyahs => $composableBuilder(
    column: $table.numberOfAyahs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelation => $composableBuilder(
    column: $table.revelation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahsTableTable> {
  $$SurahsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameLatin =>
      $composableBuilder(column: $table.nameLatin, builder: (column) => column);

  GeneratedColumn<int> get numberOfAyahs => $composableBuilder(
    column: $table.numberOfAyahs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get revelation => $composableBuilder(
    column: $table.revelation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);
}

class $$SurahsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahsTableTable,
          SurahsTableData,
          $$SurahsTableTableFilterComposer,
          $$SurahsTableTableOrderingComposer,
          $$SurahsTableTableAnnotationComposer,
          $$SurahsTableTableCreateCompanionBuilder,
          $$SurahsTableTableUpdateCompanionBuilder,
          (
            SurahsTableData,
            BaseReferences<_$AppDatabase, $SurahsTableTable, SurahsTableData>,
          ),
          SurahsTableData,
          PrefetchHooks Function()
        > {
  $$SurahsTableTableTableManager(_$AppDatabase db, $SurahsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nameLatin = const Value.absent(),
                Value<int> numberOfAyahs = const Value.absent(),
                Value<String> translation = const Value.absent(),
                Value<String> revelation = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> audioUrl = const Value.absent(),
              }) => SurahsTableCompanion(
                number: number,
                name: name,
                nameLatin: nameLatin,
                numberOfAyahs: numberOfAyahs,
                translation: translation,
                revelation: revelation,
                description: description,
                audioUrl: audioUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String name,
                required String nameLatin,
                required int numberOfAyahs,
                required String translation,
                required String revelation,
                required String description,
                Value<String> audioUrl = const Value.absent(),
              }) => SurahsTableCompanion.insert(
                number: number,
                name: name,
                nameLatin: nameLatin,
                numberOfAyahs: numberOfAyahs,
                translation: translation,
                revelation: revelation,
                description: description,
                audioUrl: audioUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SurahsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahsTableTable,
      SurahsTableData,
      $$SurahsTableTableFilterComposer,
      $$SurahsTableTableOrderingComposer,
      $$SurahsTableTableAnnotationComposer,
      $$SurahsTableTableCreateCompanionBuilder,
      $$SurahsTableTableUpdateCompanionBuilder,
      (
        SurahsTableData,
        BaseReferences<_$AppDatabase, $SurahsTableTable, SurahsTableData>,
      ),
      SurahsTableData,
      PrefetchHooks Function()
    >;
typedef $$AyahsTableTableCreateCompanionBuilder =
    AyahsTableCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int ayahNumber,
      required String arab,
      required String translation,
      Value<String?> audioUrl,
      Value<String?> imageUrl,
    });
typedef $$AyahsTableTableUpdateCompanionBuilder =
    AyahsTableCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> arab,
      Value<String> translation,
      Value<String?> audioUrl,
      Value<String?> imageUrl,
    });

class $$AyahsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AyahsTableTable> {
  $$AyahsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arab => $composableBuilder(
    column: $table.arab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AyahsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahsTableTable> {
  $$AyahsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arab => $composableBuilder(
    column: $table.arab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioUrl => $composableBuilder(
    column: $table.audioUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AyahsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahsTableTable> {
  $$AyahsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arab =>
      $composableBuilder(column: $table.arab, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get audioUrl =>
      $composableBuilder(column: $table.audioUrl, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$AyahsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahsTableTable,
          AyahsTableData,
          $$AyahsTableTableFilterComposer,
          $$AyahsTableTableOrderingComposer,
          $$AyahsTableTableAnnotationComposer,
          $$AyahsTableTableCreateCompanionBuilder,
          $$AyahsTableTableUpdateCompanionBuilder,
          (
            AyahsTableData,
            BaseReferences<_$AppDatabase, $AyahsTableTable, AyahsTableData>,
          ),
          AyahsTableData,
          PrefetchHooks Function()
        > {
  $$AyahsTableTableTableManager(_$AppDatabase db, $AyahsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> arab = const Value.absent(),
                Value<String> translation = const Value.absent(),
                Value<String?> audioUrl = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
              }) => AyahsTableCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                arab: arab,
                translation: translation,
                audioUrl: audioUrl,
                imageUrl: imageUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                required String arab,
                required String translation,
                Value<String?> audioUrl = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
              }) => AyahsTableCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                arab: arab,
                translation: translation,
                audioUrl: audioUrl,
                imageUrl: imageUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AyahsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahsTableTable,
      AyahsTableData,
      $$AyahsTableTableFilterComposer,
      $$AyahsTableTableOrderingComposer,
      $$AyahsTableTableAnnotationComposer,
      $$AyahsTableTableCreateCompanionBuilder,
      $$AyahsTableTableUpdateCompanionBuilder,
      (
        AyahsTableData,
        BaseReferences<_$AppDatabase, $AyahsTableTable, AyahsTableData>,
      ),
      AyahsTableData,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableTableCreateCompanionBuilder =
    BookmarksTableCompanion Function({
      Value<int> id,
      required int surahNumber,
      required int ayahNumber,
      required String surahName,
      Value<DateTime> createdAt,
    });
typedef $$BookmarksTableTableUpdateCompanionBuilder =
    BookmarksTableCompanion Function({
      Value<int> id,
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> surahName,
      Value<DateTime> createdAt,
    });

class $$BookmarksTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surahName => $composableBuilder(
    column: $table.surahName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surahName => $composableBuilder(
    column: $table.surahName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTableTable> {
  $$BookmarksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get surahNumber => $composableBuilder(
    column: $table.surahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get surahName =>
      $composableBuilder(column: $table.surahName, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTableTable,
          BookmarksTableData,
          $$BookmarksTableTableFilterComposer,
          $$BookmarksTableTableOrderingComposer,
          $$BookmarksTableTableAnnotationComposer,
          $$BookmarksTableTableCreateCompanionBuilder,
          $$BookmarksTableTableUpdateCompanionBuilder,
          (
            BookmarksTableData,
            BaseReferences<
              _$AppDatabase,
              $BookmarksTableTable,
              BookmarksTableData
            >,
          ),
          BookmarksTableData,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableTableManager(
    _$AppDatabase db,
    $BookmarksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> surahName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksTableCompanion(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                surahName: surahName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahNumber,
                required int ayahNumber,
                required String surahName,
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksTableCompanion.insert(
                id: id,
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                surahName: surahName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTableTable,
      BookmarksTableData,
      $$BookmarksTableTableFilterComposer,
      $$BookmarksTableTableOrderingComposer,
      $$BookmarksTableTableAnnotationComposer,
      $$BookmarksTableTableCreateCompanionBuilder,
      $$BookmarksTableTableUpdateCompanionBuilder,
      (
        BookmarksTableData,
        BaseReferences<_$AppDatabase, $BookmarksTableTable, BookmarksTableData>,
      ),
      BookmarksTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahsTableTableTableManager get surahsTable =>
      $$SurahsTableTableTableManager(_db, _db.surahsTable);
  $$AyahsTableTableTableManager get ayahsTable =>
      $$AyahsTableTableTableManager(_db, _db.ayahsTable);
  $$BookmarksTableTableTableManager get bookmarksTable =>
      $$BookmarksTableTableTableManager(_db, _db.bookmarksTable);
}

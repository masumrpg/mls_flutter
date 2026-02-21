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

class $PrayerSchedulesTableTable extends PrayerSchedulesTable
    with TableInfo<$PrayerSchedulesTableTable, PrayerSchedulesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerSchedulesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  @override
  late final GeneratedColumn<String> cityId = GeneratedColumn<String>(
    'city_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityNameMeta = const VerificationMeta(
    'cityName',
  );
  @override
  late final GeneratedColumn<String> cityName = GeneratedColumn<String>(
    'city_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _provinceMeta = const VerificationMeta(
    'province',
  );
  @override
  late final GeneratedColumn<String> province = GeneratedColumn<String>(
    'province',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imsakMeta = const VerificationMeta('imsak');
  @override
  late final GeneratedColumn<String> imsak = GeneratedColumn<String>(
    'imsak',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subuhMeta = const VerificationMeta('subuh');
  @override
  late final GeneratedColumn<String> subuh = GeneratedColumn<String>(
    'subuh',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _terbitMeta = const VerificationMeta('terbit');
  @override
  late final GeneratedColumn<String> terbit = GeneratedColumn<String>(
    'terbit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dhuhaMeta = const VerificationMeta('dhuha');
  @override
  late final GeneratedColumn<String> dhuha = GeneratedColumn<String>(
    'dhuha',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dzuhurMeta = const VerificationMeta('dzuhur');
  @override
  late final GeneratedColumn<String> dzuhur = GeneratedColumn<String>(
    'dzuhur',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _asharMeta = const VerificationMeta('ashar');
  @override
  late final GeneratedColumn<String> ashar = GeneratedColumn<String>(
    'ashar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maghribMeta = const VerificationMeta(
    'maghrib',
  );
  @override
  late final GeneratedColumn<String> maghrib = GeneratedColumn<String>(
    'maghrib',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isyaMeta = const VerificationMeta('isya');
  @override
  late final GeneratedColumn<String> isya = GeneratedColumn<String>(
    'isya',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cityId,
    cityName,
    province,
    date,
    imsak,
    subuh,
    terbit,
    dhuha,
    dzuhur,
    ashar,
    maghrib,
    isya,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_schedules_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerSchedulesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('city_id')) {
      context.handle(
        _cityIdMeta,
        cityId.isAcceptableOrUnknown(data['city_id']!, _cityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cityIdMeta);
    }
    if (data.containsKey('city_name')) {
      context.handle(
        _cityNameMeta,
        cityName.isAcceptableOrUnknown(data['city_name']!, _cityNameMeta),
      );
    } else if (isInserting) {
      context.missing(_cityNameMeta);
    }
    if (data.containsKey('province')) {
      context.handle(
        _provinceMeta,
        province.isAcceptableOrUnknown(data['province']!, _provinceMeta),
      );
    } else if (isInserting) {
      context.missing(_provinceMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('imsak')) {
      context.handle(
        _imsakMeta,
        imsak.isAcceptableOrUnknown(data['imsak']!, _imsakMeta),
      );
    } else if (isInserting) {
      context.missing(_imsakMeta);
    }
    if (data.containsKey('subuh')) {
      context.handle(
        _subuhMeta,
        subuh.isAcceptableOrUnknown(data['subuh']!, _subuhMeta),
      );
    } else if (isInserting) {
      context.missing(_subuhMeta);
    }
    if (data.containsKey('terbit')) {
      context.handle(
        _terbitMeta,
        terbit.isAcceptableOrUnknown(data['terbit']!, _terbitMeta),
      );
    } else if (isInserting) {
      context.missing(_terbitMeta);
    }
    if (data.containsKey('dhuha')) {
      context.handle(
        _dhuhaMeta,
        dhuha.isAcceptableOrUnknown(data['dhuha']!, _dhuhaMeta),
      );
    } else if (isInserting) {
      context.missing(_dhuhaMeta);
    }
    if (data.containsKey('dzuhur')) {
      context.handle(
        _dzuhurMeta,
        dzuhur.isAcceptableOrUnknown(data['dzuhur']!, _dzuhurMeta),
      );
    } else if (isInserting) {
      context.missing(_dzuhurMeta);
    }
    if (data.containsKey('ashar')) {
      context.handle(
        _asharMeta,
        ashar.isAcceptableOrUnknown(data['ashar']!, _asharMeta),
      );
    } else if (isInserting) {
      context.missing(_asharMeta);
    }
    if (data.containsKey('maghrib')) {
      context.handle(
        _maghribMeta,
        maghrib.isAcceptableOrUnknown(data['maghrib']!, _maghribMeta),
      );
    } else if (isInserting) {
      context.missing(_maghribMeta);
    }
    if (data.containsKey('isya')) {
      context.handle(
        _isyaMeta,
        isya.isAcceptableOrUnknown(data['isya']!, _isyaMeta),
      );
    } else if (isInserting) {
      context.missing(_isyaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrayerSchedulesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerSchedulesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_id'],
      )!,
      cityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_name'],
      )!,
      province: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}province'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      imsak: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imsak'],
      )!,
      subuh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subuh'],
      )!,
      terbit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terbit'],
      )!,
      dhuha: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dhuha'],
      )!,
      dzuhur: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dzuhur'],
      )!,
      ashar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ashar'],
      )!,
      maghrib: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maghrib'],
      )!,
      isya: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isya'],
      )!,
    );
  }

  @override
  $PrayerSchedulesTableTable createAlias(String alias) {
    return $PrayerSchedulesTableTable(attachedDatabase, alias);
  }
}

class PrayerSchedulesTableData extends DataClass
    implements Insertable<PrayerSchedulesTableData> {
  final String id;
  final String cityId;
  final String cityName;
  final String province;
  final String date;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  const PrayerSchedulesTableData({
    required this.id,
    required this.cityId,
    required this.cityName,
    required this.province,
    required this.date,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['city_id'] = Variable<String>(cityId);
    map['city_name'] = Variable<String>(cityName);
    map['province'] = Variable<String>(province);
    map['date'] = Variable<String>(date);
    map['imsak'] = Variable<String>(imsak);
    map['subuh'] = Variable<String>(subuh);
    map['terbit'] = Variable<String>(terbit);
    map['dhuha'] = Variable<String>(dhuha);
    map['dzuhur'] = Variable<String>(dzuhur);
    map['ashar'] = Variable<String>(ashar);
    map['maghrib'] = Variable<String>(maghrib);
    map['isya'] = Variable<String>(isya);
    return map;
  }

  PrayerSchedulesTableCompanion toCompanion(bool nullToAbsent) {
    return PrayerSchedulesTableCompanion(
      id: Value(id),
      cityId: Value(cityId),
      cityName: Value(cityName),
      province: Value(province),
      date: Value(date),
      imsak: Value(imsak),
      subuh: Value(subuh),
      terbit: Value(terbit),
      dhuha: Value(dhuha),
      dzuhur: Value(dzuhur),
      ashar: Value(ashar),
      maghrib: Value(maghrib),
      isya: Value(isya),
    );
  }

  factory PrayerSchedulesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerSchedulesTableData(
      id: serializer.fromJson<String>(json['id']),
      cityId: serializer.fromJson<String>(json['cityId']),
      cityName: serializer.fromJson<String>(json['cityName']),
      province: serializer.fromJson<String>(json['province']),
      date: serializer.fromJson<String>(json['date']),
      imsak: serializer.fromJson<String>(json['imsak']),
      subuh: serializer.fromJson<String>(json['subuh']),
      terbit: serializer.fromJson<String>(json['terbit']),
      dhuha: serializer.fromJson<String>(json['dhuha']),
      dzuhur: serializer.fromJson<String>(json['dzuhur']),
      ashar: serializer.fromJson<String>(json['ashar']),
      maghrib: serializer.fromJson<String>(json['maghrib']),
      isya: serializer.fromJson<String>(json['isya']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cityId': serializer.toJson<String>(cityId),
      'cityName': serializer.toJson<String>(cityName),
      'province': serializer.toJson<String>(province),
      'date': serializer.toJson<String>(date),
      'imsak': serializer.toJson<String>(imsak),
      'subuh': serializer.toJson<String>(subuh),
      'terbit': serializer.toJson<String>(terbit),
      'dhuha': serializer.toJson<String>(dhuha),
      'dzuhur': serializer.toJson<String>(dzuhur),
      'ashar': serializer.toJson<String>(ashar),
      'maghrib': serializer.toJson<String>(maghrib),
      'isya': serializer.toJson<String>(isya),
    };
  }

  PrayerSchedulesTableData copyWith({
    String? id,
    String? cityId,
    String? cityName,
    String? province,
    String? date,
    String? imsak,
    String? subuh,
    String? terbit,
    String? dhuha,
    String? dzuhur,
    String? ashar,
    String? maghrib,
    String? isya,
  }) => PrayerSchedulesTableData(
    id: id ?? this.id,
    cityId: cityId ?? this.cityId,
    cityName: cityName ?? this.cityName,
    province: province ?? this.province,
    date: date ?? this.date,
    imsak: imsak ?? this.imsak,
    subuh: subuh ?? this.subuh,
    terbit: terbit ?? this.terbit,
    dhuha: dhuha ?? this.dhuha,
    dzuhur: dzuhur ?? this.dzuhur,
    ashar: ashar ?? this.ashar,
    maghrib: maghrib ?? this.maghrib,
    isya: isya ?? this.isya,
  );
  PrayerSchedulesTableData copyWithCompanion(
    PrayerSchedulesTableCompanion data,
  ) {
    return PrayerSchedulesTableData(
      id: data.id.present ? data.id.value : this.id,
      cityId: data.cityId.present ? data.cityId.value : this.cityId,
      cityName: data.cityName.present ? data.cityName.value : this.cityName,
      province: data.province.present ? data.province.value : this.province,
      date: data.date.present ? data.date.value : this.date,
      imsak: data.imsak.present ? data.imsak.value : this.imsak,
      subuh: data.subuh.present ? data.subuh.value : this.subuh,
      terbit: data.terbit.present ? data.terbit.value : this.terbit,
      dhuha: data.dhuha.present ? data.dhuha.value : this.dhuha,
      dzuhur: data.dzuhur.present ? data.dzuhur.value : this.dzuhur,
      ashar: data.ashar.present ? data.ashar.value : this.ashar,
      maghrib: data.maghrib.present ? data.maghrib.value : this.maghrib,
      isya: data.isya.present ? data.isya.value : this.isya,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerSchedulesTableData(')
          ..write('id: $id, ')
          ..write('cityId: $cityId, ')
          ..write('cityName: $cityName, ')
          ..write('province: $province, ')
          ..write('date: $date, ')
          ..write('imsak: $imsak, ')
          ..write('subuh: $subuh, ')
          ..write('terbit: $terbit, ')
          ..write('dhuha: $dhuha, ')
          ..write('dzuhur: $dzuhur, ')
          ..write('ashar: $ashar, ')
          ..write('maghrib: $maghrib, ')
          ..write('isya: $isya')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cityId,
    cityName,
    province,
    date,
    imsak,
    subuh,
    terbit,
    dhuha,
    dzuhur,
    ashar,
    maghrib,
    isya,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerSchedulesTableData &&
          other.id == this.id &&
          other.cityId == this.cityId &&
          other.cityName == this.cityName &&
          other.province == this.province &&
          other.date == this.date &&
          other.imsak == this.imsak &&
          other.subuh == this.subuh &&
          other.terbit == this.terbit &&
          other.dhuha == this.dhuha &&
          other.dzuhur == this.dzuhur &&
          other.ashar == this.ashar &&
          other.maghrib == this.maghrib &&
          other.isya == this.isya);
}

class PrayerSchedulesTableCompanion
    extends UpdateCompanion<PrayerSchedulesTableData> {
  final Value<String> id;
  final Value<String> cityId;
  final Value<String> cityName;
  final Value<String> province;
  final Value<String> date;
  final Value<String> imsak;
  final Value<String> subuh;
  final Value<String> terbit;
  final Value<String> dhuha;
  final Value<String> dzuhur;
  final Value<String> ashar;
  final Value<String> maghrib;
  final Value<String> isya;
  final Value<int> rowid;
  const PrayerSchedulesTableCompanion({
    this.id = const Value.absent(),
    this.cityId = const Value.absent(),
    this.cityName = const Value.absent(),
    this.province = const Value.absent(),
    this.date = const Value.absent(),
    this.imsak = const Value.absent(),
    this.subuh = const Value.absent(),
    this.terbit = const Value.absent(),
    this.dhuha = const Value.absent(),
    this.dzuhur = const Value.absent(),
    this.ashar = const Value.absent(),
    this.maghrib = const Value.absent(),
    this.isya = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrayerSchedulesTableCompanion.insert({
    required String id,
    required String cityId,
    required String cityName,
    required String province,
    required String date,
    required String imsak,
    required String subuh,
    required String terbit,
    required String dhuha,
    required String dzuhur,
    required String ashar,
    required String maghrib,
    required String isya,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cityId = Value(cityId),
       cityName = Value(cityName),
       province = Value(province),
       date = Value(date),
       imsak = Value(imsak),
       subuh = Value(subuh),
       terbit = Value(terbit),
       dhuha = Value(dhuha),
       dzuhur = Value(dzuhur),
       ashar = Value(ashar),
       maghrib = Value(maghrib),
       isya = Value(isya);
  static Insertable<PrayerSchedulesTableData> custom({
    Expression<String>? id,
    Expression<String>? cityId,
    Expression<String>? cityName,
    Expression<String>? province,
    Expression<String>? date,
    Expression<String>? imsak,
    Expression<String>? subuh,
    Expression<String>? terbit,
    Expression<String>? dhuha,
    Expression<String>? dzuhur,
    Expression<String>? ashar,
    Expression<String>? maghrib,
    Expression<String>? isya,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cityId != null) 'city_id': cityId,
      if (cityName != null) 'city_name': cityName,
      if (province != null) 'province': province,
      if (date != null) 'date': date,
      if (imsak != null) 'imsak': imsak,
      if (subuh != null) 'subuh': subuh,
      if (terbit != null) 'terbit': terbit,
      if (dhuha != null) 'dhuha': dhuha,
      if (dzuhur != null) 'dzuhur': dzuhur,
      if (ashar != null) 'ashar': ashar,
      if (maghrib != null) 'maghrib': maghrib,
      if (isya != null) 'isya': isya,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrayerSchedulesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? cityId,
    Value<String>? cityName,
    Value<String>? province,
    Value<String>? date,
    Value<String>? imsak,
    Value<String>? subuh,
    Value<String>? terbit,
    Value<String>? dhuha,
    Value<String>? dzuhur,
    Value<String>? ashar,
    Value<String>? maghrib,
    Value<String>? isya,
    Value<int>? rowid,
  }) {
    return PrayerSchedulesTableCompanion(
      id: id ?? this.id,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      province: province ?? this.province,
      date: date ?? this.date,
      imsak: imsak ?? this.imsak,
      subuh: subuh ?? this.subuh,
      terbit: terbit ?? this.terbit,
      dhuha: dhuha ?? this.dhuha,
      dzuhur: dzuhur ?? this.dzuhur,
      ashar: ashar ?? this.ashar,
      maghrib: maghrib ?? this.maghrib,
      isya: isya ?? this.isya,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cityId.present) {
      map['city_id'] = Variable<String>(cityId.value);
    }
    if (cityName.present) {
      map['city_name'] = Variable<String>(cityName.value);
    }
    if (province.present) {
      map['province'] = Variable<String>(province.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (imsak.present) {
      map['imsak'] = Variable<String>(imsak.value);
    }
    if (subuh.present) {
      map['subuh'] = Variable<String>(subuh.value);
    }
    if (terbit.present) {
      map['terbit'] = Variable<String>(terbit.value);
    }
    if (dhuha.present) {
      map['dhuha'] = Variable<String>(dhuha.value);
    }
    if (dzuhur.present) {
      map['dzuhur'] = Variable<String>(dzuhur.value);
    }
    if (ashar.present) {
      map['ashar'] = Variable<String>(ashar.value);
    }
    if (maghrib.present) {
      map['maghrib'] = Variable<String>(maghrib.value);
    }
    if (isya.present) {
      map['isya'] = Variable<String>(isya.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerSchedulesTableCompanion(')
          ..write('id: $id, ')
          ..write('cityId: $cityId, ')
          ..write('cityName: $cityName, ')
          ..write('province: $province, ')
          ..write('date: $date, ')
          ..write('imsak: $imsak, ')
          ..write('subuh: $subuh, ')
          ..write('terbit: $terbit, ')
          ..write('dhuha: $dhuha, ')
          ..write('dzuhur: $dzuhur, ')
          ..write('ashar: $ashar, ')
          ..write('maghrib: $maghrib, ')
          ..write('isya: $isya, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationSettingsTableTable extends NotificationSettingsTable
    with
        TableInfo<
          $NotificationSettingsTableTable,
          NotificationSettingsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prayerNameMeta = const VerificationMeta(
    'prayerName',
  );
  @override
  late final GeneratedColumn<String> prayerName = GeneratedColumn<String>(
    'prayer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertTypeMeta = const VerificationMeta(
    'alertType',
  );
  @override
  late final GeneratedColumn<int> alertType = GeneratedColumn<int>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _preReminderMinutesMeta =
      const VerificationMeta('preReminderMinutes');
  @override
  late final GeneratedColumn<int> preReminderMinutes = GeneratedColumn<int>(
    'pre_reminder_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    prayerName,
    alertType,
    preReminderMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prayer_name')) {
      context.handle(
        _prayerNameMeta,
        prayerName.isAcceptableOrUnknown(data['prayer_name']!, _prayerNameMeta),
      );
    } else if (isInserting) {
      context.missing(_prayerNameMeta);
    }
    if (data.containsKey('alert_type')) {
      context.handle(
        _alertTypeMeta,
        alertType.isAcceptableOrUnknown(data['alert_type']!, _alertTypeMeta),
      );
    }
    if (data.containsKey('pre_reminder_minutes')) {
      context.handle(
        _preReminderMinutesMeta,
        preReminderMinutes.isAcceptableOrUnknown(
          data['pre_reminder_minutes']!,
          _preReminderMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prayerName};
  @override
  NotificationSettingsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationSettingsTableData(
      prayerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prayer_name'],
      )!,
      alertType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alert_type'],
      )!,
      preReminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pre_reminder_minutes'],
      )!,
    );
  }

  @override
  $NotificationSettingsTableTable createAlias(String alias) {
    return $NotificationSettingsTableTable(attachedDatabase, alias);
  }
}

class NotificationSettingsTableData extends DataClass
    implements Insertable<NotificationSettingsTableData> {
  final String prayerName;
  final int alertType;
  final int preReminderMinutes;
  const NotificationSettingsTableData({
    required this.prayerName,
    required this.alertType,
    required this.preReminderMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prayer_name'] = Variable<String>(prayerName);
    map['alert_type'] = Variable<int>(alertType);
    map['pre_reminder_minutes'] = Variable<int>(preReminderMinutes);
    return map;
  }

  NotificationSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationSettingsTableCompanion(
      prayerName: Value(prayerName),
      alertType: Value(alertType),
      preReminderMinutes: Value(preReminderMinutes),
    );
  }

  factory NotificationSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationSettingsTableData(
      prayerName: serializer.fromJson<String>(json['prayerName']),
      alertType: serializer.fromJson<int>(json['alertType']),
      preReminderMinutes: serializer.fromJson<int>(json['preReminderMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prayerName': serializer.toJson<String>(prayerName),
      'alertType': serializer.toJson<int>(alertType),
      'preReminderMinutes': serializer.toJson<int>(preReminderMinutes),
    };
  }

  NotificationSettingsTableData copyWith({
    String? prayerName,
    int? alertType,
    int? preReminderMinutes,
  }) => NotificationSettingsTableData(
    prayerName: prayerName ?? this.prayerName,
    alertType: alertType ?? this.alertType,
    preReminderMinutes: preReminderMinutes ?? this.preReminderMinutes,
  );
  NotificationSettingsTableData copyWithCompanion(
    NotificationSettingsTableCompanion data,
  ) {
    return NotificationSettingsTableData(
      prayerName: data.prayerName.present
          ? data.prayerName.value
          : this.prayerName,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      preReminderMinutes: data.preReminderMinutes.present
          ? data.preReminderMinutes.value
          : this.preReminderMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettingsTableData(')
          ..write('prayerName: $prayerName, ')
          ..write('alertType: $alertType, ')
          ..write('preReminderMinutes: $preReminderMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(prayerName, alertType, preReminderMinutes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationSettingsTableData &&
          other.prayerName == this.prayerName &&
          other.alertType == this.alertType &&
          other.preReminderMinutes == this.preReminderMinutes);
}

class NotificationSettingsTableCompanion
    extends UpdateCompanion<NotificationSettingsTableData> {
  final Value<String> prayerName;
  final Value<int> alertType;
  final Value<int> preReminderMinutes;
  final Value<int> rowid;
  const NotificationSettingsTableCompanion({
    this.prayerName = const Value.absent(),
    this.alertType = const Value.absent(),
    this.preReminderMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationSettingsTableCompanion.insert({
    required String prayerName,
    this.alertType = const Value.absent(),
    this.preReminderMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : prayerName = Value(prayerName);
  static Insertable<NotificationSettingsTableData> custom({
    Expression<String>? prayerName,
    Expression<int>? alertType,
    Expression<int>? preReminderMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (prayerName != null) 'prayer_name': prayerName,
      if (alertType != null) 'alert_type': alertType,
      if (preReminderMinutes != null)
        'pre_reminder_minutes': preReminderMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationSettingsTableCompanion copyWith({
    Value<String>? prayerName,
    Value<int>? alertType,
    Value<int>? preReminderMinutes,
    Value<int>? rowid,
  }) {
    return NotificationSettingsTableCompanion(
      prayerName: prayerName ?? this.prayerName,
      alertType: alertType ?? this.alertType,
      preReminderMinutes: preReminderMinutes ?? this.preReminderMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prayerName.present) {
      map['prayer_name'] = Variable<String>(prayerName.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<int>(alertType.value);
    }
    if (preReminderMinutes.present) {
      map['pre_reminder_minutes'] = Variable<int>(preReminderMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationSettingsTableCompanion(')
          ..write('prayerName: $prayerName, ')
          ..write('alertType: $alertType, ')
          ..write('preReminderMinutes: $preReminderMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationCacheTableTable extends LocationCacheTable
    with TableInfo<$LocationCacheTableTable, LocationCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationCacheTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityNameMeta = const VerificationMeta(
    'cityName',
  );
  @override
  late final GeneratedColumn<String> cityName = GeneratedColumn<String>(
    'city_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    latitude,
    longitude,
    cityName,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_cache_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationCacheTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('city_name')) {
      context.handle(
        _cityNameMeta,
        cityName.isAcceptableOrUnknown(data['city_name']!, _cityNameMeta),
      );
    } else if (isInserting) {
      context.missing(_cityNameMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocationCacheTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationCacheTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      cityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city_name'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocationCacheTableTable createAlias(String alias) {
    return $LocationCacheTableTable(attachedDatabase, alias);
  }
}

class LocationCacheTableData extends DataClass
    implements Insertable<LocationCacheTableData> {
  final int id;
  final double latitude;
  final double longitude;
  final String cityName;
  final DateTime updatedAt;
  const LocationCacheTableData({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.cityName,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['city_name'] = Variable<String>(cityName);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocationCacheTableCompanion toCompanion(bool nullToAbsent) {
    return LocationCacheTableCompanion(
      id: Value(id),
      latitude: Value(latitude),
      longitude: Value(longitude),
      cityName: Value(cityName),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocationCacheTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationCacheTableData(
      id: serializer.fromJson<int>(json['id']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      cityName: serializer.fromJson<String>(json['cityName']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'cityName': serializer.toJson<String>(cityName),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocationCacheTableData copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? cityName,
    DateTime? updatedAt,
  }) => LocationCacheTableData(
    id: id ?? this.id,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    cityName: cityName ?? this.cityName,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocationCacheTableData copyWithCompanion(LocationCacheTableCompanion data) {
    return LocationCacheTableData(
      id: data.id.present ? data.id.value : this.id,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      cityName: data.cityName.present ? data.cityName.value : this.cityName,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationCacheTableData(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('cityName: $cityName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, latitude, longitude, cityName, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationCacheTableData &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.cityName == this.cityName &&
          other.updatedAt == this.updatedAt);
}

class LocationCacheTableCompanion
    extends UpdateCompanion<LocationCacheTableData> {
  final Value<int> id;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> cityName;
  final Value<DateTime> updatedAt;
  const LocationCacheTableCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.cityName = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LocationCacheTableCompanion.insert({
    this.id = const Value.absent(),
    required double latitude,
    required double longitude,
    required String cityName,
    required DateTime updatedAt,
  }) : latitude = Value(latitude),
       longitude = Value(longitude),
       cityName = Value(cityName),
       updatedAt = Value(updatedAt);
  static Insertable<LocationCacheTableData> custom({
    Expression<int>? id,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? cityName,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (cityName != null) 'city_name': cityName,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LocationCacheTableCompanion copyWith({
    Value<int>? id,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? cityName,
    Value<DateTime>? updatedAt,
  }) {
    return LocationCacheTableCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (cityName.present) {
      map['city_name'] = Variable<String>(cityName.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationCacheTableCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('cityName: $cityName, ')
          ..write('updatedAt: $updatedAt')
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
  late final $PrayerSchedulesTableTable prayerSchedulesTable =
      $PrayerSchedulesTableTable(this);
  late final $NotificationSettingsTableTable notificationSettingsTable =
      $NotificationSettingsTableTable(this);
  late final $LocationCacheTableTable locationCacheTable =
      $LocationCacheTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahsTable,
    ayahsTable,
    bookmarksTable,
    prayerSchedulesTable,
    notificationSettingsTable,
    locationCacheTable,
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
typedef $$PrayerSchedulesTableTableCreateCompanionBuilder =
    PrayerSchedulesTableCompanion Function({
      required String id,
      required String cityId,
      required String cityName,
      required String province,
      required String date,
      required String imsak,
      required String subuh,
      required String terbit,
      required String dhuha,
      required String dzuhur,
      required String ashar,
      required String maghrib,
      required String isya,
      Value<int> rowid,
    });
typedef $$PrayerSchedulesTableTableUpdateCompanionBuilder =
    PrayerSchedulesTableCompanion Function({
      Value<String> id,
      Value<String> cityId,
      Value<String> cityName,
      Value<String> province,
      Value<String> date,
      Value<String> imsak,
      Value<String> subuh,
      Value<String> terbit,
      Value<String> dhuha,
      Value<String> dzuhur,
      Value<String> ashar,
      Value<String> maghrib,
      Value<String> isya,
      Value<int> rowid,
    });

class $$PrayerSchedulesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerSchedulesTableTable> {
  $$PrayerSchedulesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityId => $composableBuilder(
    column: $table.cityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get province => $composableBuilder(
    column: $table.province,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imsak => $composableBuilder(
    column: $table.imsak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subuh => $composableBuilder(
    column: $table.subuh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get terbit => $composableBuilder(
    column: $table.terbit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dhuha => $composableBuilder(
    column: $table.dhuha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dzuhur => $composableBuilder(
    column: $table.dzuhur,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ashar => $composableBuilder(
    column: $table.ashar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maghrib => $composableBuilder(
    column: $table.maghrib,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get isya => $composableBuilder(
    column: $table.isya,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerSchedulesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerSchedulesTableTable> {
  $$PrayerSchedulesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityId => $composableBuilder(
    column: $table.cityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get province => $composableBuilder(
    column: $table.province,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imsak => $composableBuilder(
    column: $table.imsak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subuh => $composableBuilder(
    column: $table.subuh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get terbit => $composableBuilder(
    column: $table.terbit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dhuha => $composableBuilder(
    column: $table.dhuha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dzuhur => $composableBuilder(
    column: $table.dzuhur,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ashar => $composableBuilder(
    column: $table.ashar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maghrib => $composableBuilder(
    column: $table.maghrib,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get isya => $composableBuilder(
    column: $table.isya,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerSchedulesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerSchedulesTableTable> {
  $$PrayerSchedulesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cityId =>
      $composableBuilder(column: $table.cityId, builder: (column) => column);

  GeneratedColumn<String> get cityName =>
      $composableBuilder(column: $table.cityName, builder: (column) => column);

  GeneratedColumn<String> get province =>
      $composableBuilder(column: $table.province, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get imsak =>
      $composableBuilder(column: $table.imsak, builder: (column) => column);

  GeneratedColumn<String> get subuh =>
      $composableBuilder(column: $table.subuh, builder: (column) => column);

  GeneratedColumn<String> get terbit =>
      $composableBuilder(column: $table.terbit, builder: (column) => column);

  GeneratedColumn<String> get dhuha =>
      $composableBuilder(column: $table.dhuha, builder: (column) => column);

  GeneratedColumn<String> get dzuhur =>
      $composableBuilder(column: $table.dzuhur, builder: (column) => column);

  GeneratedColumn<String> get ashar =>
      $composableBuilder(column: $table.ashar, builder: (column) => column);

  GeneratedColumn<String> get maghrib =>
      $composableBuilder(column: $table.maghrib, builder: (column) => column);

  GeneratedColumn<String> get isya =>
      $composableBuilder(column: $table.isya, builder: (column) => column);
}

class $$PrayerSchedulesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerSchedulesTableTable,
          PrayerSchedulesTableData,
          $$PrayerSchedulesTableTableFilterComposer,
          $$PrayerSchedulesTableTableOrderingComposer,
          $$PrayerSchedulesTableTableAnnotationComposer,
          $$PrayerSchedulesTableTableCreateCompanionBuilder,
          $$PrayerSchedulesTableTableUpdateCompanionBuilder,
          (
            PrayerSchedulesTableData,
            BaseReferences<
              _$AppDatabase,
              $PrayerSchedulesTableTable,
              PrayerSchedulesTableData
            >,
          ),
          PrayerSchedulesTableData,
          PrefetchHooks Function()
        > {
  $$PrayerSchedulesTableTableTableManager(
    _$AppDatabase db,
    $PrayerSchedulesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrayerSchedulesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrayerSchedulesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PrayerSchedulesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cityId = const Value.absent(),
                Value<String> cityName = const Value.absent(),
                Value<String> province = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String> imsak = const Value.absent(),
                Value<String> subuh = const Value.absent(),
                Value<String> terbit = const Value.absent(),
                Value<String> dhuha = const Value.absent(),
                Value<String> dzuhur = const Value.absent(),
                Value<String> ashar = const Value.absent(),
                Value<String> maghrib = const Value.absent(),
                Value<String> isya = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PrayerSchedulesTableCompanion(
                id: id,
                cityId: cityId,
                cityName: cityName,
                province: province,
                date: date,
                imsak: imsak,
                subuh: subuh,
                terbit: terbit,
                dhuha: dhuha,
                dzuhur: dzuhur,
                ashar: ashar,
                maghrib: maghrib,
                isya: isya,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cityId,
                required String cityName,
                required String province,
                required String date,
                required String imsak,
                required String subuh,
                required String terbit,
                required String dhuha,
                required String dzuhur,
                required String ashar,
                required String maghrib,
                required String isya,
                Value<int> rowid = const Value.absent(),
              }) => PrayerSchedulesTableCompanion.insert(
                id: id,
                cityId: cityId,
                cityName: cityName,
                province: province,
                date: date,
                imsak: imsak,
                subuh: subuh,
                terbit: terbit,
                dhuha: dhuha,
                dzuhur: dzuhur,
                ashar: ashar,
                maghrib: maghrib,
                isya: isya,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerSchedulesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerSchedulesTableTable,
      PrayerSchedulesTableData,
      $$PrayerSchedulesTableTableFilterComposer,
      $$PrayerSchedulesTableTableOrderingComposer,
      $$PrayerSchedulesTableTableAnnotationComposer,
      $$PrayerSchedulesTableTableCreateCompanionBuilder,
      $$PrayerSchedulesTableTableUpdateCompanionBuilder,
      (
        PrayerSchedulesTableData,
        BaseReferences<
          _$AppDatabase,
          $PrayerSchedulesTableTable,
          PrayerSchedulesTableData
        >,
      ),
      PrayerSchedulesTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationSettingsTableTableCreateCompanionBuilder =
    NotificationSettingsTableCompanion Function({
      required String prayerName,
      Value<int> alertType,
      Value<int> preReminderMinutes,
      Value<int> rowid,
    });
typedef $$NotificationSettingsTableTableUpdateCompanionBuilder =
    NotificationSettingsTableCompanion Function({
      Value<String> prayerName,
      Value<int> alertType,
      Value<int> preReminderMinutes,
      Value<int> rowid,
    });

class $$NotificationSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preReminderMinutes => $composableBuilder(
    column: $table.preReminderMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preReminderMinutes => $composableBuilder(
    column: $table.preReminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationSettingsTableTable> {
  $$NotificationSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get prayerName => $composableBuilder(
    column: $table.prayerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<int> get preReminderMinutes => $composableBuilder(
    column: $table.preReminderMinutes,
    builder: (column) => column,
  );
}

class $$NotificationSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationSettingsTableTable,
          NotificationSettingsTableData,
          $$NotificationSettingsTableTableFilterComposer,
          $$NotificationSettingsTableTableOrderingComposer,
          $$NotificationSettingsTableTableAnnotationComposer,
          $$NotificationSettingsTableTableCreateCompanionBuilder,
          $$NotificationSettingsTableTableUpdateCompanionBuilder,
          (
            NotificationSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationSettingsTableTable,
              NotificationSettingsTableData
            >,
          ),
          NotificationSettingsTableData,
          PrefetchHooks Function()
        > {
  $$NotificationSettingsTableTableTableManager(
    _$AppDatabase db,
    $NotificationSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationSettingsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> prayerName = const Value.absent(),
                Value<int> alertType = const Value.absent(),
                Value<int> preReminderMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSettingsTableCompanion(
                prayerName: prayerName,
                alertType: alertType,
                preReminderMinutes: preReminderMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String prayerName,
                Value<int> alertType = const Value.absent(),
                Value<int> preReminderMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationSettingsTableCompanion.insert(
                prayerName: prayerName,
                alertType: alertType,
                preReminderMinutes: preReminderMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationSettingsTableTable,
      NotificationSettingsTableData,
      $$NotificationSettingsTableTableFilterComposer,
      $$NotificationSettingsTableTableOrderingComposer,
      $$NotificationSettingsTableTableAnnotationComposer,
      $$NotificationSettingsTableTableCreateCompanionBuilder,
      $$NotificationSettingsTableTableUpdateCompanionBuilder,
      (
        NotificationSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationSettingsTableTable,
          NotificationSettingsTableData
        >,
      ),
      NotificationSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$LocationCacheTableTableCreateCompanionBuilder =
    LocationCacheTableCompanion Function({
      Value<int> id,
      required double latitude,
      required double longitude,
      required String cityName,
      required DateTime updatedAt,
    });
typedef $$LocationCacheTableTableUpdateCompanionBuilder =
    LocationCacheTableCompanion Function({
      Value<int> id,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> cityName,
      Value<DateTime> updatedAt,
    });

class $$LocationCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $LocationCacheTableTable> {
  $$LocationCacheTableTableFilterComposer({
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

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationCacheTableTable> {
  $$LocationCacheTableTableOrderingComposer({
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

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cityName => $composableBuilder(
    column: $table.cityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationCacheTableTable> {
  $$LocationCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get cityName =>
      $composableBuilder(column: $table.cityName, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocationCacheTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationCacheTableTable,
          LocationCacheTableData,
          $$LocationCacheTableTableFilterComposer,
          $$LocationCacheTableTableOrderingComposer,
          $$LocationCacheTableTableAnnotationComposer,
          $$LocationCacheTableTableCreateCompanionBuilder,
          $$LocationCacheTableTableUpdateCompanionBuilder,
          (
            LocationCacheTableData,
            BaseReferences<
              _$AppDatabase,
              $LocationCacheTableTable,
              LocationCacheTableData
            >,
          ),
          LocationCacheTableData,
          PrefetchHooks Function()
        > {
  $$LocationCacheTableTableTableManager(
    _$AppDatabase db,
    $LocationCacheTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationCacheTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationCacheTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationCacheTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> cityName = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LocationCacheTableCompanion(
                id: id,
                latitude: latitude,
                longitude: longitude,
                cityName: cityName,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double latitude,
                required double longitude,
                required String cityName,
                required DateTime updatedAt,
              }) => LocationCacheTableCompanion.insert(
                id: id,
                latitude: latitude,
                longitude: longitude,
                cityName: cityName,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationCacheTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationCacheTableTable,
      LocationCacheTableData,
      $$LocationCacheTableTableFilterComposer,
      $$LocationCacheTableTableOrderingComposer,
      $$LocationCacheTableTableAnnotationComposer,
      $$LocationCacheTableTableCreateCompanionBuilder,
      $$LocationCacheTableTableUpdateCompanionBuilder,
      (
        LocationCacheTableData,
        BaseReferences<
          _$AppDatabase,
          $LocationCacheTableTable,
          LocationCacheTableData
        >,
      ),
      LocationCacheTableData,
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
  $$PrayerSchedulesTableTableTableManager get prayerSchedulesTable =>
      $$PrayerSchedulesTableTableTableManager(_db, _db.prayerSchedulesTable);
  $$NotificationSettingsTableTableTableManager get notificationSettingsTable =>
      $$NotificationSettingsTableTableTableManager(
        _db,
        _db.notificationSettingsTable,
      );
  $$LocationCacheTableTableTableManager get locationCacheTable =>
      $$LocationCacheTableTableTableManager(_db, _db.locationCacheTable);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// generated_from: env/.env.development
final class _Env {
  static const String apiBaseUrl = 'https://api.myquran.com/v3';

  static const List<int> _enviedkeyapiKey = <int>[
    791484701,
    4084825167,
    4035151791,
    1674001182,
    55606136,
    2602885468,
    3800432537,
    800366010,
    773524037,
    1468717229,
    2000370307,
  ];

  static const List<int> _envieddataapiKey = <int>[
    791484793,
    4084825130,
    4035151833,
    1674001217,
    55606035,
    2602885433,
    3800432608,
    800366053,
    773524084,
    1468717215,
    2000370352,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}

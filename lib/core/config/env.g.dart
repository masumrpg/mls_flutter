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
    406572960,
    3217787105,
    280329777,
    573011690,
    3890624847,
    1306617815,
    1666761368,
    2515890890,
    3933850831,
    820041551,
    970512092,
  ];

  static const List<int> _envieddataapiKey = <int>[
    406572996,
    3217787012,
    280329799,
    573011637,
    3890624804,
    1306617778,
    1666761441,
    2515890837,
    3933850878,
    820041597,
    970512111,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}

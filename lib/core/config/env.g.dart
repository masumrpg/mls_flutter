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
    1081852460,
    3018313922,
    782050239,
    2851262335,
    3699960721,
    2998257917,
    2311031343,
    1770661836,
    2103934177,
    2009224083,
    1549696785,
  ];

  static const List<int> _envieddataapiKey = <int>[
    1081852488,
    3018313895,
    782050249,
    2851262240,
    3699960826,
    2998257816,
    2311031382,
    1770661779,
    2103934160,
    2009224097,
    1549696802,
  ];

  static final String apiKey = String.fromCharCodes(
    List<int>.generate(
      _envieddataapiKey.length,
      (int i) => i,
      growable: false,
    ).map((int i) => _envieddataapiKey[i] ^ _enviedkeyapiKey[i]),
  );
}

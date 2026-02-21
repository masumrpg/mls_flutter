import 'package:equatable/equatable.dart';

class ProfilEntity extends Equatable {
  final double avg;
  final List<ProfilDetailEntity> detail;

  const ProfilEntity({
    required this.avg,
    required this.detail,
  });

  @override
  List<Object?> get props => [avg, detail];
}

class ProfilDetailEntity extends Equatable {
  final int tahun;
  final int bulan;
  final int hits;

  const ProfilDetailEntity({
    required this.tahun,
    required this.bulan,
    required this.hits,
  });

  @override
  List<Object?> get props => [tahun, bulan, hits];
}

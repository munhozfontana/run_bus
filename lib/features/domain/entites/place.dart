import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final num? sequencial;
  final String? descricao;

  Place({
    required this.sequencial,
    required this.descricao,
  });

  @override
  List<Object> get props => [sequencial!, descricao!];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/features/domain/entites/position.dart';

class IntegrationArea extends Equatable {
  final int sequencial;
  final String modal;
  final String descricao;
  final List<Location> location;

  IntegrationArea({
    @required this.sequencial,
    @required this.modal,
    @required this.descricao,
    @required this.location,
  });

  @override
  List<Object> get props => [
        sequencial,
        modal,
        descricao,
        location,
      ];
}

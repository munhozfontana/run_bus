import 'package:equatable/equatable.dart';

class Version extends Equatable {
  final int? sequencial;
  final int? data;

  Version({
    this.sequencial,
    this.data,
  });

  @override
  List<Object?> get props => [sequencial, data];
}

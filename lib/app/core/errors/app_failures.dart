// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  String? message;

  ServerFailure([this.message]);

  @override
  List<Object?> get props => [message];
}

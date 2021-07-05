import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/setting_model.dart';

class SettingState extends Equatable {
  final Setting setting = Setting.initial();
  @override
  List<Object> get props => [setting];
}

class SettingStateInitial extends SettingState {
  final Setting setting = Setting.initial();
  @override
  List<Object> get props => [setting];
}

class SettingStateUpdateSuccess extends SettingState {
  final Setting setting;
  SettingStateUpdateSuccess({@required this.setting}) : assert(setting != null);
  @override
  List<Object> get props => [this.setting];
}

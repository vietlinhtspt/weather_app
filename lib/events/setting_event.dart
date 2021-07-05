import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/setting_model.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
  @override
  List<Object> get props => [];
}

class SettingEventUpdate extends SettingEvent {
  final Setting setting;
  const SettingEventUpdate({@required this.setting}) : assert(setting != null);
  @override
  List<Object> get props => [setting];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/events/setting_event.dart';
import 'package:weather_app/states/setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingStateInitial());

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is SettingEventUpdate) {
      yield SettingStateUpdateSuccess(setting: event.setting);
    } else {
      yield SettingStateInitial();
    }
  }
}

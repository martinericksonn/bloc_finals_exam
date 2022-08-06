import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(switchValue: false));

  void switchDark() {
    emit(ThemeState(switchValue: false));
  }

  void switchLight() {
    emit(ThemeState(switchValue: true));
  }
}

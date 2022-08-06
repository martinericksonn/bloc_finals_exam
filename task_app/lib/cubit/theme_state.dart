// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'theme_cubit.dart';

@immutable
// ignore: must_be_immutable
class ThemeState {
  bool switchValue;

  ThemeState({
    required this.switchValue,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'switchValue': switchValue,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      switchValue: map['switchValue'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeState.fromJson(String source) =>
      ThemeState.fromMap(json.decode(source) as Map<String, dynamic>);
}

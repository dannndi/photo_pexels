part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode theme;
  const ThemeState({this.theme = ThemeMode.light});

  ThemeState copyWith(ThemeMode? theme) {
    return ThemeState(theme: theme ?? this.theme);
  }

  @override
  List<Object?> get props => [theme];
}

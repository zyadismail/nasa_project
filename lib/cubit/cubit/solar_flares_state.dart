part of 'solar_flares_cubit.dart';

@immutable
sealed class SolarFlaresState {}

final class SolarFlaresInitial extends SolarFlaresState {}
final class SolarFlaresLoading extends SolarFlaresState {}
final class SolarFlaresSuccess extends SolarFlaresState {}
final class SolarFlaresFailed extends SolarFlaresState {
  
}

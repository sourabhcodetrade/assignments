part of 'all_hero_bloc.dart';

@immutable
sealed class AllHeroState extends Equatable {

  const AllHeroState();

  @override
  List<Object> get props => [];
}

final class HomeScreenInitial extends AllHeroState {}

final class AllHeroLoading extends AllHeroState {}

final class AllHeroSuccess extends AllHeroState {
  final List hero;
  final String msg;

  const AllHeroSuccess(this.msg, this.hero);

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class AllHeroFailure extends AllHeroState {
  final String msg;

  const AllHeroFailure(this.msg);
}

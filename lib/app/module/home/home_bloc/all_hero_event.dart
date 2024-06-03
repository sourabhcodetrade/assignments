part of 'all_hero_bloc.dart';

@immutable
sealed class AllHeroEvent extends Equatable {

  const AllHeroEvent();

  @override
  List<Object> get props => [];
}


final class GetHero extends AllHeroEvent{
  final bool isRefresh;
  const GetHero(this.isRefresh);
}

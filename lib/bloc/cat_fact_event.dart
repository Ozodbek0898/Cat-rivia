part of 'cat_fact_bloc.dart';

@immutable
abstract class CatFactEvent extends Equatable{}


class CatFactLoaded extends CatFactEvent {
  CatFactLoaded();
  @override
  List<Object> get props => [];
}
class GetHistoryFacts extends CatFactEvent {
  GetHistoryFacts();
  @override
  List<Object> get props => [];
}

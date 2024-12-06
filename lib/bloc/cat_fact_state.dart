part of 'cat_fact_bloc.dart';


class CatFactState extends Equatable {
  const CatFactState({
    this.isLoading = false,
    this.model,
    this.list = const [],
  });

  final bool isLoading;
  final Fact?  model;
  final List<Fact>  list;


  CatFactState copyWith({
    bool? isLoading,
    Fact? model,
    List<Fact>? list

  }) {
    return CatFactState(
      isLoading: isLoading ?? this.isLoading,
      model: model ?? this.model,
      list: list ?? this.list
    );
  }

  @override
  List<Object?> get props => [ isLoading, model, list];
}

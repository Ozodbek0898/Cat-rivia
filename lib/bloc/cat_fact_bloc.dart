import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_trivia/api_service/api_service.dart';
import 'package:cat_trivia/api_service/hive_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/fact_model.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  CatFactBloc() : super(const CatFactState(

  )) {
    on<CatFactLoaded>(_catFactLoaded);
    on<GetHistoryFacts>(_catHistoryFacts);
  }

  HiveService hiveService = HiveService();

  Future<void> _catFactLoaded(CatFactLoaded event, Emitter<CatFactState> emit) async {
    await hiveService.init();
    emit(state.copyWith(isLoading: true));
    var service = ApiService.init();
    var fact = await service.getFact();
    if(fact != null){
      hiveService.setFact(fact);
      emit(state.copyWith( model: fact));

    }

    emit(state.copyWith(isLoading: false,));
  }

  Future<void> _catHistoryFacts(GetHistoryFacts event, Emitter<CatFactState> emit) async {
    emit(state.copyWith(isLoading: true));
    var facts = hiveService.getFacts();

    emit(state.copyWith(isLoading: false, list: facts));
  }


}

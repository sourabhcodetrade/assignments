import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_project/app/core/controller/api_controller.dart';
import 'package:firebase_auth_project/app/core/services/enum_api_method_type.dart';
import 'package:flutter/material.dart';
import '../../../core/contants/api_contants.dart';
part 'all_hero_event.dart';
part 'all_hero_state.dart';

class AllHeroBloc extends Bloc<AllHeroEvent, AllHeroState> {
  AllHeroBloc() : super(HomeScreenInitial()) {
    on<GetHero>(getHero);
  }
  final List _allHero = [];

  void getHero(GetHero event, Emitter<AllHeroState> emit) async {
    if (event.isRefresh) {
      _allHero.clear();
      emit(AllHeroLoading());
    }

    try {
      ApiController().callAPi(apiMethodTypeEnum: ApiMethodTypeEnum.get,
          url: "https://api.coindesk.com/v1/bpi/currentprice.json",
          headers: {});
      Response response = await Dio().get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        List newDataList = jsonDecode(response.data);
        _allHero.addAll(newDataList);
        await Future.delayed(const Duration(seconds: 2));
        emit(AllHeroSuccess("Data Success", _allHero));
      } else {
        debugPrint("Something went wrong");
        emit(const AllHeroFailure("Data Failure"));
      }
    } on DioException catch (e) {
      debugPrint('Error fetching data: $e');
      emit(AllHeroFailure(e.toString()));
    } catch (e) {
      debugPrint('Error fetching data: $e');
      emit(AllHeroFailure(e.toString()));
    }
  }
}

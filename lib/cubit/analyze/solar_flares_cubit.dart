import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:nasa_project/models/save_sun_model.dart';
import 'package:nasa_project/network/dio_helper1.dart';

part 'solar_flares_state.dart';


class SolarFlaresCubit extends Cubit<SolarFlaresState> {
  SolarFlaresCubit() : super(SolarFlaresInitial());
    static SolarFlaresCubit get(context) => BlocProvider.of(context);
   
   SaveSunModel? saveSunModel;

  void SolarActivitySummry() async {
    emit(SolarFlaresLoading());
    DioHelper.getData(end_point: "fetch-nasa-data").then((value) {
      if(value.statusCode == 200){ 
         saveSunModel = SaveSunModel.fromJson(value.data);
        emit(SolarFlaresSuccess());
      }else {
        if(kDebugMode){
          print(value.data);
        }
        emit(SolarFlaresFailed());
      }
    }).catchError((error) {
      print(error.toString());
      emit(SolarFlaresFailed());
    });
     
  }
}
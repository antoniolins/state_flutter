// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_flutter/bloc_visibility/visibility_event.dart';
import 'package:state_flutter/bloc_visibility/visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState>  {

  VisibilityBloc():super(VisibilityState(show: true)) {

    on<VisibilityShowEvent>(
      (event, emit) => emit(VisibilityState(show: true)));

    on<VisibilityHideEvent>(
      (event, emit) => emit(VisibilityState(show: false)));

  }


}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozin/features/places/presentation/pages/widgets/tabs/general/widgets/gps_open/cubit/gpsopen_cubit.dart';
class GpsModalFit extends StatelessWidget {
  final GpsOpenCubit gpsOpenCubit;

  const GpsModalFit({Key key, @required this.gpsOpenCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: BlocBuilder<GpsOpenCubit, GpsOpenState>(
          cubit: gpsOpenCubit,
          builder: (context, state) {
            if (state is GpsElements) {
              return state.elements;
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';

class BtnIntersection extends StatelessWidget {
  const BtnIntersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final searchBloc = BlocProvider.of<SearchBloc>(context);
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
      return BlocBuilder<DriverBloc, DriverState>(
          builder: (context, driverState) {
        return searchState.displayLegend
            ? const SizedBox()
            : FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: const _BtnIntersectionBody());
      });
    });
  }
}

class _BtnIntersectionBody extends StatelessWidget {
  const _BtnIntersectionBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverBloc = BlocProvider.of<DriverBloc>(context);
    driverBloc.add(const OnBtnDriverEvent(boton:false));
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.bus_alert,
            color: Colors.black,
            // color: Color.fromARGB(255, 99, 80, 80),
          ),
          onPressed: () async {
            // ! Instancias de los gestores de estado
            final mapBloc = BlocProvider.of<MapBloc>(context);
            //* puntoactual tiene la ubicacion del usuario en el momento que apretaron el boton
            final myRange = mapBloc.state.circles.first;
            //! aqui es donde llama a tu metodo y se supone que me devuelve las lineas correctas
            //* por ahora lo que hace es intersectar Todas las polylines(ida y vuelta) que se encuentran dentro de 'myRange'
            final busService = BlocProvider.of<BusBloc>(context);
            final intersectedPolylines =
                busService.getIntersectedLines(myRange);
            // * Esta cosa lo que hace es actualizar las polylines(ida, vuelta) del mapa  para que las dibuje
            mapBloc.add(UpdatePolylinesEvent(intersectedPolylines));
            await Future.delayed(const Duration(milliseconds: 300));
            final lineasUnicas = busService.getMapFromSet(mapBloc.state.polylines);
            final searchBloc = BlocProvider.of<SearchBloc>(context);
            // //*actualiza las polylines en SearchBloc
            searchBloc.add(OnUpdateRoutesSearchEvent(lineasUnicas));
            //* Activa la Legenda
            searchBloc.add(OnActivateLegendEvent());
          },
        ),
      ),
    );
  }
}

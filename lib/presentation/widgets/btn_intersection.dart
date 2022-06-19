import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';
import 'package:micros_user_app/data/routes/routes.dart';

class BtnIntersection extends StatelessWidget {
  const BtnIntersection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayLegend
            ? const SizedBox()
            : FadeInRight(
                duration: const Duration(milliseconds: 300),
                child: const _BtnIntersectionBody());
      },
    );
  }
}

class _BtnIntersectionBody extends StatelessWidget {
  const _BtnIntersectionBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.bus_alert,
            color: Colors.black,
          ),
          onPressed: () {
            // ! Instancias de los gestores de estado
            final searchBloc = BlocProvider.of<SearchBloc>(context);
            searchBloc.add(OnActivateLegendEvent());
                  final mapBloc = BlocProvider.of<MapBloc>(context);
            //* puntoactual tiene la ubicacion del usuario en el momento que apretaron el boton
            final myRange = mapBloc.state.circles.first;
            //! aqui es donde llama a tu metodo y se supone que me devuelve las lineas correctas
            //* por ahora lo que hace es devolverme todas
            final busService = BlocProvider.of<BusBloc>(context);
            // final intersectedPolylines = BusRoutes.getIntersectedLines(myRange);
            final intersectedPolylines =
                busService.getIntersectedLines(myRange);
            print('-------------------------------------------------');
            print(intersectedPolylines);
            print(intersectedPolylines.length);

            // * Esta cosa lo que hace es actualizar las polylines del mapa para que las dibuje
            mapBloc.add(UpdatePolylinesEvent(intersectedPolylines));
          },
        ),
      ),
    );
  }
}

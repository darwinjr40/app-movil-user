import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';

class BtnToogleUserRoute extends StatelessWidget {
  const BtnToogleUserRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: const Icon(
            Icons.format_paint_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            mapBloc.add(OnToogleUserRoute());
          },
        ),
      ),
    );
  }
}

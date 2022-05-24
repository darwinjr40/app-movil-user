import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:micros_user_app/data/blocs/blocs.dart';

class BtnShowRange extends StatelessWidget {
  const BtnShowRange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(
                state.showMyRange
                    ? Icons.cancel_outlined
                    : Icons.circle_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                mapBloc.state.showMyRange
                    ? mapBloc.add(OnDeactivateShowRange())
                    : mapBloc.add(OnActivateShowRange());
              },
            );
          },
        ),
      ),
    );
  }
}

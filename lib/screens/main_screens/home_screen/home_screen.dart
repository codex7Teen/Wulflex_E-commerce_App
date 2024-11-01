import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is LogOutSuccess) {
            Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ScreenLogin()));
          }
        },
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthenticatonBlocBloc>(context)
                      .add(LogOutButtonPressed());
                },
                child: Text('signout'))),
      ),
    );
  }
}

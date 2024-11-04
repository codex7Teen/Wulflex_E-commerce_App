import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen/login_screen.dart';

class ScreenSignOut extends StatelessWidget {
  const ScreenSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        listener: (context, state) {
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
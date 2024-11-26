import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/blocs/authentication_bloc/authenticaton_bloc_bloc.dart';
import 'package:wulflex/screens/aunthentication_screens/login_screen/login_screen.dart';
import 'package:wulflex/screens/main_screens/account_screens/sign_out_screens/signout_alert_widget.dart';
import 'package:wulflex/widgets/custom_snacbar_widget.dart';

class ScreenSignOut extends StatelessWidget {
  const ScreenSignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticatonBlocBloc, AuthenticatonBlocState>(
        listener: (context, state) {
          if (state is LogOutSuccess) {
            CustomSnackbar.showCustomSnackBar(
                context, "Sign-out success...  🎉🎉🎉");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ScreenLogin()));
          }
        },
        child: Center(
            child: ElevatedButton(
                onPressed: () {
                  showCustomSignoutWarningAlertBox(context);
                },
                child: Text('signout'))),
      ),
    );
  }
}

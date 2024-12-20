import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wulflex/features/account/bloc/relogin/relogin_bloc.dart';
import 'package:wulflex/features/account/presentation/screens/delete_account_screen.dart';
import 'package:wulflex/features/account/presentation/widgets/relogin_screen_widget.dart';
import 'package:wulflex/core/config/app_colors.dart';
import 'package:wulflex/shared/widgets/custom_appbar_with_backbutton.dart';
import 'package:wulflex/shared/widgets/custom_snacbar_widget.dart';
import 'package:wulflex/shared/widgets/navigation_helper_widget.dart';

class ScreenRelogin extends StatefulWidget {
  const ScreenRelogin({super.key});

  @override
  State<ScreenRelogin> createState() => _ScreenReloginState();
}

class _ScreenReloginState extends State<ScreenRelogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor(context),
      appBar: customAppbarWithBackbutton(context, ''),
      body: SingleChildScrollView(
        child: BlocListener<ReloginBloc, ReloginState>(
          listener: (context, state) {
            if (state is ReloginSuccess) {
              CustomSnackbar.showCustomSnackBar(context, 'Re-login success');
              Future.delayed(
                  Duration(seconds: 1),
                  () => NavigationHelper.navigateToWithoutReplacement(
                      context, ScreenDeleteAccount()));
            } else if (state is ReloginError) {
              CustomSnackbar.showCustomSnackBar(context, state.errorMessage,
                  icon: Icons.error);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ReloginScreenWidget.buildLoginImage(context),
                    const SizedBox(height: 30),
                    ReloginScreenWidget.buildLoginHeading(context),
                    const SizedBox(height: 14),
                    ReloginScreenWidget.buildEmailField(_emailTextController),
                    const SizedBox(height: 30),
                    ReloginScreenWidget.buildPasswordField(
                        _passwordTextController, _isPasswordVisible, () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }),
                    const SizedBox(height: 22),
                    ReloginScreenWidget.buildForgotPasswordLink(context),
                    const SizedBox(height: 22),
                    ReloginScreenWidget.buildLoginButton(context, _formKey,
                        _emailTextController, _passwordTextController),
                    const SizedBox(height: 22),
                    ReloginScreenWidget.buildGoogleLoginButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

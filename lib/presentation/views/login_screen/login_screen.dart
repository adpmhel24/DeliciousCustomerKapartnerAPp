import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/views/login_screen/bloc/bloc.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:upgrader/upgrader.dart';

import '../../../global_bloc/app_init_bloc/bloc.dart';
import 'components/body.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginFormBloc(),
        ),
        BlocProvider(create: (context) => AppInitBloc()..add(AutoLogin())),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoginFormBloc, LoginFormState>(
                listener: (_, state) {
                  if (state.status.isSubmissionSuccess) {
                    context.loaderOverlay.hide();
                  } else if (state.status.isSubmissionFailure) {
                    CustomDialog.error(context, message: state.message);
                  } else if (state.status.isSubmissionInProgress) {
                    context.loaderOverlay.show();
                  }
                },
              ),
              BlocListener<AppInitBloc, AppInitState>(
                listener: (_, state) {
                  if (state is AppInitLoading) {
                    context.loaderOverlay.show();
                  } else if (state is Error) {
                    CustomDialog.error(
                      context,
                      barrierDismissible: false,
                      message: state.message,
                      onPositiveClick: () {
                        SystemNavigator.pop();
                      },
                    );
                  } else if (state is TryingToLogin) {
                    context.loaderOverlay.show();
                  } else if (state is AutoLoginSuccessful) {
                    context.loaderOverlay.hide();
                  } else if (state is AutoLoginFailed) {
                    context.loaderOverlay.hide();
                  }
                },
              ),
            ],
            child: Scaffold(
              body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Tap back again to leave'),
                ),
                child: UpgradeAlert(
                  child: const LoginBody(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kapartner_app/presentation/views/login_screen/bloc/bloc.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';

import '../../../global_bloc/app_init_bloc/bloc.dart';
import '../../widget/custom_updater_dialog.dart';
import 'components/body.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({Key? key, this.onLoginCallback}) : super(key: key);
  final Function(bool loggedIn)? onLoginCallback;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginFormBloc(),
        ),
        BlocProvider(
          create: (context) => AppInitBloc()
            ..add(OpeningApp())
            ..add(AutoLogin()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoginFormBloc, LoginFormState>(
                listener: (_, state) {
                  if (state.status.isSubmissionSuccess) {
                    onLoginCallback?.call(true);
                  } else if (state.status.isSubmissionFailure) {
                    CustomDialog.error(context, message: state.message);
                  } else if (state.status.isSubmissionInProgress) {
                    CustomDialog.loading(context);
                  }
                },
              ),
              BlocListener<AppInitBloc, AppInitState>(
                listener: (_, state) {
                  if (state is AppInitLoading) {
                    CustomDialog.loading(context);
                  } else if (state is NewUpdateAvailable) {
                    Navigator.of(context).pop();
                    NewUpdate.displayAlert(
                      context,
                      appName: state.devicePackageInfo.appName,
                      message: const Text(
                          "A version of Delicious Ordering App is available! "),
                      appUrl:
                          "https://github.com/adpmhel24/DeliciousCustomerKapartnerAPp/releases/download/v1.0.${state.availableVersion.buildNumber}/kadelicious_app.apk",
                      releaseNotes: state.availableVersion.releaseNotes,
                    );
                  } else if (state is Error) {
                    CustomDialog.error(
                      context,
                      barrierDismissible: false,
                      message: state.message,
                      onPositiveClick: () {
                        SystemNavigator.pop();
                      },
                    );
                  } else if (state is NoUpdateAvailable) {
                    Navigator.of(context).pop();
                  } else if (state is AutoLoginSuccessful) {
                    onLoginCallback?.call(true);
                  }
                },
              ),
            ],
            child: const Scaffold(
              body: DoubleBackToCloseApp(
                snackBar: SnackBar(
                  content: Text('Tap back again to leave'),
                ),
                child: LoginBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}

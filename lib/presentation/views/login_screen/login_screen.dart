import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:kapartner_app/presentation/views/login_screen/bloc/bloc.dart';
import 'package:kapartner_app/presentation/widget/custom_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../global_bloc/app_init_bloc/bloc.dart';
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
        BlocProvider(create: (context) => AppInitBloc()..add(OpeningApp())),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoginFormBloc, LoginFormState>(
                listener: (_, state) {
                  if (state.status.isSubmissionSuccess) {
                    context.loaderOverlay.hide();
                    onLoginCallback?.call(true);
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
                  } else if (state is NewUpdateAvailable) {
                    // Navigator.of(context).pop();
                    // NewUpdate.displayAlert(
                    //   context,
                    //   appName: state.devicePackageInfo.appName,
                    //   message: const Text("New version is available! "),
                    //   appUrl:
                    //       "https://github.com/adpmhel24/DeliciousCustomerKapartnerAPp/releases/download/v1.0.${state.availableVersion.buildNumber}/kadelicious_app.apk",
                    //   releaseNotes: state.availableVersion.releaseNotes,

                    context.loaderOverlay.hide(); // );
                    InAppUpdate.performImmediateUpdate().catchError(
                      (e) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                      },
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
                    context.loaderOverlay.hide();
                    context.read<AppInitBloc>().add(AutoLogin());
                  } else if (state is TryingToLogin) {
                    context.loaderOverlay.show();
                  } else if (state is AutoLoginSuccessful) {
                    context.loaderOverlay.hide();
                    onLoginCallback?.call(true);
                  } else if (state is AutoLoginFailed) {
                    context.loaderOverlay.hide();
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

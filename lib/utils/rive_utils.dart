import 'package:rive/rive.dart';

class RiveUtils {
  static SMIBool getRiveInput(
    Artboard artBoard, {
    required String stateMachineName,
  }) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artBoard, stateMachineName);

    artBoard.addController(controller!);

    return controller.findInput<bool>("active") as SMIBool;
  }

  static void chnageSMIBoolState(SMIBool input) {
    input.change(true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        input.change(false);
      },
    );
  }
}

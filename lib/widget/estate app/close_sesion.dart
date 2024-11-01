// import 'package:webandean/local_storage/shared_preferences/shaerd_preferences.dart';
// import 'package:webandean/utils/colors/assets_colors.dart';
// import 'package:webandean/utils/files/assets-svg.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';
// import 'package:flutter/material.dart';

// class CloseSesion extends StatelessWidget {
//   const CloseSesion({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//         visualDensity: VisualDensity.compact,
//         dense: true,
//         contentPadding: const EdgeInsets.all(0),
//         minVerticalPadding: 0,
//         leading: AppSvg(width: 18).cloesesion,
//         onTap: () async {
//           isSescionClean(context);
//         },
//         title: const P2Text(
//           text: 'Cerrar Sesión',
//           color: AppColors.primaryRed,
//            fontWeight: FontWeight.w500,
//         fontSize: 12,
//         ));
//   }

//   void isSescionClean(BuildContext context) async {
//     SharedPrefencesGlobal sharedPrefs = SharedPrefencesGlobal();
//     // Luego, llama al método setLoggedIn en esa instancia
//     await sharedPrefs.logout(context);
//     await sharedPrefs.logoutRunner(context);

//     await SharedPrefencesGlobal().deleteEmpleado();

//     await SharedPrefencesGlobal().deleteParticipante();//NUEVO
//   }
// }

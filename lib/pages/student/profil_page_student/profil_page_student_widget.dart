import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profil_page_student_model.dart';
export 'profil_page_student_model.dart';

/// Create Profile page for LearnHub.
///
/// Header gradient #FF6B35→#4F46E5 tall with back arrow. Below overlapping:
/// white card (rounded-2xl shadow): center avatar gradient circle 100px with
/// person icon + camera button blue circle bottom-right. Name "Jean Dupont"
/// bold 26px, "L3 Informatique", "Université Paris-Saclay" gray. Badges row:
/// blue "Étudiant" + green "Membre depuis Sept. 2024". "Modifier" button
/// gradient orange-blue. Stats 2x2 grid cards: 📊 15.2/20 Moyenne (green), 💼
/// 5 Candidatures (orange), 🎉 12 Événements (blue), ⭐ 1250 Points fidélité
/// (yellow). Contact card white: email row, phone row, address row (each with
/// colored icon square in gray-50 bg). Menu list card: Modifier profil, Mes
/// favoris, Mes certificats, Historique, Paramètres, Notifications, Aide &
/// Support (each with icon + chevron right). Bottom: "Se déconnecter" red
/// button full width → WelcomePage. Font: Inter.
class ProfilPageStudentWidget extends StatefulWidget {
  const ProfilPageStudentWidget({super.key});

  static String routeName = 'ProfilPageStudent';
  static String routePath = '/profilPageStudent';

  @override
  State<ProfilPageStudentWidget> createState() =>
      _ProfilPageStudentWidgetState();
}

class _ProfilPageStudentWidgetState extends State<ProfilPageStudentWidget> {
  late ProfilPageStudentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilPageStudentModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F5F5),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [],
        ),
      ),
    );
  }
}

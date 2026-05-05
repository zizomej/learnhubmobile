import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/index.dart';
import 'notes_prof_widget.dart' show NotesProfWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesProfModel extends FlutterFlowModel<NotesProfWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for coefficient widget.
  FocusNode? coefficientFocusNode;
  TextEditingController? coefficientTextController;
  String? Function(BuildContext, String?)? coefficientTextControllerValidator;
  String? _coefficientTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'TextField is required';
    }

    if (val.length < 1) {
      return '1';
    }

    return null;
  }

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  String? _textController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '0-20 is required';
    }

    if (val.length < 4) {
      return '3';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    coefficientTextControllerValidator = _coefficientTextControllerValidator;
    textController2Validator = _textController2Validator;
  }

  @override
  void dispose() {
    coefficientFocusNode?.dispose();
    coefficientTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();
  }
}

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
import 'notes_modify_widget.dart' show NotesModifyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotesModifyModel extends FlutterFlowModel<NotesModifyWidget> {
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
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;

  FocusNode? ds1FocusNode;
  TextEditingController? ds1TextController;
  
  FocusNode? ds2FocusNode;
  TextEditingController? ds2TextController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    coefficientFocusNode?.dispose();
    coefficientTextController?.dispose();

    textFieldFocusNode?.dispose();
    textController2?.dispose();

    ds1FocusNode?.dispose();
    ds1TextController?.dispose();
    
    ds2FocusNode?.dispose();
    ds2TextController?.dispose();
  }
}

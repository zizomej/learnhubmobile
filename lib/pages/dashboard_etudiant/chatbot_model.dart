import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class ChatbotModel extends FlutterFlowModel {
  TextEditingController? textController;
  FocusNode? textFieldFocusNode;

  void initState(BuildContext context) {}

  void dispose() {
    textController?.dispose();
    textFieldFocusNode?.dispose();
  }
}

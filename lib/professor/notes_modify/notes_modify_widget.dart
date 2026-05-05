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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notes_modify_model.dart';
export 'notes_modify_model.dart';

/// LearnHub Professor Publish Grades.
///
/// AppBar gradient #059669 back "Publier des Notes". SingleChildScrollView:
/// Card white rounded-20 shadow margin-16 padding-16: DropdownButtonFormField
/// "Module" items Algorithmique BDD Réseaux POO. Row DropdownButtonFormField
/// "Semestre" 1 2 + DropdownButtonFormField "Filière". Row Icon calendar +
/// TextButton "Choisir date évaluation" + Text date selected. Divider. Text
/// "Notes étudiants" bold padding. LinearProgressIndicator green value
/// filled/total. ListView shrinkWrap physics NeverScroll: student rows white
/// rounded-12 shadow margin-4 padding-12: Row CircleAvatar initials colored +
/// Text name flex + SizedBox width-70 TextFormField decimal hint "0-20"
/// border outline + Text "C:3" small gray. SizedBox 80. Positioned bottom
/// FloatingBar white shadow: Text "32/48 saisies" + ElevatedButton green
/// "Publier les notes" fullWidth → Firestore batch write academic_records
/// type note. Font Inter.
class NotesModifyWidget extends StatefulWidget {
  const NotesModifyWidget({
    super.key,
    required this.record,
  });

  final AcademicRecordsRecord? record;

  static String routeName = 'NotesModify';
  static String routePath = '/notesModify';

  @override
  State<NotesModifyWidget> createState() => _NotesModifyWidgetState();
}

class _NotesModifyWidgetState extends State<NotesModifyWidget> {
  late NotesModifyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotesModifyModel());

    _model.coefficientTextController ??=
        TextEditingController(text: widget!.record?.coefficient?.toString());
    _model.coefficientFocusNode ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: widget!.record?.note?.toString());
    _model.textFieldFocusNode ??= FocusNode();

    _model.ds1TextController ??=
        TextEditingController(text: widget!.record?.ds1?.toString());
    _model.ds1FocusNode ??= FocusNode();
    
    _model.ds2TextController ??=
        TextEditingController(text: widget!.record?.ds2?.toString());
    _model.ds2FocusNode ??= FocusNode();

    void updateNote() {
      double ds1 = double.tryParse(_model.ds1TextController!.text) ?? 0.0;
      double ds2 = double.tryParse(_model.ds2TextController!.text) ?? 0.0;
      _model.textController2!.text = ((ds1 + ds2) / 2).toStringAsFixed(2);
    }
    
    _model.ds1TextController!.addListener(updateNote);
    _model.ds2TextController!.addListener(updateNote);
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
        backgroundColor: Color(0xFFF0FDF4),
        appBar: AppBar(
          backgroundColor: Color(0xFF059669),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () async {
                context.pushNamed(ProfessorDashboardWidget.routeName);
              },
            ),
          ),
          title: Text(
            'Modifier des Notes',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 6.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<AcademicRecordsRecord>>(
                stream: queryAcademicRecordsRecord(
                  singleRecord: true,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<AcademicRecordsRecord> formAcademicRecordsRecordList =
                      snapshot.data!;
                  // Return an empty Container when the item does not exist.
                  if (snapshot.data!.isEmpty) {
                    return Container();
                  }
                  final formAcademicRecordsRecord =
                      formAcademicRecordsRecordList.isNotEmpty
                          ? formAcademicRecordsRecordList.first
                          : null;

                  return Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16.0, 16.0, 16.0, 100.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await AcademicRecordsRecord.collection
                                      .doc()
                                      .set(createAcademicRecordsRecordData(
                                        module: _model.dropDownValue1,
                                        filiere: _model.dropDownValue3,
                                        note: double.tryParse(
                                            _model.textController2.text),
                                      ));
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 16.0,
                                        color: Color(0x1A000000),
                                        offset: Offset(
                                          0.0,
                                          4.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FlutterFlowDropDown<String>(
                                          controller: _model
                                                  .dropDownValueController1 ??=
                                              FormFieldController<String>(
                                            _model.dropDownValue1 ??=
                                                widget!.record?.module,
                                          ),
                                          options: [
                                            'Algorithmique',
                                            'Base de Données',
                                            'Réseaux',
                                            'POO'
                                          ],
                                          onChanged: (val) => safeSetState(() =>
                                              _model.dropDownValue1 = val),
                                          width: double.infinity,
                                          height: 52.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF1F2937),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          hintText: 'Sélectionner un module',
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Color(0xFF059669),
                                            size: 22.0,
                                          ),
                                          fillColor: Color(0xFFF9FAFB),
                                          elevation: 2.0,
                                          borderColor: Color(0xFFE5E7EB),
                                          borderWidth: 1.0,
                                          borderRadius: 12.0,
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          hidesUnderline: true,
                                          isSearchable: false,
                                          isMultiSelect: false,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            FlutterFlowDropDown<String>(
                                              controller: _model
                                                      .dropDownValueController2 ??=
                                                  FormFieldController<String>(
                                                _model.dropDownValue2 ??=
                                                    widget!.record?.semestre
                                                        ?.toString(),
                                              ),
                                              options: [
                                                'Semestre 1',
                                                'Semestre 2'
                                              ],
                                              onChanged: (val) => safeSetState(
                                                  () => _model.dropDownValue2 =
                                                      val),
                                              width: 140.0,
                                              height: 52.0,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            Color(0xFF1F2937),
                                                        fontSize: 15.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                              hintText: 'Semestre',
                                              icon: Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Color(0xFF059669),
                                                size: 22.0,
                                              ),
                                              fillColor: Color(0xFFF9FAFB),
                                              elevation: 2.0,
                                              borderColor: Color(0xFFE5E7EB),
                                              borderWidth: 1.0,
                                              borderRadius: 12.0,
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              hidesUnderline: true,
                                              isSearchable: false,
                                              isMultiSelect: false,
                                            ),
                                            Expanded(
                                              child:
                                                  FlutterFlowDropDown<String>(
                                                controller: _model
                                                        .dropDownValueController3 ??=
                                                    FormFieldController<String>(
                                                  _model.dropDownValue3 ??=
                                                      widget!.record?.filiere,
                                                ),
                                                options: [
                                                  'Informatique',
                                                  'Mathématiques',
                                                  'Physique'
                                                ],
                                                onChanged: (val) =>
                                                    safeSetState(() => _model
                                                        .dropDownValue3 = val),
                                                height: 52.0,
                                                textStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFF1F2937),
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                hintText: 'Filière',
                                                icon: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Color(0xFF059669),
                                                  size: 22.0,
                                                ),
                                                fillColor: Color(0xFFF9FAFB),
                                                elevation: 2.0,
                                                borderColor: Color(0xFFE5E7EB),
                                                borderWidth: 1.0,
                                                borderRadius: 12.0,
                                                margin: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                hidesUnderline: true,
                                                isSearchable: false,
                                                isMultiSelect: false,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                        Divider(
                                          height: 1.0,
                                          thickness: 1.0,
                                          color: Color(0xFFECFDF5),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListView(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(12.0, 12.0,
                                                          12.0, 12.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 6.0,
                                                          color:
                                                              Color(0x0D000000),
                                                          offset: Offset(
                                                            0.0,
                                                            2.0,
                                                          ),
                                                        )
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(12.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 200.0,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        _model
                                                                            .coefficientTextController,
                                                                    focusNode:
                                                                        _model
                                                                            .coefficientFocusNode,
                                                                    autofocus:
                                                                        false,
                                                                    enabled:
                                                                        true,
                                                                    obscureText:
                                                                        false,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      labelText:
                                                                          '',
                                                                      labelStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Color(0xFF9CA3AF),
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodySmall.fontStyle,
                                                                          ),
                                                                      hintText:
                                                                          'TextField',
                                                                      hintStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                          ),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Color(0x00000000),
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      errorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      focusedErrorBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).error,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .secondaryBackground,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    cursorColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    enableInteractiveSelection:
                                                                        true,
                                                                    validator: _model
                                                                        .coefficientTextControllerValidator
                                                                        .asValidator(
                                                                            context),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 44.0,
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFFF9FAFB),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                border: Border.all(color: Color(0xFFE5E7EB), width: 1.0),
                                                              ),
                                                              child: TextFormField(
                                                                controller: _model.ds1TextController,
                                                                focusNode: _model.ds1FocusNode,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  hintText: 'DS1',
                                                                  border: InputBorder.none,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 44.0,
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFFF9FAFB),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                                border: Border.all(color: Color(0xFFE5E7EB), width: 1.0),
                                                              ),
                                                              child: TextFormField(
                                                                controller: _model.ds2TextController,
                                                                focusNode: _model.ds2FocusNode,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  hintText: 'DS2',
                                                                  border: InputBorder.none,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 60.0,
                                                              height: 44.0,
                                                              decoration: BoxDecoration(
                                                                color: Color(0xFFE5E7EB),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              child: TextFormField(
                                                                controller: _model.textController2,
                                                                focusNode: _model.textFieldFocusNode,
                                                                readOnly: true,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  hintText: 'Moy',
                                                                  border: InputBorder.none,
                                                                ),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 12.0)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ].divide(SizedBox(height: 12.0)),
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  128.0, 0.0, 13.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'confirmation de modification'),
                                                    content:
                                                        Text('vous etes sure'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child: Text('Confirm'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;

                                      await formAcademicRecordsRecord!.reference
                                          .update(
                                              createAcademicRecordsRecordData(
                                        module: _model.dropDownValue1,
                                        filiere: _model.dropDownValue2,
                                        note: double.tryParse(
                                            _model.textController2!.text),
                                        ds1: double.tryParse(
                                            _model.ds1TextController!.text),
                                        ds2: double.tryParse(
                                            _model.ds2TextController!.text),
                                        coefficient: int.tryParse(_model
                                            .coefficientTextController!.text),
                                      ));

                                      context.pushNamed(
                                        NoteaffichageWidget.routeName,
                                        queryParameters: {
                                          'reccord': serializeParam(
                                            formAcademicRecordsRecord,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'reccord': formAcademicRecordsRecord,
                                        },
                                      );
                                    },
                                    text: 'Publier',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFF0CA03A),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.interTight(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AcademicRecordsRecord extends FirestoreRecord {
  AcademicRecordsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user_id" field.
  String? _userId;

  /// ID de l'étudiant (pour notes)
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "type" field.
  String? _type;

  /// note ou ressource
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "module" field.
  String? _module;

  /// Nom du module
  String get module => _module ?? '';
  bool hasModule() => _module != null;

  // "niveau" field.
  String? _niveau;
  String get niveau => _niveau ?? '';
  bool hasNiveau() => _niveau != null;

  // "filiere" field.
  String? _filiere;
  String get filiere => _filiere ?? '';
  bool hasFiliere() => _filiere != null;

  // "semestre" field.
  int? _semestre;
  int get semestre => _semestre ?? 0;
  bool hasSemestre() => _semestre != null;

  // "annee" field.
  String? _annee;
  String get annee => _annee ?? '';
  bool hasAnnee() => _annee != null;

  // "note" field.
  double? _note;
  double get note => _note ?? 0.0;
  bool hasNote() => _note != null;

  // "ds1" field.
  double? _ds1;
  double get ds1 => _ds1 ?? 0.0;
  bool hasDs1() => _ds1 != null;

  // "ds2" field.
  double? _ds2;
  double get ds2 => _ds2 ?? 0.0;
  bool hasDs2() => _ds2 != null;

  // "coefficient" field.
  int? _coefficient;
  int get coefficient => _coefficient ?? 0;
  bool hasCoefficient() => _coefficient != null;

  // "enseignant" field.
  String? _enseignant;

  /// Nom du professeur
  String get enseignant => _enseignant ?? '';
  bool hasEnseignant() => _enseignant != null;

  // "date_eval" field.
  DateTime? _dateEval;
  DateTime? get dateEval => _dateEval;
  bool hasDateEval() => _dateEval != null;

  // "titre" field.
  String? _titre;

  /// Titre (ressource ou devoir)
  String get titre => _titre ?? '';
  bool hasTitre() => _titre != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "file_url" field.
  String? _fileUrl;

  /// URL du fichier
  String get fileUrl => _fileUrl ?? '';
  bool hasFileUrl() => _fileUrl != null;

  // "file_type" field.
  String? _fileType;

  /// pdf / video
  String get fileType => _fileType ?? '';
  bool hasFileType() => _fileType != null;

  // "vues" field.
  int? _vues;

  /// Nombre de vues (ressource)
  int get vues => _vues ?? 0;
  bool hasVues() => _vues != null;

  // "telechargements" field.
  int? _telechargements;

  /// Nombre de téléchargements
  int get telechargements => _telechargements ?? 0;
  bool hasTelechargements() => _telechargements != null;

  // "uploade_par" field.
  String? _uploadePar;

  /// ID du professeur/admin
  String get uploadePar => _uploadePar ?? '';
  bool hasUploadePar() => _uploadePar != null;

  // "created_at" field.
  DateTime? _createdAt;

  /// Date d'ajout
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _userId = snapshotData['user_id'] as String?;
    _type = snapshotData['type'] as String?;
    _module = snapshotData['module'] as String?;
    _niveau = snapshotData['niveau'] as String?;
    _filiere = snapshotData['filiere'] as String?;
    _semestre = castToType<int>(snapshotData['semestre']);
    _annee = snapshotData['annee'] as String?;
    _note = castToType<double>(snapshotData['note']);
    _ds1 = castToType<double>(snapshotData['ds1']);
    _ds2 = castToType<double>(snapshotData['ds2']);
    _coefficient = castToType<int>(snapshotData['coefficient']);
    _enseignant = snapshotData['enseignant'] as String?;
    _dateEval = snapshotData['date_eval'] as DateTime?;
    _titre = snapshotData['titre'] as String?;
    _description = snapshotData['description'] as String?;
    _fileUrl = snapshotData['file_url'] as String?;
    _fileType = snapshotData['file_type'] as String?;
    _vues = castToType<int>(snapshotData['vues']);
    _telechargements = castToType<int>(snapshotData['telechargements']);
    _uploadePar = snapshotData['uploade_par'] as String?;
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('academic_records');

  static Stream<AcademicRecordsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AcademicRecordsRecord.fromSnapshot(s));

  static Future<AcademicRecordsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AcademicRecordsRecord.fromSnapshot(s));

  static AcademicRecordsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AcademicRecordsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AcademicRecordsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AcademicRecordsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AcademicRecordsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AcademicRecordsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAcademicRecordsRecordData({
  String? userId,
  String? type,
  String? module,
  String? niveau,
  String? filiere,
  int? semestre,
  String? annee,
  double? note,
  double? ds1,
  double? ds2,
  int? coefficient,
  String? enseignant,
  DateTime? dateEval,
  String? titre,
  String? description,
  String? fileUrl,
  String? fileType,
  int? vues,
  int? telechargements,
  String? uploadePar,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_id': userId,
      'type': type,
      'module': module,
      'niveau': niveau,
      'filiere': filiere,
      'semestre': semestre,
      'annee': annee,
      'note': note,
      'ds1': ds1,
      'ds2': ds2,
      'coefficient': coefficient,
      'enseignant': enseignant,
      'date_eval': dateEval,
      'titre': titre,
      'description': description,
      'file_url': fileUrl,
      'file_type': fileType,
      'vues': vues,
      'telechargements': telechargements,
      'uploade_par': uploadePar,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class AcademicRecordsRecordDocumentEquality
    implements Equality<AcademicRecordsRecord> {
  const AcademicRecordsRecordDocumentEquality();

  @override
  bool equals(AcademicRecordsRecord? e1, AcademicRecordsRecord? e2) {
    return e1?.userId == e2?.userId &&
        e1?.type == e2?.type &&
        e1?.module == e2?.module &&
        e1?.niveau == e2?.niveau &&
        e1?.filiere == e2?.filiere &&
        e1?.semestre == e2?.semestre &&
        e1?.annee == e2?.annee &&
        e1?.note == e2?.note &&
        e1?.ds1 == e2?.ds1 &&
        e1?.ds2 == e2?.ds2 &&
        e1?.coefficient == e2?.coefficient &&
        e1?.enseignant == e2?.enseignant &&
        e1?.dateEval == e2?.dateEval &&
        e1?.titre == e2?.titre &&
        e1?.description == e2?.description &&
        e1?.fileUrl == e2?.fileUrl &&
        e1?.fileType == e2?.fileType &&
        e1?.vues == e2?.vues &&
        e1?.telechargements == e2?.telechargements &&
        e1?.uploadePar == e2?.uploadePar &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(AcademicRecordsRecord? e) => const ListEquality().hash([
        e?.userId,
        e?.type,
        e?.module,
        e?.niveau,
        e?.filiere,
        e?.semestre,
        e?.annee,
        e?.note,
        e?.ds1,
        e?.ds2,
        e?.coefficient,
        e?.enseignant,
        e?.dateEval,
        e?.titre,
        e?.description,
        e?.fileUrl,
        e?.fileType,
        e?.vues,
        e?.telechargements,
        e?.uploadePar,
        e?.createdAt
      ]);

  @override
  bool isValidKey(Object? o) => o is AcademicRecordsRecord;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class AcademicRecordsScreen extends StatefulWidget {
  const AcademicRecordsScreen({super.key});

  @override
  State<AcademicRecordsScreen> createState() => _AcademicRecordsScreenState();
}

class _AcademicRecordsScreenState extends State<AcademicRecordsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _grades = [
    {
      'module': 'Mathématiques',
      'note': 16.0,
      'coeff': 4,
      'teacher': 'Prof. Dupont',
      'date': '15 Mar 2026'
    },
    {
      'module': 'Algorithmique',
      'note': 14.5,
      'coeff': 3,
      'teacher': 'Prof. Martin',
      'date': '20 Mar 2026'
    },
    {
      'module': 'Bases de Données',
      'note': 17.0,
      'coeff': 3,
      'teacher': 'Prof. Bernard',
      'date': '22 Mar 2026'
    },
    {
      'module': 'Réseaux',
      'note': 13.0,
      'coeff': 2,
      'teacher': 'Prof. Petit',
      'date': '25 Mar 2026'
    },
    {
      'module': 'Anglais',
      'note': 15.5,
      'coeff': 2,
      'teacher': 'Prof. Smith',
      'date': '27 Mar 2026'
    },
  ];

  double get _average {
    final totalCoeff = _grades.fold(0, (s, g) => s + (g['coeff'] as int));
    final totalPoints = _grades.fold(
        0.0, (s, g) => s + (g['note'] as double) * (g['coeff'] as int));
    return totalPoints / totalCoeff;
  }

  Color _gradeColor(double note) {
    if (note >= 16) return AppTheme.success;
    if (note >= 12) return AppTheme.warning;
    return AppTheme.error;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.gray50,
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF34D399), Color(0xFF059669)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 52, 16, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.go('/dashboard'),
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white),
                      ),
                      const Expanded(
                        child: Text('Notes & Relevés',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                // Average Card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppTheme.radiusXxl),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(_average.toStringAsFixed(2),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold)),
                            const Text('Moyenne Générale',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                        const VerticalDivider(color: Colors.white30, width: 1),
                        Column(
                          children: [
                            Text('${_grades.length}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                            const Text('Matières',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                        const VerticalDivider(color: Colors.white30, width: 1),
                        Column(
                          children: [
                            const Text('L3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                            const Text('Niveau',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  tabs: const [Tab(text: 'Notes'), Tab(text: 'Récapitulatif')],
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Grades list
                ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _grades.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, i) {
                    final g = _grades[i];
                    final note = g['note'] as double;
                    final color = _gradeColor(note);
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                        boxShadow: AppTheme.shadowSm,
                        border:
                            Border(left: BorderSide(color: color, width: 4)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(g['module'] as String,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppTheme.gray800)),
                                const SizedBox(height: 2),
                                Text(g['teacher'] as String,
                                    style: const TextStyle(
                                        fontSize: 12, color: AppTheme.gray500)),
                                Text(g['date'] as String,
                                    style: const TextStyle(
                                        fontSize: 11, color: AppTheme.gray400)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radiusLg),
                                ),
                                child: Text('${note.toStringAsFixed(1)}/20',
                                    style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ),
                              const SizedBox(height: 4),
                              Text('Coeff. ${g['coeff']}',
                                  style: const TextStyle(
                                      fontSize: 11, color: AppTheme.gray400)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Summary
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ...[1, 2, 3].map((sem) {
                        final avg = 13.0 + sem;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusXl),
                              boxShadow: AppTheme.shadowSm,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Semestre $sem',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.gray800)),
                                    Text('${avg.toStringAsFixed(1)}/20',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.success)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      AppTheme.radiusFull),
                                  child: LinearProgressIndicator(
                                    value: avg / 20,
                                    backgroundColor: AppTheme.gray200,
                                    valueColor: const AlwaysStoppedAnimation(
                                        AppTheme.success),
                                    minHeight: 8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

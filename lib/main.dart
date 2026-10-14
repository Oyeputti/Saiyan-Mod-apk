import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SaiyanGlassWorkoutApp());
}

class SaiyanGlassWorkoutApp extends StatelessWidget {
  const SaiyanGlassWorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saiyan Protocol',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07080E),
        primaryColor: const Color(0xFFFF6B00),
      ),
      home: const MainGlassDashboard(),
    );
  }
}

class Exercise {
  final String code;
  final String name;
  final String category;
  final int sets;
  final String targetReps;
  final int restSeconds;
  final String muscleWorked;
  final String gokuQuote;
  final String animeReference;
  bool isCompleted;
  int completedSets;

  Exercise({
    required this.code,
    required this.name,
    required this.category,
    required this.sets,
    required this.targetReps,
    required this.restSeconds,
    required this.muscleWorked,
    required this.gokuQuote,
    required this.animeReference,
    this.isCompleted = false,
    this.completedSets = 0,
  });
}

class WorkoutDay {
  final int dayNumber;
  final String title;
  final String focus;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.dayNumber,
    required this.title,
    required this.focus,
    required this.exercises,
  });
}

final List<WorkoutDay> saiyanProtocolDays = [
  WorkoutDay(
    dayNumber: 1,
    title: "Day 1: Upper Body (Width & Stretch) + Lower Abs",
    focus: "Expanding lats, capping side delts, stretching arm fascia.",
    exercises: [
      Exercise(
        code: "1A",
        name: "Weighted Pull-Ups (or Lat Pulldowns)",
        category: "Back (Width)",
        sets: 4,
        targetReps: "6-8",
        restSeconds: 0,
        muscleWorked: "Upper Lats & Teres Major",
        gokuQuote: "Come on, let's go! Pull your chest to the bar—spread those Saiyan lats!",
        animeReference: "Goku 100x Gravity Pull-Ups (DBZ)",
      ),
      Exercise(
        code: "1B",
        name: "Straight-Arm Cable Pulldowns",
        category: "Back (Width)",
        sets: 4,
        targetReps: "Failure",
        restSeconds: 120,
        muscleWorked: "Lower Lats & Serratus",
        gokuQuote: "Zero rest! Sweep down till your lats cramp up!",
        animeReference: "Goku Kaioken Aura Sweep (DBZ)",
      ),
    ],
  ),
];

class MainGlassDashboard extends StatefulWidget {
  const MainGlassDashboard({super.key});

  @override
  State<MainGlassDashboard> createState() => _MainGlassDashboardState();
}

class _MainGlassDashboardState extends State<MainGlassDashboard> {
  int selectedDayIndex = 0;
  int caloriesBurned = 0;

  @override
  Widget build(BuildContext context) {
    final currentDay = saiyanProtocolDays[selectedDayIndex];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SAIYAN PROTOCOL • 4AM WAKE WINDOW",
                  style: TextStyle(color: Color(0xFFFF6B00), fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(currentDay.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: currentDay.exercises.length,
                  itemBuilder: (context, i) {
                    final ex = currentDay.exercises[i];
                    return CheckboxListTile(
                      value: ex.isCompleted,
                      title: Text("${ex.code}: ${ex.name}"),
                      subtitle: Text("Goku: \"${ex.gokuQuote}\""),
                      onChanged: (v) {
                        setState(() {
                          ex.isCompleted = v ?? false;
                          if (ex.isCompleted) caloriesBurned += 100;
                        });
                      },
                    );
                  },
                ),
              ),
              Text("Total Burned: $caloriesBurned kcal",
                  style: const TextStyle(color: Color(0xFFFFB800), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

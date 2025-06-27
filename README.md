# 🤖 Cyberdoku

> A sleek, AI-enhanced Sudoku puzzle app built with SwiftUI.  
> Cyberdoku explores intelligent hinting and solving strategies powered by Core ML and OpenAI.

![Swift](https://img.shields.io/badge/swift-5.9-orange)
![Platform](https://img.shields.io/badge/platform-iOS-blue)
![Status](https://img.shields.io/badge/status-WIP-lightgrey)

---

## 🧠 Goals

Cyberdoku aims to deliver a modern Sudoku experience with:

- Clean, touch-friendly SwiftUI interface
- Notes mode, mistake highlighting, and original cell tracking
- AI agents for suggestions, hints, and auto-solving
- Future support for Game Center and macOS

---

## 🗂 Architecture

```
Cyberdoku/
├── Models/         # SudokuCell, SudokuBoard
├── ViewModels/     # GameViewModel, UI logic
├── Views/          # Grid layout, cell views
├── Agents/         # Rule-based and ML-based AI
├── Services/       # Puzzle generation, saving, loading
├── Resources/      # Assets, puzzles, constants
├── Classifiers/    # CoreML model files, MLMoveClassifier
├── Resources/      # Assets, puzzles, constants
CyberdokuCLI/        # Command-line tool for training data generation
├── TrainingDataGenerator.swift
├── SudokuClassifier.mlproj
├── Puzzles/
├── TrainingData/
```

## 🧠 AI & Machine Learning

Cyberdoku explores hybrid agents for intelligent move suggestions:

- **Rule-Based Agent**: Uses strategies like Naked Single and Hidden Single
- **ML Classifier**: A CoreML model trained on labeled move data to identify strategies
- **Training Data**: Automatically generated from puzzles and classified moves
- **Create ML**: Used to train a lightweight on-device model for fast inference

Planned: OpenAI agent for broader reasoning and advanced strategy synthesis.

---

## ✅ TODO

- [x] Initialize Xcode SwiftUI project
- [x] Create `SudokuCell` model with notes and original flag
- [x] Set up GitHub repo and structure folders
- [x] Pick a name: **Cyberdoku**
- [x] Build `SudokuBoard` model with 9×9 access helpers
- [x] Create `SudokuBoardView` with SwiftUI grid
- [x] Implement serialization
- [x] Implement rule-based AI agent
- [x] Add CoreML agent interface
- [x] Add `TrainingDataGenerator` CLI to produce labeled data
- [x] Train and integrate CoreML model for move classification
- [x] Hook up hint button using rule-based and ML agents
- [ ] Add unit test for MLMoveClassifier
- [ ] Add test for SudokuBoard+Classifier.swift (allUnits())
- [ ] Improve training dataset coverage with advanced strategies
- [ ] Add OpenAI agent interface (experimental)
- [ ] Build ML-based strategy recommender using classifier output
- [ ] Improve classifier evaluation (cross-validation, metrics)
- [ ] Add UI feedback for AI vs human moves (e.g. highlighting)
- [ ] Add main menu, about, settings
- [ ] Add catalog of puzzles organized by difficulty
- [ ] Make the board a little cleaner
- [ ] clean up control interface
- [ ] Localize strings
- [ ] Add save/load logic to `Services/`
- [ ] Add pencil note mode toggle and cell highlighting
- [ ] Polish UI with animations and dark mode
- [ ] Add Game Center integration (optional)
- [ ] Review CLI folder structure before adding more commands
- [ ] Add puzzle generator?
- [ ] Add a training mode--let me capture a board and manually identify the strategy to use
 

---

## 🚀 Getting Started

```bash
git clone https://github.com/your-username/cyberdoku.git
open Cyberdoku/Cyberdoku.xcodeproj
```

Swift 5.9+ and Xcode 15+ recommended.

---

## 💡 Inspiration

This app is a blend of:
- The simplicity of classic Sudoku
- The declarative power of SwiftUI
- The creativity of AI-driven user assistance

---

Made with 🧠 + ❤️ in Swift

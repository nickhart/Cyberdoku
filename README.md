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
```

---

## ✅ TODO

- [x] Initialize Xcode SwiftUI project
- [x] Create `SudokuCell` model with notes and original flag
- [x] Set up GitHub repo and structure folders
- [x] Pick a name: **Cyberdoku**
- [x] Build `SudokuBoard` model with 9×9 access helpers
- [x] Create `SudokuBoardView` with SwiftUI grid
= [ ] Implement serialization
- [ ] Implement rule-based AI agent
- [ ] Add OpenAI/CoreML agent interface
- [ ] Wire up hint button
- [ ] Add save/load logic to `Services/`
- [ ] Add pencil note mode toggle and cell highlighting
- [ ] Polish UI with animations and dark mode
- [ ] Add Game Center integration (optional)

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

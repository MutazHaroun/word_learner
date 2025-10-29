# Word Learner - Flutter Project

## 📘 Overview
**Word Learner** is a simple educational Flutter mobile application designed to help users learn and memorize new words in a chosen language (e.g., English–Arabic).  
This project was developed as part of the **Advanced Mobile Applications Development** course (Final Project).

---

## 🎯 Features
- Add, edit, and delete vocabulary words.
- Store data locally using **SQLite**.
- Search bar to quickly find words or translations.
- Built-in **Quiz Mode** — test yourself with multiple-choice questions.
- Simple, clean user interface designed for mobile learning.
- Demonstrates Flutter concepts: navigation, state management, database usage, and UI design.

---

## 🧩 Project Structure
```
lib/
├─ main.dart                    # Entry point
├─ models/
│  └─ word.dart                 # Data model
├─ db/
│  └─ db_helper.dart            # SQLite database helper
└─ screens/
   ├─ word_list_screen.dart     # Word list + search + navigation to quiz
   ├─ add_edit_word_screen.dart # Add / Edit form
   └─ quiz_screen.dart          # Quiz mode screen
proposal/
└─ Project_Proposal.pdf         # Submitted project proposal
```

---

## ⚙️ Requirements
- Flutter SDK (v3.0 or above recommended)
- Android Studio or VS Code with Flutter/Dart plugins
- Android Emulator or physical Android device

---

## 🚀 How to Run the App
1. **Extract the project ZIP** to a local directory.
2. Open a terminal in the project folder:
   ```bash
   cd word_learner_project
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Start an emulator** or connect an Android device via USB.
5. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🧠 How to Use
1. On the main screen, tap **+** to add new vocabulary words (term + translation).
2. Use the **search bar** to find words easily.
3. Tap the **quiz icon 🧩** in the top-right corner to start the quiz (minimum 4 words required).
4. Answer multiple-choice questions to test your knowledge.
5. View your final score and retry if you want.

---

## 🧑‍💻 Developer Info
**Student Name:** Mutaz Haroun  
**Student ID:** 25405/2024  
**Lecturer:** Mr. Ignace Hakizimana  
**Course:** Advanced Mobile Applications Development  
**Institution:** (Add your university or college name if required)

---

## 💡 Notes
- The database is stored locally on the device.
- No internet connection is required.
- You can enhance the app by adding categories, audio pronunciation, or dark mode.

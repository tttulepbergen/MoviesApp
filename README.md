# 🎬 MoviesProject — Your Personal Movie Explorer App

MoviesProject is an elegant iOS app built with **Swift** that allows users to browse trending and searched movies, watch trailers via YouTube, and post reviews. The app seamlessly integrates **TMDb API**, **YouTube API**, and **Firebase Firestore** to provide real-time data and persistent user interaction.

---

### 🎥 Demo Video

<table>
  <tr>
    <td><a href="https://github.com/user-attachments/assets/87d1e74e-1ff0-4a9d-a290-eea8c6c45668"><img src="https://github.com/user-attachments/assets/87d1e74e-1ff0-4a9d-a290-eea8c6c45668" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/ee3ba0bb-7de0-441e-9104-c0cac9206b0a"><img src="https://github.com/user-attachments/assets/ee3ba0bb-7de0-441e-9104-c0cac9206b0a" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/5671049f-2d5b-4532-83be-99c69a896610"><img src="https://github.com/user-attachments/assets/5671049f-2d5b-4532-83be-99c69a896610" width="200"/></a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/user-attachments/assets/a97f5a1b-af63-43f8-b8eb-de55ea3710c4"><img src="https://github.com/user-attachments/assets/a97f5a1b-af63-43f8-b8eb-de55ea3710c4" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/6fa76664-89e6-4eb9-9e99-ee38c8cd7d33"><img src="https://github.com/user-attachments/assets/6fa76664-89e6-4eb9-9e99-ee38c8cd7d33" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/b9452aeb-7dc9-4ef5-8448-f5da20383f81"><img src="https://github.com/user-attachments/assets/b9452aeb-7dc9-4ef5-8448-f5da20383f81" width="200"/></a></td>
  </tr>
</table>

---

## 📱 Screenshots

### 🏠 Home View
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/2658f352-eec1-490d-b358-91ffd6db95f7" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/0a36dbf4-d2a3-42a5-8da9-aac4685f3359" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/6c864c9e-8015-4cbe-aa72-a1eefa0852f0" width="200"/></td>
  </tr>
</table>

### 🎬 Movie Detail View

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/893a3279-1ef4-4caa-9873-98b55e6c7294" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/78e8d319-f2ad-44bf-8bba-5a76b2e5d02e" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/dcc07d8b-6da8-43c7-8a41-24cb0e588f88" width="200"/></td>
  </tr>
</table>

### 📝 Reviews View

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/6bb98b4e-68e8-4738-97ed-917a6c4d5da4" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/955e45fe-d29e-4d0c-ade6-e78794458309" width="200"/></td>
  </tr>
</table>

### 🔎 Search View

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/2658f352-eec1-490d-b358-91ffd6db95f7" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/0a36dbf4-d2a3-42a5-8da9-aac4685f3359" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/6c864c9e-8015-4cbe-aa72-a1eefa0852f0" width="200"/></td>
  </tr>
</table>

### 🔐 Login View

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/a9c6f9e8-064d-4373-8ed3-e3283f583d18" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/9b3a6e87-1980-4bab-91e8-95cbd0dadc06" width="200"/></td>
  </tr>
</table>

---

## 🚀 Features Overview

| Feature                        | Description                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|
| 🔍 Search Movies              | Fetches movies via **TMDb API** using search queries                       |
| 🌟 Favorite Movies            | Add/remove favorite titles using `UserDefaults` for local persistence       |
| ▶️ Watch Trailers             | Embedded YouTube trailers using **YouTube Data API v3** and **WebKit**      |
| 📝 Add & View Reviews         | Store and display user reviews using **Firebase Firestore**                |
| 🔐 Authenticated Reviews      | Only the user who wrote the review can delete it (**Firebase Auth**)       |

---

## 🧱 App Architecture

The project follows the **MVVM** architecture pattern:

| Layer       | Responsibilities                                                                 |
|-------------|------------------------------------------------------------------------------------|
| `Model`     | Structures like `Title`, `Review`, `VideoElement`, conforming to `Codable`         |
| `ViewModel` | Handles business logic, API calls, and Firebase operations                         |
| `View`      | SwiftUI / UIKit views for displaying trending movies, details, reviews, etc.       |

---

# Project Members
| Full Name | ID | GitHub |
|-----------|----|--------|
| Suanbekova Aisha | 22B030589 | [Suanbekova](https://github.com/Sunbekova/) |
| Tulepbergen Anel | 22B030602| [Tulepbergen](https://github.com/tttulepbergen) |
| Stelmakh Polina | 22B030615 | [Stelmakh](https://github.com/po133na) |



# 🎬 MoviesProject — Your Personal Movie Explorer App

MoviesProject is an elegant iOS app built with **Swift** that allows users to browse trending and searched movies, watch trailers via YouTube, and post reviews. The app seamlessly integrates **TMDb API**, **YouTube API**, and **Firebase Firestore** to provide real-time data and persistent user interaction.

---

### 🎥 Demo Video

<table>
  <tr>
    <td><a href="https://github.com/user-attachments/assets/6ae59bf2-9f5c-485d-b05b-c988f10f4020"><img src="https://github.com/user-attachments/assets/b1864a55-6fe9-4745-9c7a-5d93c0397abc" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/cf90c9f5-6e77-4a83-85f5-1e8cd2c88941"><img src="https://github.com/user-attachments/assets/cd039053-cb3d-46f9-82d7-fa7dcdaee536" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/57dcf3cf-8131-4c62-ad31-ca33d313ab06"><img src="https://github.com/user-attachments/assets/8e8e2954-d257-4c20-b548-25da44506d14" width="200"/></a></td>
  </tr>
  <tr>
    <td><a href="https://github.com/user-attachments/assets/f68a6efd-d1dc-4404-bba5-76dcdfeed0b2"><img src="https://github.com/user-attachments/assets/f68a6efd-d1dc-4404-bba5-76dcdfeed0b2" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/26a9b2b8-b3cb-4037-90f3-7c89e1e08a4f"><img src="https://github.com/user-attachments/assets/26a9b2b8-b3cb-4037-90f3-7c89e1e08a4f" width="200"/></a></td>
    <td><a href="https://github.com/user-attachments/assets/51da7010-cd66-44a1-b2ff-1425b0c06a7d"><img src="https://github.com/user-attachments/assets/51da7010-cd66-44a1-b2ff-1425b0c06a7d" width="200"/></a></td>
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



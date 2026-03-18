# Cab Zing

A Flutter mobile application built for managing cab operations. The app connects to real backend APIs and lets users view their dashboard, manage invoices, and their profile — all in a clean dark-themed UI.

---

## What This App Does

This is basically a driver or fleet management app. After logging in, the user gets access to a dashboard that shows revenue info, status cards, and a bottom navigation bar with five sections:

- **Home (Dashboard)** – shows revenue chart and status overview
- **Invoices** – full invoice list with search and filter
- **Profile** – shows logged-in user info

---

## Screens

### Splash Screen
The first screen that shows up when you open the app. It checks if the user is already logged in (using stored token) and either sends them to the dashboard or the login screen.

### Login Screen
Simple login form with username and password. Has a nice glowing background effect. Also has a language selector at the top and a sign up option at the bottom (not fully wired yet).

### Dashboard Screen
Main home screen after login. Shows:
- User greeting with profile image
- Revenue card with a line chart
- Status cards (probably showing bookings or trip statuses)

### Invoices Screen
Lists all invoices fetched from the API. You can:
- Search by invoice number or customer name
- Filter by status, customer, or date range
- Pull to refresh the list

### Profile Screen
Shows the logged-in user's profile details like name, email, and profile image.

### Routes & Alerts Screens
These are placeholder screens that are part of the navigation but not fully built yet.

---

## Tech Stack


| Framework | Flutter |
| Language | Dart |
| State Management | Provider |
| HTTP Client | Dio |
| Secure Storage | flutter_secure_storage |
| Icons | font_awesome_flutter |
| Font | Poppins |
| Theme | Dark (custom) |

---

## Project Structure

```
lib/
├── core/
│   ├── constants/       # API URLs and asset paths
│   ├── services/        # Secure storage service
│   ├── theme/           # App colors and theme
│   └── widgets/         # Shared widgets
│
├── features/
│   ├── auth/            # Login, splash, auth provider & service
│   ├── dashboard/       # Dashboard screen with revenue chart & status cards
│   ├── invoices/        # Invoice listing, filtering, models, provider
│   ├── profile/         # Profile screen, model, provider, service
│   ├── alerts/          # Alerts screen (placeholder)
│   ├── routes/          # Routes screen (placeholder)
│   └── landing/         # Bottom navigation controller
│
└── main.dart            # App entry point, provider setup
```



## Dependencies

```yaml
provider: ^6.1.5
dio: ^5.9.2
flutter_secure_storage: ^10.0.0
font_awesome_flutter: ^11.0.0
cupertino_icons: ^1.0.8
```

---

## Notes

- The app uses a dark theme throughout — no light mode at the moment.
- Some screens like Routes and Alerts are still empty/placeholder.
- Token is saved securely and persists between sessions so users don't have to log in every time.
- The invoice filter supports filtering by multiple statuses, customers, and date range at the same time.

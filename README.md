# E-Commerce Flutter Application

A fully functional **e-commerce mobile app** built using **Flutter**, **BLoC state management**, and **Firebase**.  
The app allows users to **sign in/up**, browse products, manage categories, add products to the **cart**, and more.

---

## Features

- **User Authentication**
  - Sign up with email/password
  - Sign in and sign out
  - Firebase authentication integration
- **Product & Category Management**
  - Browse products by category
  - Add/view product categories
  - Search products
- **Cart Management**
  - Add products to cart
  - Remove products from cart
  - View total cart price
- **Wishlist (Optional)**
  - Add/remove products from wishlist
- **State Management**
  - Uses **BLoC** (Business Logic Component) for reactive state management
- **Future Backend Integration**
  - Will support MongoDB or other backend services for persistent storage


## Installation

### Prerequisites

- Flutter SDK (>=3.0)
- Dart SDK
- Android Studio / Xcode
- Firebase project setup (for authentication)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/yourusername/ecommerce-flutter-app.git
cd ecommerce-flutter-app

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase
# - Add `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) in the respective platform folder
# - Enable Email/Password Authentication in Firebase console

# 4. Run the app
flutter run

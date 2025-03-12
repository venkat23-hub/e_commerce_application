   # E-commerce Flutter Application

This is a Flutter-based e-commerce mobile application built using Firebase for user authentication, Firestore for data storage, and Firebase Storage for storing product images. The app allows users to sign up, log in, browse products, add items to the cart, and manage their profiles.

## Features

- **Product Listings**: Display products from Firestore with pagination and infinite scrolling.
- **Product Images**: Upload and display product images using Firebase Storage.
- **Shopping Cart**: Add and remove items from the cart.

## Technologies Used

- **Flutter**: The mobile framework used to develop this app.
- **State Management**: Provider (or Riverpod) for managing app state.
- **Dependencies**:
  - `cached_network_image`: For efficient image loading.
  - `fluttertoast`: For displaying toast messages.
  - `flutter_local_notifications`: For local push notifications.
  
## Setup Instructions

### 1. Clone the repository:

```bash
git clone https://github.com/your-username/ecommerceapp.git
cd ecommerceapp


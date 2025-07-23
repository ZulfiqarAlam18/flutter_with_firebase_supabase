# Flutter Firebase + Supabase Student Manager

A Flutter application that demonstrates hybrid cloud architecture using Firebase for authentication and Firestore for database operations, while utilizing Supabase for file storage.

## Features

- **Authentication**: Firebase Auth for user registration and login
- **Database**: Cloud Firestore for storing student data
- **Storage**: Supabase Storage for storing student images
- **CRUD Operations**: Complete Create, Read, Update, Delete functionality for students
- **Image Upload**: Image picker integration with Supabase storage

## Architecture

- **Firebase Services Used**:
  - Firebase Auth (Authentication)
  - Cloud Firestore (Database)
  
- **Supabase Services Used**:
  - Supabase Storage (File Storage)

## Setup Instructions

### 1. Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use existing one
3. Enable Authentication (Email/Password)
4. Enable Cloud Firestore
5. Download and add configuration files:
   - For Android: `google-services.json` in `android/app/`
   - For iOS: `GoogleService-Info.plist` in `ios/Runner/`

### 2. Supabase Setup

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Create a new project
3. Go to Storage and create a bucket named `student-images`
4. Make the bucket public (for image access)
5. Update the Supabase credentials in `lib/constants/supabase_key.dart`:

```dart
const String supabaseUrl = 'YOUR_SUPABASE_PROJECT_URL';
const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
```

### 3. Storage Bucket Configuration

In your Supabase dashboard:

1. Go to Storage → Buckets
2. Create a new bucket called `student-images`
3. Set the bucket to public
4. Add this policy for public read access:

```sql
CREATE POLICY "Public Access" ON storage.objects FOR SELECT USING (bucket_id = 'student-images');
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.4.0
  get: ^4.7.2
  flutter_svg: ^2.2.0
  flutter_screenutil: ^5.9.3
  google_fonts: ^6.2.1
  firebase_core: ^3.15.2
  firebase_auth: ^5.7.0
  cloud_firestore: ^5.6.12
  image_picker: ^1.1.2
  uuid: ^4.5.1
  supabase_flutter: ^2.9.1
  path: ^1.9.1
```

## Project Structure

```
lib/
├── constants/
│   └── supabase_key.dart          # Supabase configuration
├── controller/
│   ├── auth_controller.dart       # Firebase Auth logic
│   └── student_controller.dart    # Student CRUD operations
├── models/
│   └── student_model.dart         # Student data model
├── services/
│   └── storage_service.dart       # Supabase storage utilities
├── views/
│   ├── auth/
│   │   ├── login.dart            # Login screen
│   │   └── signup.dart           # Registration screen
│   ├── home_screen/
│   │   └── home_page.dart        # Main navigation screen
│   └── student_screens/
│       ├── add.dart              # Add student screen
│       ├── view.dart             # View all students
│       ├── update.dart           # Update student screen
│       └── delete.dart           # Delete student screen
├── firebase_options.dart          # Firebase configuration
└── main.dart                     # App entry point
```

## Key Features Implementation

### Image Upload to Supabase
- Images are uploaded to Supabase Storage bucket `student-images`
- Each image is stored with a unique filename based on student ID
- Public URLs are generated for image access

### Firebase Authentication
- Email/password authentication
- Automatic navigation based on auth state
- Secure logout functionality

### Firestore Database
- Real-time student data synchronization
- Efficient CRUD operations
- Stream-based data listening

## Usage

1. **Clone the repository**
2. **Setup Firebase and Supabase** as described above
3. **Run the app**:
   ```bash
   flutter pub get
   flutter run
   ```

## Error Handling

The app includes comprehensive error handling for:
- Network connectivity issues
- Authentication errors
- File upload failures
- Database operation errors
- Image loading failures

## Security Considerations

- Supabase credentials are kept in a separate constants file
- Firebase security rules should be configured appropriately
- Image access is through public URLs (consider signed URLs for sensitive content)

## Why This Hybrid Approach?

- **Cost Optimization**: Firebase Storage can be expensive; Supabase offers more affordable storage
- **Feature Leverage**: Firebase Auth and Firestore are mature and reliable
- **Flexibility**: Demonstrates how to integrate multiple cloud providers
- **Learning**: Shows practical implementation of hybrid cloud architecture

## Troubleshooting

### Common Issues:
1. **Image upload fails**: Check Supabase bucket permissions and credentials
2. **Auth not working**: Verify Firebase configuration files
3. **Firestore errors**: Check Firebase project settings and rules
4. **Image not displaying**: Verify bucket is public and URLs are correct

### Debug Tips:
- Check Flutter debug console for error messages
- Verify internet connectivity
- Ensure all required permissions are granted
- Check Supabase and Firebase dashboard logs

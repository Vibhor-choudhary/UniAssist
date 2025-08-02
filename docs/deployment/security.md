# Security Guidelines for UniAssist

## Overview

This document outlines security best practices and guidelines for the UniAssist project.

## Environment Configuration

### API Keys and Secrets

1. **Never commit sensitive data** to version control
2. Use `env.json.example` as a template for configuration
3. Keep your actual `env.json` file in `.gitignore`
4. Rotate API keys regularly

### Firebase Security Rules

```javascript
// Example Firebase security rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Public data can be read by anyone
    match /public/{document=**} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### Supabase Security

1. Enable Row Level Security (RLS) on all tables
2. Create appropriate policies for data access
3. Use service roles only for server-side operations

## Data Privacy

1. **Privacy-First Approach**: No data leaves the device without explicit user consent
2. **Local Storage**: Sensitive data should be stored locally when possible
3. **Data Minimization**: Only collect data that is absolutely necessary
4. **User Control**: Users should have full control over their data

## Code Security

1. **Input Validation**: Always validate user inputs
2. **Error Handling**: Don't expose sensitive information in error messages
3. **Dependencies**: Regularly update dependencies to patch security vulnerabilities
4. **Code Review**: All code changes should be reviewed for security issues

## Reporting Security Issues

If you discover a security vulnerability, please report it privately to the maintainers rather than creating a public issue.

## Compliance

This project aims to comply with:
- GDPR (General Data Protection Regulation)
- FERPA (Family Educational Rights and Privacy Act)
- Local privacy laws and regulations 
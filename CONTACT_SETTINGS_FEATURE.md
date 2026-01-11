# Contact Settings Feature

## What's New

### 1. Editable Contact Information
- Email, Phone, and Location can now be edited from the Admin Portal
- Changes are saved to Firestore and reflect immediately on the website

### 2. Admin Panel Access
1. **Desktop**: Triple-tap the "K Krishana" logo in the header to access the Admin Portal
2. **Mobile**: Triple-tap the "K" in the drawer to access the Admin Portal
3. Navigate to "Contact Settings" tab in the Admin Portal

### 3. Copyright Notice
Added "© 2026 Krishana Kumar Yadav. All rights reserved." at the bottom of:
- Contact Me section
- Social Links section

## How to Update Contact Information

1. Access the Admin Portal (triple-tap logo)
2. Click on "Contact Settings" tab (gear icon)
3. Update Email, Phone, or Location
4. Click "Save Changes"
5. The changes will appear on the website immediately

## Default Values
- **Email**: ky39018@gmail.com
- **Phone**: +977 981-4777485
- **Location**: Dharan, Nepal

## Files Created/Modified

### New Files:
- `lib/data/models/contact_settings.dart` - Model for contact settings
- `lib/data/services/contact_settings_service.dart` - Service to manage settings
- `lib/ui/admin/contact_settings_admin.dart` - Admin UI for editing settings

### Modified Files:
- `lib/service_locator.dart` - Registered ContactSettingsService
- `lib/ui/admin/admin_portal.dart` - Added Contact Settings tab
- `lib/ui/contact/contact_me.dart` - Reads settings from Firestore, added copyright
- `lib/ui/contact/social_links_section.dart` - Added copyright text

## Firestore Structure

```
settings/
  └── contact/
      ├── email: string
      ├── phone: string
      ├── location: string
      └── lastUpdated: timestamp
```

## Notes
- If Firestore is not available, default values will be used
- Contact settings are cached and updated in real-time
- All changes are tracked with timestamps

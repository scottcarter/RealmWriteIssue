# About

This project has been created to demonstrate a possible bug when using realm.write(withoutNotifying:)

When providing a valid NotificationToken in an array for the withoutNotifying argument, an occasional notification is still being received.

# Environment

Xcode: 12.0.1

Realm: 5.4.8

macOS: 10.15.6

Dependency manager:  SPM


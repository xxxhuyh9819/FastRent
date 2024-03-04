# FastRent
This is an iOS App for quickly finding apartments available for rent. Users can browse available apartments, filter apartments on various conditions,  save/unsave apartments interested in the Wishlist, and see apartment locations in a map view. Firebase is used for remote data storage, and UserDefaults are used for local data persistence (wish list).

### Features

- Built with the MVVM (Model-View-ViewModel) design pattern to separate UI, data, and logic.
- Using asynchronous network calls (iOS 15+) (async await) to fetch remote data.
- Extensive coverage of reusable components and custom modifiers (buttons, steppers, image carousel, etc) for cleaner code and UI aesthetics.
- Created structural logging massages using OSLog
- Advanced filtering with multiple conditions (city, price range, and number of beds & baths).
- Dark-mode compatible

### What I learned

- Enhanced understanding of SwiftUI basics (@StateObject, @EnvironmentObject, @Binding, etc.)
- Developed a good habit of creating structural logging messages 
- Practiced creating customized components for better user experience
- Obtained on-hands experience with async networking, map views, etc.

### References

Developer forums and blogs are my good friends when developing, especially when encountering issues. Some sources of reference include:

- Apple Developer Forums
- StackOverflow
- Hacking With Swift

### TODO

I will keep working on this project in the future, and here are some features I plan to implement:

- Compare two apartments in the wishlist

- A custom tabview with smooth animation 

	And more...

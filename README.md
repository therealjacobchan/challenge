# Challenge

## Overview

This project is an iOS application written in Swift that is implemented using MVVM architecture. Minimal libraries have been used in the application, except the use of [TagListView](https://github.com/ElaWorkshop/TagListView)

## Features

- Generic UICollectionView management for recap and multiple choice type questions
- Progress bar integration and computation
- API fetching using URLSession class

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Xcode:** Make sure XCode is installed on your system. You can download it from [The App Store](https://apps.apple.com/us/app/xcode/id497799835).

## Installation

To install the project, follow these steps:

1. **Clone the repository to your local machine:**

   ```bash
   git clone https://github.com/therealjacobchan/challenge.git
   ```

   Alternatively, if repo file for this project has been provided, you may also perform the following:

   ```bash
   git clone challenge.bundle
   ```

2. **Navigate to the project directory**

   ```bash
   cd challenge
   ```

3. **Fetch the Pod libraries**
   ```bash
   pod install
   ```

## Architecture Decisions

The application demonstrates several implementations of certain decisions on architecture design, such as pagination with UICollectionView, the use of MVVM, and API fetching using URLSession. Generics were also highly used throughout the code base, in the attempt for long-term development and expansion of other possible features. 

## Challenges Encountered

During the development of the project, one challenge was related to the UX. The app will not necessarily work with smaller screens of the iPhone. One possible solution to overcome this issue is to use a ScrollView. However, it was not exactly iterated where to put the scroll view for each item in the list. One alternative that was developed is to make the fonts a little bit smaller to be able to accommodate smaller devices. Perhaps this is still open for discussion as to where to implement this change.

Another challenge faced during development was the implementation of the network class. Theoretically, the app should work, even using a JSON file. However, it seemed beter to implement a network class, which would be genericized as much as possible to accomodate other possible API calls in the future. This part of the code base can be refactored further by properly refactoring error handling behaviors. This will require an alert to be able to smoothly execute the change.

## Points for improvement

The code base is not yet as robust as it should've been. Some proposed improvement plans in the future include:
- Increased use of constants for both UI and text elements
- Diversification among different flavors (Debug, Staging, Release)
- Implementing generics for the UICollectionViewCell to be able to extend to other types of questions
- Implementing drag and drop feature for answering the recap type question
- Implementing scrolling feature in each text for easier readability (UI must be readily available to help user know that the text is scrollable)

## Contact

If you have any questions or feedback, please reach out to me at jacobchan_19@yahoo.com

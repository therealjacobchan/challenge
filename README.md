# Stasher

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
   git clone https://github.com/therealjacobchan/stasher.git
   ```

2. **Navigate to the project directory**

   ```bash
   cd stasher
   ```

3. **Fetch the Pod libraries**
   ```bash
   pod install
   ```

## Usage

The application demonstrates architecture design, pagination with UICollectionView, the use of MVVM, and data fetching. Generics were also highly used throughout the code base, in the attempt for long-term development and expansion of other possible features.

## Points for improvement

The code base is not yet as robust as it should've been. Some proposed improvement plans in the future include:
- Increased use of constants for both UI and text elements
- Diversification among different flavors (Debug, Staging, Release)
- Implementing generics for the UICollectionViewCell to be able to extend to other types of questions
- Implementing drag and drop feature for answering the recap type question

## Contact

If you have any questions or feedback, please reach out to me at jacobchan_19@yahoo.com

# 📸 capture-screenshot-Visualforce

This Visualforce page is designed for capturing and managing screenshots within Salesforce. It provides functionality to capture screenshots, save them, and manage them, including features such as displaying, renaming, downloading, and deleting screenshots.

## 📋 Overview
- **Controller**: `captureScreenController`
- **Purpose**: To capture and manage screenshots related to Salesforce Cases.

## ✨ Key Features

1. **🖼️ Capture Screenshots**: The page allows users to capture screenshots of their display. It uses the `navigator.mediaDevices.getDisplayMedia` API to access the display media.

2. **💾 Save and Manage Screenshots**: Once a screenshot is captured, it can be saved, renamed, downloaded, or deleted. The page interacts with Salesforce using Visualforce remoting to perform these actions.

3. **🎨 User Interface**: The page uses Salesforce Lightning Design System (SLDS) for styling and includes a spinner for loading states and various UI elements for user interaction.

## ⚠️ Important Note

This implementation is a prototype and is not production-ready. It serves as a foundational example and requires further refinement and testing before being deployed in a live environment. Users should review and adjust the code to meet their specific requirements and ensure it adheres to best practices and security standards.

## 🎥 Demonstration

![Functionality Demonstration](/chrome_1mnuarrPF2.gif)

## 🛠️ JavaScript Functions

- **📹 startCapture**: Initiates the screen capture process. It checks if the current record is a Case and then starts capturing the display media. Screenshots are taken when the user stops sharing their screen.

- **📤 captureScreenFn**: Sends the captured screenshot to the server using Visualforce remoting. It encodes the image in base64 format before sending.

- **✏️ keepFile**: Renames and saves the captured screenshot if the user has changed the default name.

- **⬇️ downloadImg**: Allows the user to download the captured screenshot.

- **🗑️ deleteFile**: Deletes the captured screenshot from the server.

## 🖥️ UI Components

- **🔄 Spinner**: Displays a loading spinner while the page is processing actions.
- **🏁 Start Page**: The initial UI displayed to the user, prompting them to start the screen capture process.
- **🖼️ Image Card**: Displays the captured screenshot and provides options to rename, download, or delete the image.

## 🚀 Usage

The page expects a Case ID as a URL parameter. It is designed to be used on the record page of a Case. If the page is accessed without a valid Case ID, a warning message is displayed.

## 📝 Notes

- The page uses SLDS for consistent styling with Salesforce's Lightning Experience.
- The screenshot capture functionality is dependent on the browser's support for the `getDisplayMedia` API.
- The page includes error handling to manage exceptions during the capture and management processes.
- Some of the UI text and labels are currently in Italian. Future updates may include translations into English for a more consistent experience across different regions.

This page is a powerful tool for users who need to capture and manage screenshots directly within Salesforce, enhancing productivity and record-keeping.
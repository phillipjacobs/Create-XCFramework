# Create-XCFramework
A short guide on how to create a XCFramework to then use it in your Xcode projects.

#### What Is an XCFramework?

The XCFramework format allows developers to conveniently distribute binary libraries for multiple platforms and architectures in a single bundle. For example, with XCFrameworks, vendors no longer need to merge (lipo) multiple architectures into a single binary, only to later have to remove the Simulator slice during the archive phase.

XCFrameworks require Xcode 11 or later and they can be integrated similarly to how we’re used to integrating the .framework format.

## Getting Started
```
These instructions will help you generate a .xcframework
```

## Prerequisites

What things are needed to generate a .xcframework 😞

* Nothing fancy ... Just Xcode 🥳


## Download and Run The Script 
* ###### (To rather perform each command manually, see '[Step By Step](https://github.com/phillipjacobs/Create-XCFramework#step-by-step)')

Here's how to download and run the script 🤓

#### 1.Clone / Download this repo.
```
Why?
    • Because inside the repo there's a create-xcframework.sh file that you need.
```
---

#### 2. Move the `create-xcframework.sh` file to the root of your project.
```
What do I mean by the root of your project ? 
    • The same folder as the folder your .xcodeproj is in.
```
---

#### 3. Don't run the `create-xcframework.sh` file yet!
```
Why?
    • We first need to edit it so that it knows what your framework's name is.
```
---

#### 4. Edit the `create-xcframework.sh` file
###### This next step is super important. Lol, ever step is important but just read this one carefully.

* ##### Change the value of `FRAMEWORK_NAME` to your framework's name.
* ##### If you use pods in your framework:
    * ##### Change the value of `FRAMEWORK_TYPE` to "workspace"
    * ##### Change the value of `FRAMEWORK_EXTENSION` to "xcworkspace"
    * ##### If you don't have a .xcworkspace in your folder structure, then you're probably 
       ##### not using any pods. So then don't change `FRAMEWORK_TYPE` and `FRAMEWORK_EXTENSION`.
* ##### If your scheme name is not the same as your framework's name:
    * ##### Change the value of `SCHEME_NAME` to match your scheme's name.
* ##### If you have more than one scheme:
    * ##### Change the value of `SCHEME_NAME` to match your desired scheme's name.
* ##### If you don't know what a scheme is, just leave `SCHEME_NAME` as it is.

---

##### 5. The `create-xcframework.sh` file is now tailored specifically to your framework. Let's run it.

Open your terminal, make sure you're in the root of your project (where you placed the `create-xcframework.sh` file) and run this command:
```sh
sh create-xcframework.sh
```
You can also run it with the following command:
```sh
chmod 755 create-xcframework.sh && ./create-xcframework.sh
```
---

##### 6. Your .xcframework will be located at ./archive/xcframework/
```
....unless of course you changed the path variables in the create-xcframework.sh file 🤨 
```

### Step By Step
* ###### (To rather do all this automatically by running the script, see '[Download and Run The Script](https://github.com/phillipjacobs/Create-XCFramework#download-and-run-the-script)')


Here's how to run each command in your terminal manually 🤓

#### 1. Open terminal & navigate to the root of your project

```
What do I mean by the root of your project ? 
    • The same folder as the folder your .xcodeproj is in.
```
---
We’ll be archiving for the iOS device, Simulator, and Mac Catalyst architectures.
If you don't want one of these architectures supported by your xcframework, then just skip the step where we archive for that architecture.

Please refer to [Download and Run The Script](https://github.com/phillipjacobs/Create-XCFramework#download-and-run-the-script)') if you want to see how to change from a `workspace` to a `project`.

Change `MySexyFramework` to the name of your framework
#### 2. Run this command in your terminal to archive for the `iOS device architecture`.
```swift
xcodebuild archive -workspace 'MySexyFramework.xcworkspace' \
-scheme 'MySexyFramework.framework' \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath './archives/MySexyFramework.framework-iphoneos.xcarchive' SKIP_INSTALL=NO
```
---

Change `MySexyFramework` to the name of your framework
#### 3. Run this command in your terminal to archive for the `Simulator device architecture`.
```swift
xcodebuild archive -workspace 'MySexyFramework.xcworkspace' \
-scheme 'MySexyFramework.framework' \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath './archives/MySexyFramework.framework-iphonesimulator.xcarchive' SKIP_INSTALL=NO
```
---

Change `MySexyFramework` to the name of your framework. Skip this step if you're not building Mac applications with this framework.
#### 4. Run this command in your terminal to archive for the `Mac Catalyst architecture`.
```swift
xcodebuild archive -workspace 'MySexyFramework.xcworkspace' \
-scheme 'MySexyFramework.framework' \
-configuration Release \
-destination 'platform=macOS,arch=x86_64,variant=Mac Catalyst' \
-archivePath './archives/MySexyFramework.framework-catalyst.xcarchive' SKIP_INSTALL=NO
```
---

Change `MySexyFramework` to the name of your framework.

Include this line to the below command if you are building Mac applications with this framework.
`-framework './archives/MySexyFramework.framework-catalyst.xcarchive/Products/Library/Frameworks/MySexyFramework.framework' \`

#### 5. Now let's create your `XCFramework`
```swift
xcodebuild -create-xcframework \
-framework './archives/MySexyFramework.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/MySexyFramework.framework' \
-framework './archives/MySexyFramework.framework-iphoneos.xcarchive/Products/Library/Frameworks/MySexyFramework.framework' \
-output './archive/xcframework/MySexyFramework.xcframework'
```
---

##### 6. Your .xcframework will be located at ./archive/xcframework/
```
....unless of course you changed the path variables in the create-xcframework.sh file 🤨 
```
---

## PLEEEEAAASE....
* Read up a bit more on xcframeworks
* Be cool and email me if you're really stuck `phillip@softwarebureau.org` 
* Be even cooler and google a lot! Learn! Knowledge is some sexy stuff!!


## Authors
* **Phillip Ronald Jacobs** - [LinkedIn](https://www.linkedin.com/in/phillip-jacobs)

## License
This project is licensed under the **GoWildAndShare** License...hahaha!

## Acknowledgments

* Thank You Apple Docs
* Thank You Google
* Thank You Youtube
* Thank You StackOverflow
* Thank You WeThinkCode_
* Thank You Me
* Thank You Granny, Thank You Grandpa... OuwkkyY this is getting weird & emotional. Good luck lol.
* And I really don't mind helping when you have a problem but try and google first.

* Thank Youuu... byeeee!

#! /bin/bash

FRAMEWORK_NAME="MySexyFramework"
FRAMEWORK_TYPE="project" # project or workspace
FRAMEWORK_EXTENSION="xcodeproj" # xcodeproj or xcworkspace

SCHEME_NAME="$FRAMEWORK_NAME"

ARCHIVE_PATH="./archives"
ARCHIVE_FRAMEWORK_PATH="Products/Library/Frameworks/$FRAMEWORK_NAME.framework"
PHYSICAL_DEVICES_ARCHIVE_PATH="$ARCHIVE_PATH/$FRAMEWORK_NAME.framework-iphoneos.xcarchive"
SIMULATED_DEVICES_ARCHIVE_PATH="$ARCHIVE_PATH/$FRAMEWORK_NAME.framework-iphonesimulator.xcarchive"
MAC_CATALYST_ARCHIVE_PATH="$ARCHIVE_PATH/$FRAMEWORK_NAME.framework-catalyst.xcarchive"

XCFRAMEWORK_OUTPUT_PATH="$ARCHIVE_PATH/xcframework"

restart() {
    clear && rm -rvf $ARCHIVE_PATH; mkdir $ARCHIVE_PATH
    echo "• [Restarted] - Success! •"
}

sliceForPhysicalDevices() {
    xcodebuild archive -$FRAMEWORK_TYPE "$FRAMEWORK_NAME.$FRAMEWORK_EXTENSION" \
    -scheme $SCHEME_NAME \
    -configuration Release \
    -destination 'generic/platform=iOS' \
    -archivePath $PHYSICAL_DEVICES_ARCHIVE_PATH SKIP_INSTALL=NO && \
    echo "• [Sliced] {Physical Devices} - Success! •"
}

sliceForSimulatedDevices() {
    xcodebuild archive -$FRAMEWORK_TYPE "$FRAMEWORK_NAME.$FRAMEWORK_EXTENSION" \
    -scheme $SCHEME_NAME \
    -configuration Release \
    -destination 'generic/platform=iOS Simulator' \
    -archivePath $SIMULATED_DEVICES_ARCHIVE_PATH SKIP_INSTALL=NO && \
    echo "• [Sliced] {Simulated Devices} - Success! •"
}

sliceForMacCatalyst() {
    xcodebuild archive -$FRAMEWORK_TYPE "$FRAMEWORK_NAME.$FRAMEWORK_EXTENSION" \
    -scheme $SCHEME_NAME \
    -configuration Release \
    -destination 'platform=macOS,arch=x86_64,variant=Mac Catalyst' \
    -archivePath $MAC_CATALYST_ARCHIVE_PATH SKIP_INSTALL=NO && \
    echo "• [Sliced] {Mac Catalyst} - Success! •"
}

createXCFrameworkExcludingAMacCatalystSlice() {
    sliceForPhysicalDevices && \
    sliceForSimulatedDevices && \
    xcodebuild -create-xcframework \
    -framework "$PHYSICAL_DEVICES_ARCHIVE_PATH/$ARCHIVE_FRAMEWORK_PATH" \
    -framework "$SIMULATED_DEVICES_ARCHIVE_PATH/$ARCHIVE_FRAMEWORK_PATH" \
    -output "$XCFRAMEWORK_OUTPUT_PATH/$FRAMEWORK_NAME.xcframework" && \
    echo "• [XCFramework] {Created} - Success! •" && ls $XCFRAMEWORK_OUTPUT_PATH
}

createXCFrameworkIncludingAMacCatalystSlice() {

    sliceForPhysicalDevices && \
    sliceForSimulatedDevices && \
    sliceForMacCatalyst && \

    xcodebuild -create-xcframework \
    -framework "$PHYSICAL_DEVICES_ARCHIVE_PATH/$ARCHIVE_FRAMEWORK_PATH" \
    -framework "$SIMULATED_DEVICES_ARCHIVE_PATH/$ARCHIVE_FRAMEWORK_PATH" \
    -framework "$MAC_CATALYST_ARCHIVE_PATH/$ARCHIVE_FRAMEWORK_PATH" \
    -output "$XCFRAMEWORK_OUTPUT_PATH/$FRAMEWORK_NAME.xcframework" && \
    echo "• [XCFramework] {Created} - Success! •" && ls $XCFRAMEWORK_OUTPUT_PATH
}

buildExcludingMacCatalystSlice() {
    restart && \
    createXCFrameworkExcludingAMacCatalystSlice && \
    sleep 2 && clear && \
    echo "• [XCFramework] {Creation} - Completed! •" && echo "XCFramework Can Be Located At: $XCFRAMEWORK_OUTPUT_PATH": `ls $XCFRAMEWORK_OUTPUT_PATH` 
}

buildIncludingMacCatalystSlice() {
    restart && \
    createXCFrameworkIncludingAMacCatalystSlice && \
    sleep 2 && clear && \
    echo "• [XCFramework] {Creation} - Completed! •" && echo "XCFramework Can Be Located At: $XCFRAMEWORK_OUTPUT_PATH": `ls $XCFRAMEWORK_OUTPUT_PATH` 
}

buildExcludingMacCatalystSlice # Comment out this line and uncomment the line below if you want to make your framework compatible with Mac Catalyst 

# buildIncludingMacCatalystSlice # Uncomment this line and comment out the one above if you want to make your framework compatible with Mac Catalyst 
## BUT REMEMBER: Your framework has to support mac. You can do so by clicking on the mac in your project settings like you did for iPhone and iPad.

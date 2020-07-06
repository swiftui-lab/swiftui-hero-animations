[![MIT License](https://img.shields.io/github/license/ApolloZhu/swift_qrcodejs.svg)](./LICENSE) [![Swift 5.3](https://img.shields.io/badge/Swift-5.3-green.svg)](https://swift.org) [![iOS 14.0](https://img.shields.io/badge/iOS-14.0-green)](https://developer.apple.com)

# Description
This project demonstrates how to use the new SwiftUI `.matchedGeometryEffect()` modifier to create a hero animation.

# More Information

This project is part of the two-part article ["MatchedGeometryEffect - Part 1 (Transitions)"](https://swiftui-lab.com/matchedGeometryEffect-part1), which describes the concepts needed to create a transition that not only moves a view from the location and size of another, but also provides a way of morphing it in a way, so it seems the outgoing view **"becomes"** the incoming view.

# Requirements

This project needs to run with iOS 14.0.

It has been tested on an iPad 9.7" running at full screen. However, the code is designed to easily adapt to any window size. You simply need to set the right values in the HeroConfiguration variable. In fact, the code does that already when the device is rotated. The HeroConfiguration is different for each orientation.

TODO: In a future update, I will make it adapt to any window size, no matter which device it is running on.

# How to Use the Project

This app demonstrates how to create hero animations and you can interact with them. But you can also change its parameters. You can open the configuration popover from two places:

* Toolbar item at the top right corner.
* When the modal is opened, double tap on it.

Also note that these parameters can be set separately for each orientation. Rotating the device will transition from one configuration to the other.

You can also use the **Slow Animations** switch to make all animations super slow. This will let you debug and customize all the other parameters much better.

# Source Code

To better navigate the project, here is a list of all the source code files, together with a quick description.

#### SwiftUI Views

### `ContentView.swift`
At the top of the hierarchy, the ContentView just creates the HeroView and passes the data to display.

### `HeroView.swift`
This is the main file of the project where all is assembled together. It is basically a large `ZStack`with three layers: 

* **Layer 1**, `zIndex = 1`: At the lowest layer, there's a `LazyVGrid` embedded inside a `NavigationView`.
* **Layer 2**, `zIndex = 2`: In the middle layer, there is a backdrop that blurs the first layer when there is modal present.
* **Layer 3**, `zIndex = 3`: When there is a grid item selected, this top layer displays the modal that presents the data.

The thumbnail displayed in the grid (layer 1), is transitioned to the modal's image. This is accomplished by "linking" both views together using `.matchedGeometryEffect()`.

### `Thumbnail.swift`
This view shows a picture, and makes sure it always fills the thumbnail size specified in the `HeroConfiguration`. It also supports zooming the image but always keeps the right geometry by cropping appropriately.

### `ModalView.swift`
A view used as a modal. It reacts to the environment key `.modalTransitionPercent`, in order to determine how much flight it has done. This allows it to morph from the thumbnail picture into its full display.

During transition, the following properties are adjusted from the values in the thumbnail to the final look of the modal:

* Size.
* Position.
* Corner radius.
* Text size.
* Cropping.

### `VisualEffectView.swift`
A view used to blur the grid, using a `UIViewRepresentable` of UIKit's U`IVisualEffect`

### `TitleView.swift`
A view used to display the title of the item, with a semi-transparent gradient as the background to improve text readability.

### `ConfigPopup.swift`

A view used on a popover. It presents a `Form` to change the `HeroConfiguration` data, to alter display and test customizations.

The popover can be presented from two places. Using the toolbar icon at the top right, or if the modal is presented, by double-tapping on it.

<hr>

#### Extensions

### `EnvironmentValues.swift`
Defines to environment keys:

|EnvironmentKey name|Description|
|-------------------|-----------|
|`\.heroConfig`|Use this key to pass around the hero configuration.|
|`\.modalTransitionPercent`|Used during the transition by the modal, so it knows how much of the transition has passed in order to properly adapt from the thumbnail look to the modal look.|

### `Transitions.swift`

Creates two transitions:

|Transition name|Description|
|---------------|-----------|
|`modal`|Sets the `.modalTransitionPercent` environment key to the percentage of the transition progress. Used by the modal to progressively transform from the thumbnail to the modal.|
|`invisible`|This transition will cause the view to disappear, until the last frame of the animation is reached|

### `Animations.swift`
Provides a name for the animations used in the project so they are centralized and consistent in one place:

|Animation static variable|Description|
|-------------------|-----------|
|`hero`|The animation used to fly the view from thumbnail to modal, and vice-versa.|
|`resetConfig`|The animation used when the popover is used to restore the original settings.|
|`blur`|The animation used to blur and unblur the grid.|
|`debug`|A very slow animation, to see animations in slow motion. Useful for debugging.|
<hr>

#### Data Types

### `HeroConfiguration.swift`
This data type provides all the different aspects of both the grid and the modal:

| Parameter         |Description|
|-------------------|-----------|
|`verticalSeparation`|Points separating rows in the grid.|
|`horizontalSeparation`|Points separating columns in the grid.|
|`thumbnailSize`|Thumbnail's size.|
|`thumbnailRadius`|Thumbnail's corner radius.|
|`modalSize`|The total size of the modal.|
|`modalImageHeight`|Height of the modal's image. The image width will always be equal to the width of the modal.|
|`modalRadius`|Modal's corner radius.|
|`darkMode`|A boolean indicating if the scheme should be forced to dark or light style.|
|`aspectRatio`|The aspect ratio of the images in the asset catalog. Ideally they should all have the same aspect ratio, although they can be different in size).|
|`thumbnailScalingFactor`|How much zoom done on the thumbnail image.|

The project is using 600x400 images, that is a 3:2 aspect ratio. At the top of the file, you can change the default aspect ratio, using the `sourceImagesSize`. The size does not need to be the one from the images, just a width and height that matches the ratio of your images. It is perfectly valid to set it to:

```swift
var sourceImagesSize = CGSize(width: 3, height: 2)
```

instead of

```swift
var sourceImagesSize = CGSize(width: 600, height: 400)
````

### `MealData.swift`
Provides the text and image names.


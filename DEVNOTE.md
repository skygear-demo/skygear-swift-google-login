## Use other version of Skygear SDK with git

Change pod file SKYKit from

```
  pod 'SKYKit'
```

```
    pod 'SKYKit', :git => 'https://github.com/SkygearIO/skygear-SDK-iOS.git', :branch => 'master'
```

and run `pod install` again

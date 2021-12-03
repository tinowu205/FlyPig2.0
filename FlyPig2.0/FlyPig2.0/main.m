//
//  main.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Ports.h"
int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

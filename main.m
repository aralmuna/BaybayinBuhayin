//
//  main.m
//  BaybayinBuhayin
//
//  Created by Paul Michael Laborte on 10/7/10.
//  Copyright AralMuna.Me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaybayinBuhayinAppDelegate.h"

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([BaybayinBuhayinAppDelegate class]));
    [pool release];
    return retVal;
}

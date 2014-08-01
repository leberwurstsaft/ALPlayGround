//
//  ALPUtilities.m
//  ALPlayGround
//
//  Created by Dubiel, Thomas on 01.08.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import "ALPUtilities.h"

@implementation ALPUtilities

+(NSString *)getSizeClassDescription:(UIUserInterfaceSizeClass)sizeClass {
    switch (sizeClass) {
        case UIUserInterfaceSizeClassUnspecified:
            return @"Any";
            break;
            
        case UIUserInterfaceSizeClassRegular:
            return @"Regular";
            break;
            
        case UIUserInterfaceSizeClassCompact:
            return @"Compact";
            break;
            
        default:
            break;
    }
}

+(NSString *)getInterfaceIdiomDescription:(UIUserInterfaceIdiom)idiom {
    switch (idiom) {
        case UIUserInterfaceIdiomUnspecified:
            return @"Unspecified";
            break;
        
        case UIUserInterfaceIdiomPhone:
            return @"Phone";
            break;
            
        case UIUserInterfaceIdiomPad:
            return @"Pad";
            break;
            
        default:
            break;
    }
}

+(void)logTraitCollection:(UITraitCollection *)traitCollection {
    NSLog(@"Horizontal Size Class: %@", [self getSizeClassDescription:traitCollection.horizontalSizeClass]);
    NSLog(@"Vertical Size Class  : %@", [self getSizeClassDescription:traitCollection.verticalSizeClass]);
    NSLog(@"User Interface Idiom : %@", [self getInterfaceIdiomDescription:traitCollection.userInterfaceIdiom]);
    NSLog(@"Display Scale Factor : %f,", traitCollection.displayScale);
}

@end

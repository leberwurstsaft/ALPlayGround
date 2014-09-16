//
//  ALPUtilities.h
//  ALPlayGround
//
//  Created by Dubiel, Thomas on 01.08.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALPUtilities : NSObject

+(NSString *)getSizeClassDescription:(UIUserInterfaceSizeClass)sizeClass;
+(NSString *)getInterfaceIdiomDescription:(UIUserInterfaceIdiom)idiom;
+(void)logTraitCollection:(UITraitCollection *)traitCollection;

@end

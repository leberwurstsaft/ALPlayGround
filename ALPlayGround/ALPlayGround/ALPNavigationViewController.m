//
//  ALPNavigationViewController.m
//  ALPlayGround
//
//  Created by Dubiel, Thomas on 01.08.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import "ALPNavigationViewController.h"

@interface ALPNavigationViewController ()

@end

@implementation ALPNavigationViewController

-(NSUInteger)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

@end

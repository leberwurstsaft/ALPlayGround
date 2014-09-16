//
//  ALPViewController.m
//  ALPlayGround
//
//  Created by Pit Garbe on 10.01.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import "ALPViewController.h"

@interface ALPViewController ()

@end

@implementation ALPViewController

#pragma mark - Old Methods

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // initial set the trait collection for current interface orientation
    [self setTraitCollectionForSize:self.view.frame.size];
}

#pragma mark - New Methods

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    NSLog(@"Previous Trait Collection:");
    [ALPUtilities logTraitCollection:previousTraitCollection];
          
    NSLog(@"Current Trait Collection:");
    [ALPUtilities logTraitCollection:self.view.traitCollection];
}

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id <UIViewControllerTransitionCoordinatorContext> context) {
        [self.view setNeedsLayout];
    } completion:nil];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    // if the interface orientation change set the new trait collection for size
    [self setTraitCollectionForSize:size];
}

#pragma mark - My Private Methods

-(void)setTraitCollectionForSize:(CGSize)size {
    
    if (self.view.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        // determine new Size Class
        UIUserInterfaceSizeClass newSizeClass = (size.width > 768.0 ? UIUserInterfaceSizeClassCompact : UIUserInterfaceSizeClassRegular);
        
        // create a new Trait Collection
//        UITraitCollection *newTraitCollection = [UITraitCollection traitCollectionWithVerticalSizeClass:newSizeClass];
        UITraitCollection *newVerticalTraitCollection   = [UITraitCollection traitCollectionWithVerticalSizeClass:newSizeClass];
        UITraitCollection *newHorizontalTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:newSizeClass];
        UITraitCollection *newTraitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:@[newHorizontalTraitCollection, newVerticalTraitCollection]];
        
        // assign new Trait Collection to child view = self
        [self.navigationController setOverrideTraitCollection:newTraitCollection forChildViewController:self];
        
    }
}

@end

//
//  ALPViewController.m
//  ALPlayGround
//
//  Created by Pit Garbe on 10.01.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import "ALPViewController.h"

@interface ALPViewController ()

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *layoutConstraintsPortrait;
@property (strong, nonatomic) NSMutableArray *layoutConstraintsLandscape;


@property (strong, nonatomic) IBOutlet UIView *green;
@property (strong, nonatomic) IBOutlet UIView *orange;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *labelContainer;

@end

@implementation ALPViewController

#pragma mark - Old Methods

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
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
        [self updateConstraintsForTraitCollection:newCollection];
        [self.view setNeedsLayout];
    } completion:nil];
}

#pragma mark - My Private Methods

-(void)updateConstraintsForTraitCollection:(UITraitCollection *)collection {
    
    [self.view removeConstraints:self.layoutConstraintsLandscape];
    [self.view removeConstraints:self.layoutConstraintsPortrait];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_green, _orange, _labelContainer, _imageView);
    if (collection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        // overall layout of green and orange boxes
        self.layoutConstraintsLandscape = [NSMutableArray arrayWithArray:
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_green]-16-[_orange]"
                                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                   metrics:nil
                                                                                     views:views]];
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_orange]"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_green]-20-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        
        // inner layout of green box
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]-56-[_labelContainer]|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.layoutConstraintsLandscape addObject:
         [NSLayoutConstraint constraintWithItem:_imageView
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_green
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsLandscape addObject:
         [NSLayoutConstraint constraintWithItem:_imageView
                                      attribute:NSLayoutAttributeCenterX
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_labelContainer
                                      attribute:NSLayoutAttributeCenterX
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_labelContainer]|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.view addConstraints:self.layoutConstraintsLandscape];
    }
    else {
        [self.view addConstraints:self.layoutConstraintsPortrait];
    }
    
    /*  simple, but not best performance: install all constraints in self.view
     *  --> it would be better to install the constraints in the closest common ancestor of the concerning views of the constraint
     *  (but would also make it more complex to set up, since it would require several IBOutletCollections, arrays etc.
     */
}



@end

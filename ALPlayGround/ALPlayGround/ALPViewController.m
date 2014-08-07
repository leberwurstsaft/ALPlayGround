//
//  ALPViewController.m
//  ALPlayGround
//
//  Created by Pit Garbe on 10.01.14.
//  Copyright (c) 2014 Pit Garbe. All rights reserved.
//

#import "ALPViewController.h"

@interface ALPViewController ()

@property (strong, nonatomic) NSMutableArray *layoutConstraintsPortrait;
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

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // initial set the trait collection for current interface orientation
    [self setTraitCollectionForSize:self.view.frame.size];
    
    [self updateConstraintsForTraitCollection:self.view.traitCollection];
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
        UITraitCollection *newTraitCollection = [UITraitCollection traitCollectionWithVerticalSizeClass:newSizeClass];
        
        // assign new Trait Collection to child view = self
        [self.navigationController setOverrideTraitCollection:newTraitCollection forChildViewController:self];
        
    }
}

-(void)updateConstraintsForTraitCollection:(UITraitCollection *)collection {
    
    [self.view removeConstraints:self.layoutConstraintsLandscape];
    [self.view removeConstraints:self.layoutConstraintsPortrait];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_green, _orange, _labelContainer, _imageView);
    if (collection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        // add constraints for green and orange view
        self.layoutConstraintsLandscape = [NSMutableArray arrayWithArray:
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_green]-20-[_orange]-20-|"
                                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                   metrics:nil
                                                                                     views:views]];
        
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_green]-20-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_orange]-20-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.layoutConstraintsLandscape addObject:
         [NSLayoutConstraint constraintWithItem:_green
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_orange
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsLandscape addObject:
         [NSLayoutConstraint constraintWithItem:_green
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_orange
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:1
                                       constant:0]];
        
        // add constraints for imageView and labelContainer
        [self.layoutConstraintsLandscape addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_imageView]-20-[_labelContainer]|"
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
        self.layoutConstraintsPortrait = [NSMutableArray arrayWithArray:
                                          [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_green]-20-|"
                                                                                  options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                  metrics:nil
                                                                                    views:views]];
        
        [self.layoutConstraintsPortrait addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_orange]-20-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil views:views]];
        
        [self.layoutConstraintsPortrait addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_green]-20-[_orange]-20-|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.layoutConstraintsPortrait addObject:
         [NSLayoutConstraint constraintWithItem:_green
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_orange
                                      attribute:NSLayoutAttributeWidth
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsPortrait addObject:
         [NSLayoutConstraint constraintWithItem:_green
                                      attribute:NSLayoutAttributeHeight
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_orange
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsPortrait addObject:
         [NSLayoutConstraint constraintWithItem:_imageView
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_green
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsPortrait addObject:
         [NSLayoutConstraint constraintWithItem:_imageView
                                      attribute:NSLayoutAttributeCenterY
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:_labelContainer
                                      attribute:NSLayoutAttributeCenterY
                                     multiplier:1
                                       constant:0]];
        
        [self.layoutConstraintsPortrait addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_imageView]-20-[_labelContainer]|"
                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                 metrics:nil
                                                   views:views]];
        
        [self.view addConstraints:self.layoutConstraintsPortrait];
    }
    
    /*  simple, but not best performance: install all constraints in self.view
     *  --> it would be better to install the constraints in the closest common ancestor of the concerning views of the constraint
     *  (but would also make it more complex to set up, since it would require several IBOutletCollections, arrays etc.
     */
}



@end

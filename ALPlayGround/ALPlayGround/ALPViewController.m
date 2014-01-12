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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];

    NSDictionary *views = NSDictionaryOfVariableBindings(_green, _orange, _labelContainer, _imageView);
    if (!self.layoutConstraintsLandscape) {

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


    }

    /*  simple, but not best performance: install all constraints in self.view
     *  --> it would be better to install the constraints in the closest common ancestor of the concerning views of the constraint
     *  (but would also make it more complex to set up, since it would require several IBOutletCollections, arrays etc.
     */

    [self.view removeConstraints:self.layoutConstraintsLandscape];
    [self.view removeConstraints:self.layoutConstraintsPortrait];
    [self.view addConstraints:(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? self.layoutConstraintsPortrait : self.layoutConstraintsLandscape];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"labelContainer: %@", self.labelContainer);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

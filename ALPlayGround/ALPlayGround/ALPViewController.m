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

@end

@implementation ALPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_green, _orange);
    if (!self.layoutConstraintsLandscape) {
        self.layoutConstraintsLandscape = [NSMutableArray arrayWithArray:
                                           [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_green]-16-[_orange]"
                                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                   metrics:nil
                                                                                     views:views]];
        [self.layoutConstraintsLandscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_orange]"
                                                                                            options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                            metrics:nil
                                                                                              views:views]];
        [self.layoutConstraintsLandscape addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_green]-20-|"
                                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                                     metrics:nil
                                                                                                       views:views]];
    }

    [self.view removeConstraints:self.layoutConstraintsLandscape];
    [self.view removeConstraints:self.layoutConstraintsPortrait];
    [self.view addConstraints:(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) ? self.layoutConstraintsPortrait : self.layoutConstraintsLandscape];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

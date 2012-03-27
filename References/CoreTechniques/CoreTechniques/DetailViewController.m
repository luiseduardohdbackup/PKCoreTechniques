/* 
 * Copyright (c) 2011, Nehira.com
 * All rights reserved.
 * 
 * @author Philip Kluz
 * @date 26.03.2012
 */

#import "DetailViewController.h"

// Demo Files
#import "ColorFillView.h"
#import "GradientFillLinearView.h"
#import "GradientFillRadialView.h"
#import "ImageView.h"
#import "PathsView.h"
#import "BezierCurveView.h"
#import "ClippingView.h"
#import "ClippingEOView.h"

@interface DetailViewController ()

#pragma mark - Private Proeprties
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) UIView *currentView;

#pragma mark - Private Methods
- (void)updateView;

@end

@implementation DetailViewController

@synthesize topic = _topic;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize currentView = _currentView;

#pragma mark - Managing the detail item

- (void)updateView
{
	if (nil != self.topic)
	{
		if (nil != [self.currentView superview])
		{
			[self.currentView removeFromSuperview];
		}
		
		if ([self.topic isEqualToString:@"Color Fill"])
		{
			self.view = [[ColorFillView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Gradient Fill (Linear)"])
		{
			self.view = [[GradientFillLinearView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Gradient Fill (Radial)"])
		{
			self.view = [[GradientFillRadialView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Images"])
		{
			self.view = [[ImageView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Paths"])
		{
			self.view = [[PathsView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Bezier Curves"])
		{
			self.view = [[BezierCurveView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Clipping"])
		{
			self.view = [[ClippingView alloc] initWithFrame:self.view.frame];
		}
		else if ([self.topic isEqualToString:@"Clipping (Even-Odd)"])
		{
			self.view = [[ClippingEOView alloc] initWithFrame:self.view.frame];
		}
		else
		{
			// No valid topic selected.
		}
	}
}

#pragma mark - Accessors

- (void)setTopic:(NSString *)newTopic
{
	if (_topic != newTopic)
	{
        _topic = newTopic;
        [self updateView];
    }
	
    if (self.masterPopoverController != nil)
	{
        [self.masterPopoverController dismissPopoverAnimated:YES];
    } 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = NSLocalizedString(@"Rendered", @"Rendered");
	self.topic = @"Color Fill";
	[self updateView];
}

- (void)viewDidUnload
{
	self.topic = nil;
	
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Topics", @"Topics");
	
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
	
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end

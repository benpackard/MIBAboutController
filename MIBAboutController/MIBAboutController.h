//
//  MIBAboutController.h
//  NoHitterAlerts
//
//  Created by Ben Packard on 10/19/13.
//  Copyright (c) 2013 Made in Bletchley. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MIBAboutDelegate;

@interface MIBAboutController : UITableViewController

@property (nonatomic, weak) id <MIBAboutDelegate> delegate;
@property NSArray *sections;
@property NSString *headerText, *footerText;
@property NSDictionary *tableHeaderFooterAttributes, *sectionTextAttributes, *rowTextAttributes;

@end


@protocol MIBAboutDelegate <NSObject>

- (void)aboutViewClosedByController:(MIBAboutController *)controller;

@end
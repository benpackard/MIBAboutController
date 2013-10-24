//
//  MIBAboutControllerSection.h
//  NoHitterAlerts
//
//  Created by Ben Packard on 10/20/13.
//  Copyright (c) 2013 Made in Bletchley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIBAboutRow.h"

@interface MIBAboutSection : NSObject

@property NSArray *rows;
@property NSString *sectionHeaderText, *sectionFooterText;

@end

//
//  MIBAboutRow.m
//  NoHitterAlerts
//
//  Created by Ben Packard on 10/20/13.
//  Copyright (c) 2013 Made in Bletchley. All rights reserved.
//

#import "MIBAboutRow.h"

@implementation MIBAboutRow

- (id)initWithRowText:(NSString *)rowText
{
	self = [super init];
	if (self)
	{
		self.rowText = rowText;
	}
	
	return self;
}

@end

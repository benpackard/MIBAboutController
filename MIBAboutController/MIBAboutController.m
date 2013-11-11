//
//  MIBAboutController.m
//  NoHitterAlerts
//
//  Created by Ben Packard on 10/19/13.
//  Copyright (c) 2013 Made in Bletchley. All rights reserved.
//

#import "MIBAboutController.h"
#import "MIBAboutSection.h"
#import "MIBAboutRow.h"

@interface MIBAboutController ()

- (UIView *)headerOrFooterViewWithText:(NSString *)text attributes:(NSDictionary *)attributes;
- (CGFloat)heightForHeaderOrFooterBasedOnText:(NSString *)text attributes:(NSDictionary *)attributes;
- (void)close;

@end

@implementation MIBAboutController

#pragma mark = constants

static CGFloat const kHeaderFooterMargin = 15;

#pragma mark - lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
    if (self)
	{
		self.sections = [NSMutableArray array];		
		self.headerText = nil;
		self.footerText = nil;
		self.tableHeaderFooterAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
		self.sectionTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
		self.rowTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
    }
	
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
		
	//register cell types
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
	
	//add a close button
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
	self.navigationItem.rightBarButtonItem = closeButton;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	//add the table header and footer - set here since the bounds of the tableview aren't yet known in viewDidLoad
	if (self.headerText)
	{
		self.tableView.tableHeaderView = [self headerOrFooterViewWithText:self.headerText attributes:self.tableHeaderFooterAttributes];
	}
	
	if (self.footerText)
	{
		self.tableView.tableFooterView = [self headerOrFooterViewWithText:self.footerText attributes:self.tableHeaderFooterAttributes];
	}
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	//re-add the table header and footer - this is a little hacky but without it the header/footer is not resized correctly on rotation
	if (self.headerText)
	{
		self.tableView.tableHeaderView = [self headerOrFooterViewWithText:self.headerText attributes:self.tableHeaderFooterAttributes];
	}
	if (self.footerText)
	{
		self.tableView.tableFooterView = [self headerOrFooterViewWithText:self.footerText attributes:self.tableHeaderFooterAttributes];
	}
}


#pragma mark - tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	MIBAboutSection *thisSection = self.sections[section];
	return thisSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	cell.backgroundColor = [UIColor whiteColor];
	cell.textLabel.textColor = self.view.tintColor;
	cell.textLabel.backgroundColor = [UIColor whiteColor];
	
	MIBAboutSection *thisSection = self.sections[indexPath.section];
	MIBAboutRow *thisRow = thisSection.rows[indexPath.row];
	NSString *cellText = thisRow.rowText;
	
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:cellText attributes:self.rowTextAttributes];
	cell.textLabel.attributedText = attributedString;
	
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	MIBAboutSection *thisSection = self.sections[section];
	return thisSection.sectionHeaderText ? [self headerOrFooterViewWithText:thisSection.sectionHeaderText attributes:self.sectionTextAttributes] : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	MIBAboutSection *thisSection = self.sections[section];
	return thisSection.sectionHeaderText ? [self heightForHeaderOrFooterBasedOnText:thisSection.sectionHeaderText attributes:self.sectionTextAttributes] : UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	MIBAboutSection *thisSection = self.sections[section];
	return thisSection.sectionFooterText ? [self headerOrFooterViewWithText:thisSection.sectionFooterText attributes:self.sectionTextAttributes] : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	MIBAboutSection *thisSection = self.sections[section];
	return thisSection.sectionFooterText ? [self heightForHeaderOrFooterBasedOnText:thisSection.sectionFooterText attributes:self.sectionTextAttributes] : UITableViewAutomaticDimension;
}

- (UIView *)headerOrFooterViewWithText:(NSString *)text attributes:(NSDictionary *)attributes
{
	//create a label inside a containing view
	UIView *containingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, [self heightForHeaderOrFooterBasedOnText:text attributes:attributes])];
	containingView.backgroundColor = [UIColor whiteColor];
	UILabel *innerLabel = [[UILabel alloc] initWithFrame:CGRectInset(containingView.bounds, kHeaderFooterMargin, kHeaderFooterMargin)];
	innerLabel.backgroundColor = [UIColor whiteColor];
	innerLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	innerLabel.numberOfLines = 0;
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:attributes];
	innerLabel.attributedText = attributedString;
	[containingView addSubview:innerLabel];
	return containingView;
}

- (CGFloat)heightForHeaderOrFooterBasedOnText:(NSString *)text attributes:(NSDictionary *)attributes
{
	//return the height required for the provided text, given the font, margin, etc
	CGRect boundingRect = [text boundingRectWithSize:CGSizeMake(self.tableView.bounds.size.width - (2 * kHeaderFooterMargin), MAXFLOAT)
											 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
										  attributes:attributes
											 context:nil];
	return ceilf(boundingRect.size.height + (2 * kHeaderFooterMargin));
}

#pragma mark - tableview actions

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//by default de-select the cell since usually some modal or other app will be opened on selection rather another VC pushed
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - delegtation

- (void)close
{
	//let delegate know that user wants to close
	[self.delegate aboutViewClosedByController:self];
}

@end

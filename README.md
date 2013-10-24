MIBAboutController
==================

A simple tableview for static content, optimized for 'About' views.

The simplest way to create an About view is to simply add some sections and rows, each with text:

	//add the content
	MIBAboutSection *section1 = [[MIBAboutSection alloc] init];
	section1.sectionHeaderText = @"If you find this app useful, please consider rating it on the App Store.";
	MIBAboutRow *row1 = [[MIBAboutRow alloc] initWithRowText:@"Rate this App"];
	section1.rows = @[row1];
	
	MIBAboutSection *section2 = [[MIBAboutSection alloc] init];
	section2.sectionHeaderText = @"If you have any comments or suggestions, please use the button below.";
	MIBAboutRow *row2 = [[MIBAboutRow alloc] initWithRowText:@"Send Feedback"];
	section2a.rows = @[row2];
	
	MIBAboutSection *section3 = [[MIBAboutSection alloc] init];
	section3.sectionHeaderText = @"No-Hitter Alerts is an app by Ben Packard.";
	MIBAboutRow *row3 = [[MIBAboutRow alloc] initWithRowText:@"Visit benpackard.org"];
	MIBAboutRow *row3 = [[MIBAboutRow alloc] initWithRowText:@"Follow @benpackard"];
	section3a.rows = @[row3, row4];
	
	controller.sections = @[section1, section2, section3];
	
This will create a view with three sections and a number of rows.

The About controller also makes properties available to set some text above and below the table view.
	
	//set the table footer text
	NSString *footerString = [NSString stringWithFormat:@"App version is %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
	controller.footerText = footerString;
	
The text in section headers/footers, rows, and table header/footers each have their own formatting attributes property.

	//set the font and increase line-spacing for section text
	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle setLineSpacing:8];
	controller.sectionTextAttributes = @{NSFontAttributeName:[UIFont appFontOfSize:17], NSParagraphStyleAttributeName:paragraphStyle};
	
	//use a smaller font and center alignment for the table footer
	NSMutableParagraphStyle *paragraphStyle2 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle2 setAlignment: NSTextAlignmentCenter];
	controller.tableHeaderFooterAttributes = @{NSFontAttributeName:[UIFont appFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle2};
	
	//set font and use center alignment for rows
	NSMutableParagraphStyle *paragraphStyle3 = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	[paragraphStyle3 setAlignment: NSTextAlignmentCenter];
	controller.rowTextAttributes = @{NSFontAttributeName:[UIFont appFontOfSize:20], NSParagraphStyleAttributeName:paragraphStyle3};

![About controller](http://benpackard.org/SO/MIBAboutScreenshot.png)

Subclassing
-----------

For more custom behavior, subclassing is recommended. A subclass is also the place to define any custom actions on cell selection.

When subclassing, content should be set prior to loadView (eg init).

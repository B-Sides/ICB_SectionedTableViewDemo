//
//  ICB_SectionedTableViewDemoViewController.m
//  ICB_SectionedTableViewDemo
//
//  Created by Matt Tuzzolo on 12/10/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import "ICB_SectionedTableViewDemoViewController.h"

@implementation ICB_SectionedTableViewDemoViewController

@synthesize books, sections;

- (void)viewDidLoad {
    
    self.books = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"books" ofType:@"plist"]];
    self.sections = [[NSMutableDictionary alloc] init];
    
    BOOL found;
    
    // Loop through the books and create our keys
    for (NSDictionary *book in self.books)
    {        
        NSString *c = [[book objectForKey:@"title"] substringToIndex:1];
        
        found = NO;
        
        for (NSString *str in [self.sections allKeys])
        {
            if ([str isEqualToString:c])
            {
                found = YES;
            }
        }
        
        if (!found)
        {     
            [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
        }
    }
        
    // Loop again and sort the books into their respective keys
    for (NSDictionary *book in self.books)
    {
        [[self.sections objectForKey:[[book objectForKey:@"title"] substringToIndex:1]] addObject:book];
    }    
    
    // Sort each section array
    for (NSString *key in [self.sections allKeys])
    {
        [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
    }    
    
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return [[self.sections allKeys] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *book = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    	
    cell.textLabel.text = [book objectForKey:@"title"];    
    cell.detailTextLabel.text = [book objectForKey:@"description"];
	
    return cell;
}




- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end

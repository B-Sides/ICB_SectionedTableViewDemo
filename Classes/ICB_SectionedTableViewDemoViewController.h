//
//  ICB_SectionedTableViewDemoViewController.h
//  ICB_SectionedTableViewDemo
//
//  Created by Matt Tuzzolo on 12/10/10.
//  Copyright 2010 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICB_SectionedTableViewDemoViewController : UIViewController {
    NSArray *books;
    NSMutableDictionary *sections;        
}

@property (nonatomic,retain) NSArray *books;
@property (nonatomic,retain) NSMutableDictionary *sections;

@end


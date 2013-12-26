//
//  MyCell.m
//  testTable
//
//  Created by Alexander on 26.12.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "MyCell.h"

@interface MyCell()

@property (nonatomic, weak) IBOutlet UILabel* lab;
@property (nonatomic, weak) IBOutlet UISwitch* checkBox;

@end

@implementation MyCell
@synthesize lab, checkBox;
- (void)setDataDic:(NSMutableDictionary *)dataDic
{
    _dataDic = dataDic;
    lab.text = dataDic[@"name"];
    checkBox.on = [dataDic[@"checked"] boolValue];
}

- (IBAction)checkBoxChanged
{
    _dataDic[@"checked"] = @(checkBox.on);
}

@end

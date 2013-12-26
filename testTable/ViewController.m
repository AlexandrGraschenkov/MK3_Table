//
//  ViewController.m
//  testTable
//
//  Created by Alexander on 26.12.13.
//  Copyright (c) 2013 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
{
    CGSize buttSize;
    int buttonsCount;
    NSMutableArray* buttons;
}
@property (nonatomic, weak) IBOutlet UIScrollView* scroll;
@end

@implementation ViewController
@synthesize scroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    buttonsCount = 100;
    buttSize = CGSizeMake(200, 30);
    scroll.contentSize = CGSizeMake(10, buttSize.height * buttonsCount);
    buttons = [NSMutableArray new];
    [self scrollViewDidScroll:scroll];
}

- (UIButton*)getUnusedButton
{
    CGRect visibleFrame = scroll.bounds;
    for(UIButton* butt in buttons){
        BOOL isVisible = CGRectContainsRect(visibleFrame, butt.frame);
        if(!isVisible)
            return butt;
    }
    
    UIButton* butt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttSize.width, buttSize.height)];
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttons addObject:butt];
    return butt;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int idxFrom = MAX(0, floorf(scroll.contentOffset.y / buttSize.height));
    int count = 1 + ceilf(scroll.frame.size.height / buttSize.height);
    count = MIN(count, buttonsCount);
    
    for(int i = idxFrom; i <= MIN(idxFrom+count, buttonsCount-1); i++){
        if([scroll viewWithTag:i])
            continue;
        
        UIButton* butt = [self getUnusedButton];
        if(!butt.superview)
            [scroll addSubview:butt];
        butt.tag = i;
        [self setupButton:butt withIndex:i];
    }
    NSLog(@"%d", buttons.count);
}

- (void)setupButton:(UIButton*)butt withIndex:(int)idx
{
    butt.frame = CGRectMake(0, idx*buttSize.height, buttSize.width, buttSize.height);
    NSString* str = [NSString stringWithFormat:@"Buttun %d", idx];
    [butt setTitle:str forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed:(UIButton*)butt
{
    NSString* str = [butt titleForState:UIControlStateNormal];
    [[[UIAlertView alloc] initWithTitle:nil
                                message:str
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil] show];
}
@end

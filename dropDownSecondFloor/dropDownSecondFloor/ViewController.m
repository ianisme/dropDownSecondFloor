//
//  ViewController.m
//  dropDownSecondFloor
//
//  Created by quy21 on 2019/2/13.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushAction:(id)sender
{
    MainViewController *controller = [[MainViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end

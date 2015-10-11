//
//  ViewController.m
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "ViewController.h"
#import "BMWallet.h"
#import <AddressBook/AddressBook.h>
#import "GetQuoteViewController.h"
#import "Bitmates.h"

@interface ViewController ()
@property NSArray *people;
@end

@implementation ViewController
@synthesize people;

-(BOOL)prefersStatusBarHidden{
    return true;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    ABAddressBookRef addressBook = ABAddressBookCreate();
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined){
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if(error){
                NSLog(@"ERROR%@", (NSError *)CFBridgingRelease(error));
            }
            else{
                [self populatePeople];
            }
        });
    }
    else{
        [self populatePeople];
    }
    
    UITableView *tbv = [[UITableView alloc] initWithFrame:self.view.frame];
    [tbv setDelegate:self];
    [tbv setDataSource:self];
    [self.view addSubview:tbv];
}

-(void)populatePeople{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    CFArrayRef arrRef = ABAddressBookCopyArrayOfAllPeople(addressBook);
    if (arrRef != NULL) {
        NSMutableArray *names = [NSMutableArray array];
        for (int i = 0; i < CFArrayGetCount(arrRef); i++) {
            ABRecordRef person = CFArrayGetValueAtIndex(arrRef, i);
            CFStringRef name = ABRecordCopyCompositeName(person);
            [names addObject:(__bridge NSString *)name];
            CFRelease(name);
        }
        people = names;
    }
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return people.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    cell.textLabel.textColor = [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    cell.textLabel.text = people[indexPath.row];
    
    UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
    myBackView.backgroundColor = [UIColor blackColor];
    cell.selectedBackgroundView = myBackView;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = people[indexPath.row];
    GetQuoteViewController *gqvc = [[GetQuoteViewController alloc] init];
    gqvc.personName = name;
    [self.navigationController pushViewController:gqvc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

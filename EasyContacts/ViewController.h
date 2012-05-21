//
//  ViewController.h
//  EasyContacts
//
//  Created by Sathish  Kumar on 20/05/12.
//  Copyright (c) 2012 8600@thoughtworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>

@interface ViewController : UIViewController<ABPeoplePickerNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
- (IBAction)showPicker:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
- (IBAction)update:(id)sender;
- (IBAction)syncFacebook:(id)sender;

@end

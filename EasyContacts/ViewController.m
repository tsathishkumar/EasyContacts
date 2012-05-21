//
//  ViewController.m
//  EasyContacts
//
//  Created by Sathish  Kumar on 20/05/12.
//  Copyright (c) 2012 8600@thoughtworks.com. All rights reserved.
//

#import "ViewController.h"
#import "FaceBookDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize lastName;
@synthesize firstName;
@synthesize phoneNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setFirstName:nil];
    [self setPhoneNumber:nil];
    [self setLastName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)showPicker:(id)sender
{
        ABPeoplePickerNavigationController *picker =
        [[ABPeoplePickerNavigationController alloc] init];
        picker.peoplePickerDelegate = self;
        
        [self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self displayPerson:person];
    [self dismissModalViewControllerAnimated:YES];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

- (void)displayPerson:(ABRecordRef)person
{
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    self.firstName.text = name;
    
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    self.phoneNumber.text = phone;
}
- (IBAction)update:(id)sender {
    ABAddressBookRef addressBook;
    bool wantToSaveChanges = YES;
    bool didSave;
    CFErrorRef error = NULL;
    addressBook = ABAddressBookCreate();
    
    ABRecordRef aRecord = ABPersonCreate();
    CFErrorRef anError = NULL;
    bool didSet;
    didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, CFSTR("Katie"),
                              &anError);
    if (!didSet) {/* Handle error here. */}
    didSet = ABRecordSetValue(aRecord, kABPersonLastNameProperty, CFSTR("Bell"),
                              &anError);
    if (!didSet) {/* Handle error here. */}
    CFStringRef firstName1, lastName1;
    firstName1 = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
    lastName1 = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
    /* ... Do something with firstName and lastName. ... */
    ABAddressBookAddRecord(addressBook, aRecord,nil);
    
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        if (wantToSaveChanges) {
            didSave = ABAddressBookSave(addressBook, &error);
            if (!didSave) {/* Handle error here. */}
        } else {
            ABAddressBookRevert(addressBook);
        }
    }
    CFRelease(aRecord);
    CFRelease(firstName1);
    CFRelease(lastName1);
    CFRelease(addressBook);
}

- (IBAction)syncFacebook:(id)sender {
    FaceBookDelegate *facebook = [[FaceBookDelegate new]init];
    [facebook syncFromFacebook];
}
@end

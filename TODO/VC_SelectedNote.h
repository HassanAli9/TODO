//
//  VC_SelectedNote.h
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface VC_SelectedNote : UIViewController

@property Note * note;

@property (weak, nonatomic) IBOutlet UITextView *txtDetails;


@property (weak, nonatomic) IBOutlet UITextField *txtTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDateTimeCreation;


@property (weak, nonatomic) IBOutlet UITableView *tableViewPiority;

@property (weak, nonatomic) IBOutlet UITableView *tableViewState;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShowPiority;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShowStateOutlet;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarSelected;


@end

NS_ASSUME_NONNULL_END

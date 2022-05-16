//
//  VC_Add.h
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VC_Add : UIViewController <UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewPiority;

@property (weak, nonatomic) IBOutlet UITableView *tableViewState;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnShow;

@property (strong , nonatomic) NSArray * arrPiority;
@property (strong , nonatomic) NSArray * arrState;


@property (weak, nonatomic) IBOutlet UITextField *txtTitle;

@property (weak, nonatomic) IBOutlet UITextView *txtDetails;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnStateOutlet;



@end

NS_ASSUME_NONNULL_END

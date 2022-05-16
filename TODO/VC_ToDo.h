//
//  VC_ToDo.h
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "VC_Add.h"
#import "Note.h"
#import "VC_SelectedNote.h"

NS_ASSUME_NONNULL_BEGIN

@interface VC_ToDo : UIViewController <UITableViewDataSource , UITableViewDelegate>
{
    VC_Add * add;
    NSMutableArray <Note*> * arr;
    NSUserDefaults * d;
    NSData * data;
    NSSet * set;
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewTODO;

@end

NS_ASSUME_NONNULL_END

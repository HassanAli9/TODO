//
//  VC_Done.h
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import <UIKit/UIKit.h>
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface VC_Done : UIViewController <UITableViewDataSource , UITableViewDelegate>
{
    NSMutableArray <Note*> * arr;
    NSUserDefaults * d;
    NSData * data;
    NSSet * set;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableViewDone;

@end

NS_ASSUME_NONNULL_END

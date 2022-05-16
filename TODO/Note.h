//
//  Note.h
//  TODO
//
//  Created by Hassan on 28/01/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject <NSCoding ,NSSecureCoding>

@property int note_id;
@property NSString * titleTask;
@property NSString * details;
@property NSString * dataTimeCreation;
@property NSString * piority;
@property NSString * stateNote;



@end

NS_ASSUME_NONNULL_END

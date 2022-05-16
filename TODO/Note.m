//
//  Note.m
//  TODO
//
//  Created by Hassan on 28/01/2022.
//

#import "Note.h"

@implementation Note




- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_titleTask forKey:@"title"];
    [coder encodeObject:_details forKey:@"details"];
    [coder encodeObject:_piority forKey:@"piority"];
    [coder encodeObject:_dataTimeCreation forKey:@"dataTimeCreation"];
    [coder encodeInt:_note_id forKey:@"id"];
    [coder encodeObject:_stateNote forKey:@"state"];

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    
    if (self = [super init]) {
        _titleTask = [coder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _details = [coder decodeObjectOfClass:[NSString class] forKey:@"details"];
       
        _piority = [coder decodeObjectOfClass:[NSString class] forKey:@"piority"];
                  
        _dataTimeCreation = [coder decodeObjectOfClass:[NSString class] forKey:@"dataTimeCreation"];
        
        _note_id = [coder decodeIntForKey:@"id"];
        
        _stateNote = [coder decodeObjectOfClass:[NSString class] forKey:@"state"];
        
    }
    /*
    _title  = [coder decodeObjectForKey:@"title"];
    _details = [coder decodeObjectForKey:@"details"];
    _piority = [coder decodeObjectForKey:@"piority"];
    _dataTimeCreation = [coder decodeObjectForKey:@"dataTimeCreation"];
    */
    return  self;
}


+(BOOL)supportsSecureCoding
{
    return  YES;
}

@end

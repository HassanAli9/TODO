//
//  VC_SelectedNote.m
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import "VC_SelectedNote.h"
#import "VC_Add.h"


@interface VC_SelectedNote ()
{
    Note * n ;
    NSString * btnStr;
    NSString * oldState;
    NSUserDefaults * defults;
}
@property (strong , nonatomic) NSArray * arrPiority;
@property (strong , nonatomic) NSArray * arrState;


@end

@implementation VC_SelectedNote
static NSString * KEY_PROGRESS;
static NSString * KEY_TO_DO;
static NSString * KEY_DONE;
+(void)initialize{
    printf("init called \n");
    KEY_TO_DO = @"arr";
    KEY_PROGRESS = @"arrProgress";
    KEY_DONE = @"Done";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableViewPiority.hidden = YES;
    _tableViewState.hidden = YES;
    UIBarButtonItem * btn;
    
    if ([_note.stateNote isEqual:@"in-Progress"])
        {
            btn =[ [UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(btnEdit) ];

    [self.navigationItem setRightBarButtonItem:btn];
        }
    
    if ([_note.stateNote isEqual:@"Done"])
    {
    _toolbarSelected.hidden = YES;
    }
    
    _txtTitle.text = _note.titleTask;
    _txtDetails.text = _note.details;
    [_btnShowPiority setTitle:_note.piority];
    [_btnShowStateOutlet setTitle:_note.stateNote];
    _lblDateTimeCreation.text = _note.dataTimeCreation;
    
    oldState = _note.stateNote;
    
    _arrPiority =  [[NSArray alloc] initWithObjects:@"High", @"Medium",@"Low" ,nil];
    
    if ([_note.stateNote isEqual:@"in-Progress"]) {
        _arrState = [[NSArray alloc] initWithObjects:@"in-Progress",@"Done" ,nil];
        
    }else if ([_note.stateNote isEqual:@"Done"])
    {
        _arrState = [[NSArray alloc] initWithObjects:@"Done" ,nil];
        
    }
    else
        _arrState = [[NSArray alloc] initWithObjects:@"To-Do", @"in-Progress",@"Done" ,nil];
    
}



-(IBAction)btnEdit{
    
    printf("btn Edit Clicked\n");
    
    
    _note.stateNote = _btnShowStateOutlet.title;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are You sure You want to Edit" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"Conform" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    
        
        
        
        self->defults = [NSUserDefaults standardUserDefaults];
        NSData * data_inProgress = [self->defults objectForKey:KEY_PROGRESS];
        NSData * archivedDataDone = [self->defults objectForKey:KEY_DONE];
        if ([self-> _note.stateNote isEqual:@"in-Progress"])
        {
            if (data_inProgress == nil){
                NSMutableArray * arrProgress = [NSMutableArray new];
                [arrProgress addObject:self->_note];
                data_inProgress = [NSKeyedArchiver archivedDataWithRootObject:arrProgress requiringSecureCoding:YES error:NULL];
                
                [self->defults setObject:data_inProgress forKey:KEY_PROGRESS];
                
            }else
            {
                NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
                
                NSMutableArray <Note*> * arrProgress = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data_inProgress error:NULL];
                
                
                
                if (   [self-> _note.stateNote isEqual:@"in-Progress"]&& [self->oldState isEqual:@"To-Do"] )
                {
                    [arrProgress addObject:self->_note];
                }
                else{
                    BOOL CHECK = YES;
                    int i = 0;
                    
                    while (CHECK) {
                        if ([arrProgress [i] note_id ] == self->_note.note_id)
                        {
                            [ [arrProgress objectAtIndex:i] setTitleTask:self->_txtTitle.text ];
                            [ [arrProgress objectAtIndex:i] setDetails:self->_txtDetails.text ];
                            [ [arrProgress objectAtIndex:i] setPiority:self->_btnShowPiority.title];
                            [ [arrProgress objectAtIndex:i] setStateNote:self->_btnShowStateOutlet.title ];
                            CHECK = NO;
                        }
                        if (i == arrProgress.count) {
                            CHECK = NO;
                        }
                        i++;
                    }
                    
                }
                //override new data
                
                data_inProgress = [NSKeyedArchiver archivedDataWithRootObject:arrProgress requiringSecureCoding:YES error:NULL];
                
                [self->defults setObject:data_inProgress forKey:KEY_PROGRESS];
            }
            
        } else if ([self-> _note.stateNote isEqual:@"Done"])
        {
            
            if (archivedDataDone == nil )
            {
                NSMutableArray * arrDone = [NSMutableArray new];
                [arrDone addObject:self->_note];
                
                archivedDataDone = [NSKeyedArchiver archivedDataWithRootObject:arrDone requiringSecureCoding:YES error:NULL];
                [self->defults setObject:archivedDataDone forKey:KEY_DONE];
                
            } else
            {
                NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
                
                NSMutableArray <Note*> * arrDone = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:archivedDataDone error:NULL];
                
                if (   [self-> _note.stateNote isEqual:@"Done"]&& [self->oldState isEqual:@"in-Progress"] )
                {
                    [arrDone addObject:self->_note];
                }
                
                
                archivedDataDone = [NSKeyedArchiver archivedDataWithRootObject:arrDone requiringSecureCoding:YES error:NULL];
                
                [self->defults setObject:archivedDataDone forKey:KEY_DONE];
            }
            
        }
        else
        {
            
            
            NSData * saveData = [self->defults objectForKey:@"arr"];
            
            NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
            
            NSMutableArray * arrm = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:saveData error:NULL];
            
            
            
            
            
            BOOL CHECK = YES;
            int i = 0;
            
            while (CHECK) {
                if ([arrm [i] note_id ] == self->_note.note_id)
                {
                    [ [arrm objectAtIndex:i] setTitleTask:self->_txtTitle.text ];
                    [ [arrm objectAtIndex:i] setDetails:self->_txtDetails.text ];
                    [ [arrm objectAtIndex:i] setPiority:self->_btnShowPiority.title];
                    [ [arrm objectAtIndex:i] setStateNote:self->_btnShowStateOutlet.title ];
                    
                    CHECK = NO;
                }
                if (i == arrm.count) {
                    CHECK = NO;
                }
                i++;
            }
            
            saveData = [NSKeyedArchiver archivedDataWithRootObject:arrm requiringSecureCoding:YES error:NULL];
            
            [self->defults setObject:saveData forKey:@"arr"];
            
        }
        
        
        if ([self-> _note.stateNote isEqual:@"Done"] && [self->oldState isEqual:@"To-Do"]) {
            [self deleteNote];
            
        }
        else if ( [self-> _note.stateNote isEqual:@"in-Progress"]&& [self->oldState isEqual:@"To-Do"]) {
            
            [self deleteNote];
            
        }
        
        if ([self-> _note.stateNote isEqual:@"Done"]&& [self->oldState isEqual:@"in-Progress"]) {
            
            NSData * data_inProgress = [self->defults objectForKey:KEY_PROGRESS];
            
            NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
            
            NSMutableArray <Note*> * arr1 = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data_inProgress error:NULL];
            
            BOOL CHECK = YES;
            int i = 0;
            
            while (CHECK) {
                if ([arr1 [i] note_id ] == self->_note.note_id)
                {
                    [arr1 removeObjectAtIndex:i];
                    //[arrm insertObject:self->_note atIndex:i];
                    CHECK = NO;
                }
                if (i == arr1.count) {
                    CHECK = NO;
                }
                i++;
            }
            //override new data
            
            data_inProgress = [NSKeyedArchiver archivedDataWithRootObject:arr1 requiringSecureCoding:YES error:NULL];
            
            [self->defults setObject:data_inProgress forKey:KEY_PROGRESS];
            
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
    
    [alert addAction:action];
    [alert addAction:action2];
    
    
    [self presentViewController:alert animated:YES completion:NULL];
    
    
}
-(void) deleteNote
{
    NSData * saveData = [defults objectForKey:@"arr"];
    
    NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
    
    NSMutableArray * arrm = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:saveData error:NULL];
    
    BOOL CHECK = YES;
    int i = 0;
    
    while (CHECK) {
        if ([arrm [i] note_id ] == self->_note.note_id)
        {
            [arrm removeObjectAtIndex:i];
            //[arrm insertObject:self->_note atIndex:i];
            CHECK = NO;
        }
        i++;
    }
    
    saveData = [NSKeyedArchiver archivedDataWithRootObject:arrm requiringSecureCoding:YES error:NULL];
    
    [defults setObject:saveData forKey:@"arr"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)btnShowP:(id)sender {
    btnStr = @"piority";
    if (_tableViewPiority.hidden == YES) {
        _tableViewPiority.hidden = NO;
    }else
        _tableViewPiority.hidden = YES;
    
    [_tableViewPiority reloadData];
    
}



- (IBAction)btnShowState:(id)sender {
    btnStr =@"state";
    
    if (_tableViewState.hidden == YES) {
        _tableViewState.hidden = NO;
    }else
        _tableViewState.hidden = YES;
    
    [_tableViewState reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([btnStr isEqual:@"piority"])
        return [_arrPiority count];
    else
        return [_arrState count];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    
    if ([btnStr isEqual:@"piority"])
        cell.textLabel.text = [_arrPiority objectAtIndex:indexPath.row];
    else
        cell.textLabel.text = [_arrState objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    if ([btnStr isEqual:@"piority"])
    {
        
        [_btnShowPiority setTitle:cell.textLabel.text];
        
    }
    else {
        [_btnShowStateOutlet setTitle:cell.textLabel.text];
    }
    
    
    _tableViewPiority.hidden=YES;
    _tableViewState.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}


@end

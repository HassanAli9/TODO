//
//  VC_Add.m
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import "VC_Add.h"
#import "Note.h"

@interface VC_Add ()
{
    UISwipeGestureRecognizer  * swipeLeft;
    UISwipeGestureRecognizer  * swipeRight;
    UIBarButtonItem * btn;
    NSMutableArray * arr;
    NSMutableArray * arrProgress;
    NSMutableArray * arrDone;
    
    NSData * archivedData;
    NSData * archivedDataProgress;
    NSData * archivedDataDone;
    
    NSUserDefaults * defults;
    NSString *resultString;
    Note * n;
    NSString * btnStr;
    
  
}


@end

@implementation VC_Add
static NSString * KEY_PROGRESS;
static NSString * KEY_TO_DO;
static NSString * KEY_DONE;
+(void)initialize{
    printf("init called \n");
    KEY_TO_DO = @"arr";
    KEY_PROGRESS = @"arrProgress";
    KEY_DONE = @"Done";
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        arr = [NSMutableArray new];
        arrProgress = [NSMutableArray new];
        arrDone = [NSMutableArray new];
        defults = [NSUserDefaults standardUserDefaults];
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableViewPiority.hidden = YES;
    _tableViewState.hidden = YES;
    
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft)];
    
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    
    
    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight)];
    
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    
    
    btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnAddNewNote)];
    
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    [self.navigationItem setRightBarButtonItem:btn];
    
    
    
    
    NSDate *currentTime = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    resultString = [dateFormatter stringFromDate: currentTime];
    
    _arrPiority =  [[NSArray alloc] initWithObjects:@"High", @"Medium",@"Low" ,nil];
    
    _arrState = [[NSArray alloc] initWithObjects:@"To-Do", @"in-Progress",@"Done" ,nil];
    
}
-(void) swipeLeft {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void) swipeRight {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)btnAddNewNote {
    printf("it's Work \n");
    
    

    
    n.titleTask = _txtTitle.text;
    n.details = _txtDetails.text;
    n.dataTimeCreation = resultString;
    n.piority = _btnShow.title;
    n.stateNote  = _btnStateOutlet.title;
    
    NSLog(@"n.state = %@",n.stateNote);
    NSLog(@"_btnStateOutlet.title = %@",_btnStateOutlet.title);

    
    
    if (n.piority == nil) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Piority" message:@"Please Chosee Piority" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL];
        
        [alert addAction:action];
        
        
        [self presentViewController:alert animated:YES completion:NULL];
        
    }
    else{
        
        
        if ([_btnStateOutlet.title isEqual:@"State ^"]) {
            
            UIAlertController * alert1 = [UIAlertController alertControllerWithTitle:@"State" message:@"Please Chosee State" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL];
            
            [alert1 addAction:action];
            
            
            [self presentViewController:alert1 animated:YES completion:NULL];
            
        }else
        
      
        {
            
            if ([_txtTitle.text isEqual:@""])
        {
            
            UIAlertController * alert1 = [UIAlertController alertControllerWithTitle:@"Title" message:@"Please Write Title" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:NULL];
            
            [alert1 addAction:action];
            
            
            [self presentViewController:alert1 animated:YES completion:NULL];
            
        }
        
        
        else{
            
            //Get data first from user defult
            archivedData = [defults objectForKey:KEY_TO_DO];
            archivedDataProgress = [defults objectForKey:KEY_PROGRESS];
            archivedDataDone = [defults objectForKey:KEY_DONE];
            
            if (archivedData == nil && [n.stateNote isEqual:@"To-Do"])
            {
                    [arr addObject:n];
                    archivedData = [NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:NULL];
                    [defults setObject:archivedData forKey:KEY_TO_DO];
                    
             }
                
            else if (archivedDataProgress == nil && [n.stateNote isEqual:@"in-Progress"]){
                    
                    
                        [arrProgress addObject:n];
                        archivedDataProgress = [NSKeyedArchiver archivedDataWithRootObject:arrProgress requiringSecureCoding:YES error:NULL];
                        
                [defults setObject:archivedDataProgress forKey:KEY_PROGRESS];
                    
                }
                else if (archivedDataDone == nil && [n.stateNote isEqual:@"Done"]  )
                {
                    
                        [arrDone addObject:n];
                        archivedDataDone = [NSKeyedArchiver archivedDataWithRootObject:arrDone requiringSecureCoding:YES error:NULL];
                        [defults setObject:archivedDataDone forKey:KEY_DONE];
                }
                
                else
                    
                {
                    
                    
                    NSSet * set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
                    
                    if ([n.stateNote isEqual:@"To-Do"])
                    {
                        NSMutableArray <Note*> * arr1 = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:archivedData error:NULL];
                        
                        [arr1 addObject:n];
                        
                        //override new data
                        
                        archivedData = [NSKeyedArchiver archivedDataWithRootObject:arr1 requiringSecureCoding:YES error:NULL];
                        
                        [defults setObject:archivedData forKey:KEY_TO_DO];
                        //[d synchronize];
                    }
                    
                    else if ([n.stateNote isEqual:@"in-Progress"])
                    {
                        NSMutableArray <Note*> * arr1 = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:archivedDataProgress error:NULL];
                        
                        [arr1 addObject:n];
                        
                        //override new data
                        
                        archivedDataProgress = [NSKeyedArchiver archivedDataWithRootObject:arr1 requiringSecureCoding:YES error:NULL];
                        
                        [defults setObject:archivedDataProgress forKey:KEY_PROGRESS];
                    }
                    
                    else if([n.stateNote isEqual:@"Done"]){
                        
                        NSMutableArray <Note*> * arr1 = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:archivedDataDone error:NULL];
                        
                        [arr1 addObject:n];
                        
                        //override new data
                        
                        archivedDataDone = [NSKeyedArchiver archivedDataWithRootObject:arr1 requiringSecureCoding:YES error:NULL];
                        
                        [defults setObject:archivedDataDone forKey:KEY_DONE];
                    }
                    
                    
                }
                
            }
            
        }
    }
    
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)btnShowPiority:(id)sender {
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
    
    return 3;
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
    
    
    //UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    
    if (n == nil) {
        n = [Note new];

    }
    
    
    
    if ([btnStr isEqual:@"piority"])
    {
        
        [_btnShow setTitle:cell.textLabel.text];
        
    }
    else {
        [_btnStateOutlet setTitle:cell.textLabel.text];
    }
    
    
    
    
    
    
    
    _tableViewPiority.hidden=YES;
    _tableViewState.hidden = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 25;
}
@end

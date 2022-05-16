//
//  VC_ToDo.m
//  TODO
//
//  Created by Hassan on 27/01/2022.
//

#import "VC_ToDo.h"

@interface VC_ToDo ()
{
    
    
    NSMutableArray * arrH;
    NSMutableArray * arrM;
    NSMutableArray * arrL;
}
@end



@implementation VC_ToDo



- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {

    }
    printf("Called TODO\n");

    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    printf("viewWillAppear\n");
    
    d = [NSUserDefaults standardUserDefaults];
    
    data = [d objectForKey:@"arr"];
    if (data != nil) {
   set = [NSSet setWithArray:@[[NSMutableArray class] , [Note class]]];
    
   arr = (NSMutableArray*)[NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:NULL];
  
    arrH = [NSMutableArray new];
    arrM = [NSMutableArray new];
    arrL= [NSMutableArray new];
   
        int numH = 0, numM = 0, numL = 0;
    
        
    for (int i = 0; i < arr.count; i++) {
        
    if ([[arr[i] piority] isEqual:@"High"])
    {
        
        [arrH addObject:arr[i]];
        [arrH [numH] setNote_id:i];
        [arr[i] setNote_id:i];

        numH++;
        //[arrH insertObject:arr[i] atIndex:i];

    }
   if ([[arr[i] piority] isEqual:@"Medium"])
    {
        
        [arrM addObject:arr[i]];
        [arrM [numM] setNote_id:i];
        [arr[i] setNote_id:i];

        numM++;
        //[arrM insertObject:arr[i] atIndex:i];

    }
  if([[arr[i] piority] isEqual:@"Low"])
    {
        [arrL addObject:arr[i]];
        [arrL [numL] setNote_id:i  ];
        [arr[i] setNote_id:i];

        numL++;

        //[arrL insertObject:arr[i] atIndex:i];

    }
        
        }
   
       
        
       
        
        //override new data
        
        data = [NSKeyedArchiver archivedDataWithRootObject:arr requiringSecureCoding:YES error:NULL];
        
        [d setObject:data forKey:@"arr"];
        
        
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.tableViewTODO reloadData];

}


- (IBAction)btnOpenNewNote:(id)sender {
    add = [self.storyboard instantiateViewControllerWithIdentifier:@"add"];
    
    [self.navigationController pushViewController:add animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUInteger numOfRows = 0;
    switch (section) {
        case 0:
            numOfRows = [arrH count] ;
            break;
        case 1:
            numOfRows =[arrM count];
            break;
        case 2:
            numOfRows =[arrL count];
            break;
       
    }
    
    
    return numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
    
   
    //cell.textLabel.text = @"Hassan";


    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [arrH [arrH.count - indexPath.row -1  ] titleTask];
            cell.imageView.image = [UIImage imageNamed:@"high"];
            break;
            
        case 1:
           // cell.title = [anarray objectAtIndex:(anarray.count - indexPath.row - 1)];

            cell.textLabel.text = [arrM [arrM.count - indexPath.row -1] titleTask];
            cell.imageView.image = [UIImage imageNamed:@"medium"];
            break;
            
        case 2:
            cell.textLabel.text = [arrL [arrL.count - indexPath.row -1] titleTask];
            cell.imageView.image = [UIImage imageNamed:@"low"];
            break;
    }
    
    
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSString * title;
    switch (section) {
        case 0:
            title = @"High Piority";
            break;
       
        case 1:
            title = @"Medium Piority" ;
            break;
        case 2:
            title = @"Low Piority" ;
            break;
    }
    
    return  title;
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    VC_SelectedNote * vcSelected = [self.storyboard instantiateViewControllerWithIdentifier:@"vcSelected"];
    
    switch (indexPath.section) {
        case 0:
            [ vcSelected setNote:arrH[arrH.count - indexPath.row -1]];
            break;
        
        case 1:
            [ vcSelected setNote:arrM[arrM.count - indexPath.row -1]];

            break;
            
        case 2:
            [ vcSelected setNote:arrL[arrL.count - indexPath.row -1]];

            break;
    }
   
    [self.navigationController pushViewController:vcSelected animated:YES];
    
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
       
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are You sure You want to Delete" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction * action = [UIAlertAction actionWithTitle:@"Conform" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            BOOL CHECK = YES;
            int i = 0;
            
        switch (indexPath.section) {
            case 0:
               
                while (CHECK) {
                    if ([self->arr [i] note_id ] == [self->arrH [indexPath.row] note_id])
                    {
                        [self->arr removeObjectAtIndex:i];
                        CHECK = NO;
                    }
                    i++;
                }
                [self->arrH removeObjectAtIndex:self->arrH.count - indexPath.row -1];
                break;
            
            case 1:
                while (CHECK) {
                    if ([self->arr [i] note_id ] == [self->arrM [indexPath.row] note_id])
                    {
                        [self->arr removeObjectAtIndex:i];
                        CHECK = NO;
                    }
                    i++;
                }
                
                [self->arrM removeObjectAtIndex:self->arrM.count - indexPath.row -1];
                break;
            
            case 2:
               
                while (CHECK) {
                    if ([self->arr [i] note_id ] == [self->arrL [indexPath.row] note_id])
                    {
                        [self->arr removeObjectAtIndex:i];
                        CHECK = NO;
                    }
                    i++;
                }
                
                [self->arrL removeObjectAtIndex:self->arrL.count - indexPath.row -1];
                break;
        }
        
            self->data = [NSKeyedArchiver archivedDataWithRootObject:self->arr requiringSecureCoding:YES error:NULL];
            [self->d setObject:self->data forKey:@"arr"];
        

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
        [self.tableViewTODO reloadData];
        }];
        
        
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:NULL];
        
        [alert addAction:action];
        [alert addAction:action2];
        
        
        [self presentViewController:alert animated:YES completion:NULL];
   
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
   
    
}




@end

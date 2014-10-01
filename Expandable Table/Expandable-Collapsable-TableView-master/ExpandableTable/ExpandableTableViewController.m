//
//  ExpandableTableViewController.m
//  ExpandableTable
//
//  Created by Manpreet Singh on 06/12/13.
//  Copyright (c) 2013 Manpreet Singh. All rights reserved.
//

#import "ExpandableTableViewController.h"
#import "ExpandableTableViewCell.h"

@interface ExpandableTableViewController ()
@end



@implementation ExpandableTableViewController
@synthesize pArrMessage,pStrUserId,indexPath;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	NSDictionary *dict=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
	self.items=[dict valueForKey:@"Items"];
	self.itemsInTable=[[NSMutableArray alloc] init];
	[self.itemsInTable addObjectsFromArray:self.items];
    
    NSLog(@"come herer data~~~~~~~~~");

    NSDictionary   *mijnDict = [pArrMessage objectAtIndex:indexPath];
    
    pStrName = [mijnDict objectForKey:@"Name"];
    pStrPartnerUserId = [mijnDict objectForKey:@"Userid"];
    pStrAge = [mijnDict objectForKey:@"Age"];
    pStrState = [mijnDict objectForKey:@"State"];
    pStrCountry = [mijnDict objectForKey:@"Country"];
    pStrMaritalStatus = [mijnDict objectForKey:@"MaritalStatus"];
    pStrWeight = [mijnDict objectForKey:@"Weight"];
    pStrHeight = [mijnDict objectForKey:@"Height"];
    pStrMotherTongue = [mijnDict objectForKey:@"MotherTongue"];
    pStrCity = [mijnDict objectForKey:@"City"];
    pStrComplexion = [mijnDict objectForKey:@"Complexion"];
    pStrPhysicalStatus = [mijnDict objectForKey:@"PhysicalStatus"];
    pStrQualification = [mijnDict objectForKey:@"Qualification"];
    pStrCompany = [mijnDict objectForKey:@"Company"];
    pStrSalary = [mijnDict objectForKey:@"Salary"];
    pStrFamilyType = [mijnDict objectForKey:@"FamilyType"];
    pStrFamilyValue = [mijnDict objectForKey:@"FamilyValue"];
    pStrFamilyStatus = [mijnDict objectForKey:@"FamilyStatus"];
    pStrReligion = [mijnDict objectForKey:@"Religion"];
    pStrRassi = [mijnDict objectForKey:@"Raasi"];
    pStrCommunity = [mijnDict objectForKey:@"Community"];
    pStrStar = [mijnDict objectForKey:@"Star"];
    pStrCooking = [mijnDict objectForKey:@"Cooking"];
    pStrDosam = [mijnDict objectForKey:@"Dosam  "];
    pStrSmoking = [mijnDict objectForKey:@"Smoking"];
    pStrDrinking = [mijnDict objectForKey:@"Drinking"];
    pStrFood = [mijnDict objectForKey:@"Food"];
    pStrHobbies = [mijnDict objectForKey:@"Hobbies"];
    pStrPorutham = [mijnDict objectForKey:@"Porutham"];
    pStrImagePath = [mijnDict objectForKey:@"ImagePath"];
    
    
    NSURL *url = [NSURL URLWithString:pStrImagePath];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *tmpImage = [[UIImage alloc] initWithData:data];
    
    pImgProfilePhoto.image = tmpImage;
    
    pLblName.text = pStrName;
    NSString *pStrUSerIdandAge = pStrPartnerUserId;
    
    pStrUSerIdandAge = [pStrUSerIdandAge stringByAppendingString:@", "];
    pStrUSerIdandAge = [pStrUSerIdandAge stringByAppendingString:pStrAge];
    pStrUSerIdandAge = [pStrUSerIdandAge stringByAppendingString:@" Yrs"];
    pLblAge.text = pStrUSerIdandAge;
    pLblCountry.text = pStrCountry;

}


- (IBAction)fnGoBack:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)fnSendMessage:(id)sender {
    
    iTag = 0;
    
    alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Type Your Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"user pressed Button Indexed 0");
    }
    else
    {
        NSLog(@"%@", [alertView textFieldAtIndex:0].text);
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.dimBackground = YES;
        HUD.delegate = self;
        
        responseData = [NSMutableData data];
        
        NSString *urlRequest = [NSString stringWithFormat:GroupsSendPrivateMessage,pStrUserId,pStrPartnerUserId,[alertView textFieldAtIndex:0].text];
        
        //GroupsSendInterestMessage
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlRequest]];
        // [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

- (IBAction)fnSendInterest:(id)sender {
    
    iTag = 2;
    
    responseData = [NSMutableData data];
    
    NSString *urlRequest = [NSString stringWithFormat:GroupsSendInterestMessage,pStrUserId,pStrPartnerUserId];
    
    //GroupsSendInterestMessage
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlRequest]];
    // [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

//some sort of error, you can print the error or put in some other handling here, possibly even try again but you will risk an infinite loop then unless you impose some sort of limit
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Clear the activeDownload property to allow later attempts
    responseData = nil;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:error.description
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
	[alertView show];
    
}


//connection has finished, thse requestData object should contain the entirety of the response at this point
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"come here data or not~~~~~~~~~~");
    //[connection release];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *pDictValue = [responseString JSONValue];
    
    NSString *pStrAlertMessage;
    
    if (iTag == 2) {
        pStrAlertMessage = [pDictValue objectForKey:@"Status"];
    } else {
        pStrAlertMessage = [pDictValue objectForKey:@"Message"];
    }
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [HUD hide:YES afterDelay:1];
    
    [Utils alert:@"Sucessfully Sent" title:@"Message!"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsInTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Title= [[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    return [self createCellWithTitle:Title image:[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Image name"] indexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.itemsInTable objectAtIndex:indexPath.row];
    if([dic valueForKey:@"SubItems"])
    {
        		NSArray *arr=[dic valueForKey:@"SubItems"];
        		BOOL isTableExpanded=NO;
        
        		for(NSDictionary *subitems in arr )
                {
        			NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
        			isTableExpanded=(index>0 && index!=NSIntegerMax);
        			if(isTableExpanded) break;
        		}
        
        		if(isTableExpanded)
                {
        			[self CollapseRows:arr];
        		}
                else
                {
        			NSUInteger count=indexPath.row+1;
                    NSMutableArray *arrCells=[NSMutableArray array];
        			for(NSDictionary *dInner in arr )
                    {
        				[arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
        				[self.itemsInTable insertObject:dInner atIndex:count++];
        			}
                [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
                }
    }
}

-(void)CollapseRows:(NSArray*)ar
{
	for(NSDictionary *dInner in ar )
    {
		NSUInteger indexToRemove=[self.itemsInTable indexOfObjectIdenticalTo:dInner];
		NSArray *arInner=[dInner valueForKey:@"SubItems"];
		if(arInner && [arInner count]>0)
        {
			[self CollapseRows:arInner];
		}
		
		if([self.itemsInTable indexOfObjectIdenticalTo:dInner]!=NSNotFound)
        {
			[self.itemsInTable removeObjectIdenticalTo:dInner];
			[self.menuTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                    [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                    ]
                                  withRowAnimation:UITableViewRowAnimationLeft];
        }
	}
}

- (UITableViewCell*)createCellWithTitle:(NSString *)title image:(UIImage *)image  indexPath:(NSIndexPath*)indexPath
{
    NSString *CellIdentifier = @"Cell";
    ExpandableTableViewCell* cell = [self.menuTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor grayColor];
        cell.selectedBackgroundView = bgView;
        cell.lblTitle.text = title;
        cell.lblTitle.textColor = [UIColor blackColor];
        
        [cell setIndentationLevel:[[[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
        cell.indentationWidth = 25;
  
        float indentPoints = cell.indentationLevel * cell.indentationWidth;
        
        cell.contentView.frame = CGRectMake(indentPoints,cell.contentView.frame.origin.y,cell.contentView.frame.size.width - indentPoints,cell.contentView.frame.size.height);
        
        NSDictionary *d1=[self.itemsInTable objectAtIndex:indexPath.row] ;
    
        if([d1 valueForKey:@"SubItems"])
        {
            cell.btnExpand.alpha = 1.0;
            [cell.btnExpand addTarget:self action:@selector(showSubItems:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.btnExpand.alpha = 0.0;
        }
        return cell;
}

-(void)showSubItems :(id) sender
{
    UIButton *btn = (UIButton*)sender;
    CGRect buttonFrameInTableView = [btn convertRect:btn.bounds toView:self.menuTableView];
    NSIndexPath *indexPath = [self.menuTableView indexPathForRowAtPoint:buttonFrameInTableView.origin];
    
    if(btn.alpha==1.0)
    {
        if ([[btn imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"down-arrow.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"up-arrow.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"down-arrow.png"] forState:UIControlStateNormal];
        }
        
    }
    
    NSDictionary *d=[self.itemsInTable objectAtIndex:indexPath.row] ;
    NSArray *arr=[d valueForKey:@"SubItems"];
    if([d valueForKey:@"SubItems"])
    {
        BOOL isTableExpanded=NO;
        for(NSDictionary *subitems in arr )
        {
            NSInteger index=[self.itemsInTable indexOfObjectIdenticalTo:subitems];
            isTableExpanded=(index>0 && index!=NSIntegerMax);
            if(isTableExpanded) break;
        }
        
        if(isTableExpanded)
        {
            [self CollapseRows:arr];
        }
        else
        {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arrCells=[NSMutableArray array];
            for(NSDictionary *dInner in arr )
            {
                [arrCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.itemsInTable insertObject:dInner atIndex:count++];
            }
            [self.menuTableView insertRowsAtIndexPaths:arrCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    
    
}


@end

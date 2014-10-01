//
//  ExpandableTableViewController.h
//  ExpandableTable
//
//  Created by Manpreet Singh on 06/12/13.
//  Copyright (c) 2013 Manpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTableViewController : UITableViewController <MBProgressHUDDelegate> {
    NSArray *pArrMessage;
    
    NSString *pStrName,*pStrPartnerUserId,*pStrAge,*pStrState,*pStrCountry,*pStrMaritalStatus,*pStrWeight,*pStrHeight,*pStrMotherTongue,*pStrCity,*pStrComplexion,*pStrPhysicalStatus,*pStrQualification,*pStrCompany,*pStrSalary,*pStrFamilyType,*pStrFamilyValue,*pStrFamilyStatus,*pStrReligion,*pStrRassi,*pStrCommunity,*pStrStar,*pStrCooking,*pStrDosam,*pStrSmoking,*pStrDrinking,*pStrFood,*pStrHobbies,*pStrPorutham,*pStrImagePath,*pStrMessage;
    
    IBOutlet UIImageView *pImgProfilePhoto;
    IBOutlet UILabel *pLblName,*pLblAge,*pLblCountry;
    
    UIAlertView * alert;
    
    MBProgressHUD *HUD;
    
    NSMutableData *responseData;
    NSArray *dicts;
    
    NSString *pStrUserId;
    
    int iTag,indexPath;

}

@property (nonatomic,retain) NSArray *pArrMessage;
@property (nonatomic,retain) NSString *pStrUserId;
@property (nonatomic) int indexPath;

@property(nonatomic,strong) NSArray *items;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;


- (IBAction)fnGoBack:(id)sender;
- (IBAction)fnSendMessage:(id)sender;
- (IBAction)fnSendInterest:(id)sender;



@end

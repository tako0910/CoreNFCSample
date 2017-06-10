//
//  ViewController.h
//  CoreNFCSample
//
//  Created by tako on 2017/06/10.
//  Copyright © 2017年 tako. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreNFC;

@interface ViewController : UIViewController <NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCNDEFReaderSession *ndefSession;

@property (weak, nonatomic) IBOutlet UILabel *labelResult;

@end


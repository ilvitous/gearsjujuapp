//
//  Captuvo+PrivateAPI.h
//  Honeywell_SDK
//
//  Created by Shadow Zhou on 7/12/12.
//  Copyright (c) 2015 Dryrain Technologies. All rights reserved.
//
//#import "Captuvo.h"
/*typedef struct
{
	Byte mfgSignature[4];
   Byte partNumber[18];
   Byte configurationNumber[20];
   Byte serialNumber[10];
   Byte finalAssemblyDate[8];
   Byte odmTrackingNumber[8];

} MfgBlockData;
*/

@interface Captuvo (PrivateAPI)

/**
 @brief This method requests the current battery voltage of the device.

 When this method is called to request the current battery voltage of the device. This data is returned with the <em>-(void)pmBatteryVoltage:(float)voltage</em> delegate method. To track the battery status it is better to use the <em>-(BatteryStatus)requestBatteryStatus</em> method.
 */
-(void)requestBatteryVoltage;


/**
 @brief This method requests the current charge status of a battery.

 When this method is called to request the current charge status of the device. This data is returned with the <em>-(void)pmChargeStatus:(ChargeStatus)chargeStatus</em> delegate method.
 */
-(void)requestChargeStatus;

-(void)requestPMMfgBlockData;

/**
 */
-(ProtocolConnectionStatus)startPMHardware;

/**
 */
-(void)stopPMHardware;

/**

 */
-(void)pmPassThrough:(NSData*)data expectingReturnData:(BOOL)returnData;

-(void)forceBatteryLowShutdown;

-(BOOL)debug;




/**
 update firmware
 */
- (void)updatefirmware:(NSData*)updata;

/**
 enable update firmware
 */
- (void)enableUpdateFirmware ;

/**
    disable Update firmware
 */
- (void)disableUpdateFirmware ;



@end

//
//  Captuvo.h
//  Honeywell_SDK
//
//  Copyright (c) 2015 Honeywell Inc. All rights reserved.

#import <UIKit/UIKit.h>
#import <ExternalAccessory/ExternalAccessory.h>

#define HONEYWELL_DEPRECATED_CAPTUVO(Captuvo_version) __attribute__((deprecated)) //_Captuvo_version Captuvo sled product version.

#define HONEYWELL_AVAILABLE_CAPTUVO(_version) __attribute__((noreturn)) //_version new API in release version.

#pragma mark -
#pragma mark Data Types

/**
 @brief Enumeration for connection status
 */
typedef enum {
   ProtocolConnectionStatusConnected,                                   /**< A successful connection was made */
   ProtocolConnectionStatusAlreadyConnected,                            /**< The protocol is already connected */
   ProtocolConnectionStatusBatteryDepleted,                             /**< The protocol is unable to be connected due to low battery */
   ProtocolConnectionStatusUnableToConnectIncompatibleSledFirmware,    /**< The protocol was unable to be connected due to an error */
   ProtocolConnectionStatusUnableToConnect,                             /**< The protocol was unable to be connected due to an error */
   ProtocolConnectionUnableToConnectNOAccessary,               /**< Protocol connection fail, the Sled was not connected to apple device */
   ProtocolConnectionUnableToConnectNOProtocal,                /**<does not recognize the specified protocol or there was no corressponding Protocal defined in plist or there was an error communicating with the SLed.*/
} ProtocolConnectionStatus;



/*
 @brief Enumeration for current device's decoder HID status
 */
typedef enum {

    HIDActiveLock,              /**<HID Active and locked       */
    HIDActiveUnlock,            /**<HID Active and Unlocked     */
    HIDUnactiveLock,            /**<HID UnActive and Locked     */
    HIDUnactiveUnlock           /**<HID UnActive and Unlocked   */

}HIDCurStatus;

/*
@brief Enumeration for Scan Key status
 */

typedef enum
{
    ScanKeyPressing,            /** Scan Key pressed    */
    ScanKeyReleased,            /** Scan Key released   */
}ScanKeyStatus;

/**
 @brief Enumeration for beeper volume
 */
typedef enum {
   BeeperVolumeLow,                 /**< Low volume */
   BeeperVolumeMedium,              /**< Medium volume */
   BeeperVolumeHigh,                /**< High volume */
   BeeperVolumeOff                  /**< Volume off */
} BeeperVolume;

/**
 @brief Enumeration for beeper pitch
 */
typedef enum {
   BeeperPitchLow,                  /**< Low pitch */
   BeeperPitchMedium,               /**< Medium pitch */
   BeeperPitchHigh                  /**< High pitch */
} BeeperPitch;

/**
 @brief Enumeration for beeper pitch on error
 */
typedef enum {
   BeeperErrorPitchRazz,            /**< Very Low pitch */
   BeeperErrorPitchMedium,          /**< Medium pitch */
   BeeperErrorPitchHigh             /**< High pitch */
} BeeperErrorPitch;

/**
 @brief Enumeration for beeper duration
 */
typedef enum {
   BeeperDurationShort,             /**< Short duration */
   BeeperDurationNormal             /**< Normal duration */
} BeeperDuration;

/**
 @brief Enumeration for selecting what tracts the MSR should read
 */
typedef enum {
   TrackSelectionAnyTrack,             /**< Any Track */
   TrackSelectionRequire1,             /**< Require Track 1 Only */
   TrackSelectionRequire2,             /**< Require Track 2 Only */
   TrackSelectionRequire1and2,         /**< Require Track 1 & Track 2 */
   TrackSelectionRequire3,             /**< Require Track 3 Only */
   TrackSelectionRequire1and3,         /**< Require Track 1 & Track 3 */
   TrackSelectionRequire2and3,         /**< Require Track 2 & Track 3 */
   TrackSelectionRequireAllTracks,     /**< Require All Three Tracks */
   TrackSelectionAnyTrack1or2,         /**< Any Track 1 & 2 */
   TrackSelectionAnyTrack2or3,         /**< Any Track 2 & 3 */
   TrackSelectionUndefined             /**< Error state */
} TrackSelection;


/**
 @brief Enumeration representing the current security level of the MSR
 */
typedef enum{
   SecurityLevel0,
   SecurityLevel1,
   SecurityLevel2,
   SecurityLevel3,
   SecurityLevel4,
   SecurityLevelUndefined
}SecurityLevel;

/*
 @brief Enumeration key management type
 */
typedef enum {
    Fixkeymanagement,
    DUKPTkeymanagement
}KeyManagementType;
/*
 @brief Enumeration Encryption Settings.
 <STX><S><4Ch><01h><Encryption Settings><ETX><CheckSum>
 Encryption Settings:
 "0" Encryption Disabled
 "1" Enable TDES Encryption
 "2" Enable AES Encryption(Not for Raw Data Decoding in Both Directions, send out in other mode.)
 */
typedef enum {
    EncryptionDisabled,
    EnableTDESEncryption,
    EnableAESEncryption
}EncryptionSetting;


/**
 @brief Enumeration for selecting symbologies
 */
typedef enum {
   SymbologyAll,
   SymbologyAustralianPost,
   SymbologyAztecCode,
   SymbologyBritishPost,
   SymbologyCanadianPost,
   SymbologyChinaPost,
   SymbologyChineseSensibleCode,
   SymbologyCodabar,
   SymbologyCodablockA,
   SymbologyCodablockF,
   SymbologyCode11,
   SymbologyCode128,
   SymbologyGS1_128,
   SymbologyCode32Pharmaceutical,
   SymbologyCode39,
   SymbologyCode49,
   SymbologyCode93And93i,
   SymbologyDataMatrix,
   SymbologyEAN13,
   SymbologyEAN13WithAddOn,
   SymbologyEAN13WithExtendedCouponCode,
   SymbologyEAN8,
   SymbologyEAN8WithAddOn,
   SymbologyGS1Composite,
   SymbologyGS1DataBar,
   SymbologyInfoMail,
   SymbologyIntelligentMailBarcode,
   SymbologyInterleaved2Of5,
   SymbologyJapanesePost,
   SymbologyKIXPost,
   SymbologyKoreaPost,
   SymbologyMatrix2Of5,
   SymbologyMaxiCode,
   SymbologyMicroPDF417,
   SymbologyMSI,
   SymbologyNEC2Of5,
   SymbologyOCRMICR,
   SymbologyOCRSEMIFont,
   SymbologyOCRA,
   SymbologyOCRB,
   SymbologyPDF417,
   SymbologyPlanetCode,
   SymbologyPostal4i,
   SymbologyPostnet,
   SymbologyQRCodeAndMicroQRCode,
   SymbologyStraight2Of5IATA,
   SymbologyStraight2Of5Industrial,
   SymbologyTCIFLinkedCode39,
   SymbologyTelepen,
   SymbologyUPCA,
   SymbologyUPCAWithAddOn,
   SymbologyUPCAWithExtendedCouponCode,
   SymbologyUPCE,
   SymbologyUPCEWithAddOn,
   SymbologyUPCE1,
   SymbologyUndefined
} Symbology;


/**
 @brief Enumeration for the state of the battery and charging
 */
typedef enum {
   ChargeStatusNotCharging,         /**< The battery is not connected to external power. */
   ChargeStatusCharging,            /**< Device is connected to an external power source and is charging. */
   ChargeStatusChargeComplete,      /**< Device is connected to an external power but is not charing becuase the battery is full. */
   ChargeStatusUndefined            /**< The status of the battery can not be determined. This is often an error state. */
} ChargeStatus;


/**
 @brief Enumeration for the charge remaining in the battery.
 */
typedef enum {
   BatteryStatusPowerSourceConnected,        /**< Device is connected to a power source */
   BatteryStatus4Of4Bars,                    /**< Battery indicator should read 4 of 4 bars */
   BatteryStatus3Of4Bars,                    /**< Battery indicator should read 3 of 4 bars */
   BatteryStatus2Of4Bars,                    /**< Battery indicator should read 2 of 4 bars */
   BatteryStatus1Of4Bars,                    /**< Battery indicator should read 1 of 4 bars */
   BatteryStatus0Of4Bars,                    /**< Battery indicator should read 0 of 4 bars */
   BatteryStatusUndefined                    /**< Unable to determine the battery level */
} BatteryStatus;

/**
 @brief Enumeration for the Trigger Key status
 */
typedef enum
{

  TriggerKeyStatusEnabled,                    /**< Trigger Key enabled*/
  TriggerKeyStatusDisabled,                   /**< Trigger Key disabled*/
  TriggerKeyStatusChangeSuccessful,           /**< Toggle command successfully executed */
  TriggerKeyStatusChangeFailed,               /**< Toggle command unsuccessfully executed */
  TriggerKeyStatusToggleFeatureUnsupported    /**< Toggle Feature not supported in Firmware */

}TriggerKeyStatus;

/**
 @brief Enumeration for Upgrade frimware result code
 */
typedef enum {
    
    StartSuccessfully = 0,
    SledReadyUpgrade,
    FilePathError,
    FileReadError,
    SecurityError,
    FWPacketError,
    FWUpgradeError,
    SLEDBatteryTooLowToUpgrade
} UPfirmwareResultCode;


#pragma mark -
#pragma mark Symbology Configuration Objects

/**
 @brief Enumeration of the UPC-A extended coupon code settings
 */
typedef enum {
    UPCA_EAN13_ExtendedCouponCodeOff,                       /**< Extended coupon code off */
    UPCA_EAN13_ExtendedCouponCodeAllowConcatenation,        /**< Allow concatenation of the extended coupon code */
    UPCA_EAN13_ExtendedCouponCodeRequireConcatenation       /**< Require concatenation of the extended coupon code */
} UPCA_EAN13_ExtendedCouponCode;


/**
 @brief Enumeration of the PartNumber configuration number serial number
 */

typedef struct
{
	Byte mfgSignature[4];
    Byte partNumber[18];
    Byte configurationNumber[20];
    Byte serialNumber[10];
    Byte finalAssemblyDate[8];
    Byte odmTrackingNumber[8];

} MfgBlockData;

/*
 Sled firmware header struct contain version information, size of firmware file, version, firmware type, build firmware date, time.
 The firmware file header start address 0x26c
 
 unsigned short ver;            // Version information indicator, always KEYBRD_INFO_BASE(2 Bytes)
 unsigned char size;            // Size in bytes of this structure, always 0x34 byte (1 Byte)
 unsigned char version[16];     // 63.00.NB.r49 (16 Bytes)
 unsigned char type;            // Type of firmware: valid value 'b'/'m'/'u'(1 Byte)
 unsigned char date[16];        // eg."May 14 2004" (16 Bytes)
 unsigned char time[16];        // eg."18:00:00" (16 Bytes)
 Above 16X3 + 2 + 1 + 1 = 52, length of header is 52
 */
@interface SledFirmwareHeader : NSObject

@property (assign,nonatomic) NSInteger ver;             // Version information indicator, always KEYBRD_INFO_BASE
@property (assign,nonatomic) NSInteger size;            // Size in bytes of this structure, always 0x34 byte
@property (strong,nonatomic) NSString* version;         // 63.00.NB.r49
@property (strong,nonatomic) NSString* type;            // Type of firmware: valid value 'b'/'m'/'u'
@property (strong,nonatomic) NSString* date;            // eg."May 14 2004"
@property (strong,nonatomic) NSString* time;            // eg."18:00:00"

@end


/**
 @brief UPCA is the object used to configure the UPC-A symbology
 */
@interface UPCA : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL enableCheckDigit;
@property (assign,nonatomic) BOOL enableNumberSystem;
@property (assign,nonatomic) BOOL enable2DigitAddenda;
@property (assign,nonatomic) BOOL enable5DigitAddenda;
@property (assign,nonatomic) BOOL requireAddenda;
@property (assign,nonatomic) BOOL enableAddendaSeparator;
@property UPCA_EAN13_ExtendedCouponCode extendedCouponCode;

@end

/**
 @brief UPCE0 is the object used to configure the UPC-E0 symbology
 */
@interface UPCE0 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL enableExpand;
@property (assign,nonatomic) BOOL requireAddenda;
@property (assign,nonatomic) BOOL enableAddendaSeparator;
@property (assign,nonatomic) BOOL enableCheckDigit;
@property (assign,nonatomic) BOOL enableNumberSystem;
@property (assign,nonatomic) BOOL enable2DigitAddenda;
@property (assign,nonatomic) BOOL enable5DigitAddenda;
@property (assign,nonatomic) BOOL enableUPCE1;

@end

/**
 @brief EAN13 is the object used to configure the EAN 13 symbology
 */
@interface EAN13 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL enableCheckDigit;
@property (assign,nonatomic) BOOL enable2DigitAddenda;
@property (assign,nonatomic) BOOL enable5DigitAddenda;
@property (assign,nonatomic) BOOL requireAddenda;
@property (assign,nonatomic) BOOL enableAddendaSeparator;
@property (assign,nonatomic) BOOL enableISBNtranslate;

@end

/**
 @brief EAN8 is the object used to configure the EAN 8 symbology
 */
@interface EAN8 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL enableCheckDigit;
@property (assign,nonatomic) BOOL enable2DigitAddenda;
@property (assign,nonatomic) BOOL enable5DigitAddenda;
@property (assign,nonatomic) BOOL requireAddenda;
@property (assign,nonatomic) BOOL enableAddendaSeparator;

@end

/**
 @brief Enumeration of the Codabar checks character settings
 */
typedef enum {
    CodabarCheckCharNoCheckChar,                        /**< Disable the check character */
    CodabarCheckCharValidateNotTransmitted,             /**< validate the check character but do not send it with the barcode data */
    CodabarCheckCharValidateAndTransmit                 /**< validate the check character and send it with the barcode data */
} CodabarCheckChar;

/**
 @brief Enumeration of the Codabar concatenation settings
 */
typedef enum {
    CodabarConcatenationOn,                             /**< Concatenation on */
    CodabarConcatenationOff,                            /**< Concatenation off */
    CodabarConcatenationRequired                        /**< Concatenation required */
} CodabarConcatenation;

/**
 @brief Codabar is the object used to configure the Codabar symbology
 */
@interface Codabar : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL transmitStatStopChar;
@property (assign,nonatomic) CodabarCheckChar checkCharStatus;
@property (assign,nonatomic) CodabarConcatenation concatenationStatus;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Enumeration of the Code 39 check character settings
 */
typedef enum {
    Code39CheckCharNoCheckChar,                         /**< Disable the check character */
    Code39CheckCharValidateNotTransmitted,              /**< Vaildate the check character but do not send it with the barcode data */
    Code39CheckCharValidateAndTransmit                  /**< Vaildate the check character and send it with the barcode data */
} Code39CheckChar;

/**
 @brief Code39 is the object used to configure the Code 39 symbology
 */
@interface Code39 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) BOOL transmitStatStopChar;
@property (assign,nonatomic) Code39CheckChar checkCharStatus;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
@property (assign,nonatomic) BOOL enableAppendMode;
@property (assign,nonatomic) BOOL enableCode32Pharmaceutical;
@property (assign,nonatomic) BOOL enableFullASCII;

@end

/**
 @brief Enumeration of the Interleaved2of5 object's check character settings
 */
typedef enum {
    Interleaved2of5CheckCharNoCheckChar,                    /**< Disable the check character */
    Interleaved2of5CheckCharValidateNotTransmitted,         /**< validate the check character but do not send it with the barcode data */
    Interleaved2of5CheckCharValidateAndTransmit             /**< validate the check character and send it with the barcode data */
} Interleaved2of5CheckChar;

/**
 @brief Interleaved2of5 is the object used to configure the Interleaved 2 of 5 symbology
 */
@interface Interleaved2of5 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) Interleaved2of5CheckChar checkCharStatus;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Enumeration of the NEC2of5CheckChar object's check character settings
 */
typedef enum {
    NEC2of5CheckCharNoCheckChar,                            /**< Disable the check character */
    NEC2of5CheckCharValidateNotTransmitted,                 /**< validate the check character but do not send it with the barcode data */
    NEC2of5CheckCharValidateAndTransmit                     /**< validate the check character and send it with the barcode data */
} NEC2of5CheckChar;

/**
 @brief NEC2of5 is the object used to configure the NEC 2 of 5 symbology
 */
@interface NEC2of5 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) NEC2of5CheckChar checkCharStatus;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Code93 is the object used to configure the Code 93 symbology
 */
@interface Code93 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Straight2of5Industrial is the object used to configure the Straight 2 of 5 Industrial symbology
 */
@interface Straight2of5Industrial : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Straight2of5IATA is the object used to configure the Straight 2 of 5 IATA symbology
 */
@interface Straight2of5IATA : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Matrix2of5 is the object used to configure the Matrix 2 of 5 symbology
 */
@interface Matrix2of5 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Enumeration of the Code11 object's check digit settings
 */
typedef enum {
    Code11CheckDigit1,              /**< Check digit one */
    Code11CheckDigit2               /**< Check digit two */
} Code11CheckDigit;

/**
 @brief Code11 is the object used to configure the Code 11 symbology
 */
@interface Code11 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
@property (assign,nonatomic) Code11CheckDigit checkDigit;

@end

/**
 @brief Code128 is the object used to configure the Code 128 symbology
 */
@interface Code128 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
@property (assign,nonatomic) BOOL enableISBTconcatenation;

@end

/**
 @brief GS1_128 is the object used to configure the GS1-128 symbology
 */
@interface GS1_128 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end


/**
 @brief Enumeration of the Telepen object's output settings
 */
typedef enum {
    TelepenOutputAIM,               /**< AIM Telepen output */
    TelepenOutputOriginal           /**< Original Telepen output */
} TelepenOutput;

/**
 @brief Telepen is the object used to configure the Telepen symbology
 */
@interface Telepen : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
@property (assign,nonatomic) TelepenOutput output;

@end

/**
 @brief Enumeration of the MIS object's check character settings
 */
typedef enum {
    MSICheckCharValidateType10NotTransmitted,                   /**< Validate type 10 but do not transmit with barcode data */
    MSICheckCharValidateType10AndTransmit,                      /**< Validate type 10 and transmit with barcode data */
    MSICheckCharValidate2Type10NotTransmitted,                  /**< Validate 2 type 10 characters but do not transmit with barcode data */
    MSICheckCharValidate2Type10AndTransmit,                     /**< Validate 2 type 10 characters and transmit with barcode data */
    MSICheckCharValidateType10And11NotTransmitted,              /**< Validate type 10 then they 11 characters but do not transmit with barcode data */
    MSICheckCharValidateType10And11AndTransmit,                 /**< Validate type 10 then they 11 characters and transmit with barcode data */
    MSICheckCharDisableCeckChar                                 /**< Disasble check characters */
} MSICheckChar;

/**
 @brief MSI is the object used to configure the MSI symbology
 */
@interface MSI : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
@property (assign,nonatomic) MSICheckChar checkChar;

@end

/**
 @brief Enumeration of the GS1 global emulation settings
 */
typedef enum {
   GS1Emulation128,                                             /**< GS1-128 emulation */
   GS1EmulationdDatabar,                                        /**< GS1 DataBar emulation */
   GS1EmulationdExpansionCodeOff,                               /**< GS1 Code Expansion off */
   GS1EmulationdEAN8toEAN13Conversion,                          /**< EAN8 to EAN13 conversion */
   GS1EmulationdOff                                             /**< Emulation off */
} GS1Emulation;

/**
 @brief GS1DataBarOmnidirectional is the object used to configure the GS1 DataBar Omnidirectional symbology
 */
@interface GS1DataBarOmnidirectional : NSObject

@property (assign,nonatomic) BOOL enabled;
//Global GS1 parameters
@property (assign,nonatomic) BOOL enableGS1CompositeCodes;
@property (assign,nonatomic) BOOL enableUPC_EANversion;
@property (assign,nonatomic) int compositeCodeMinMessageLength;
@property (assign,nonatomic) int compositeCodeMaxMessageLength;
@property (assign,nonatomic) GS1Emulation emulationMode;
@end

/**
 @brief GS1DataBarLimited is the object used to configure the GS1 DataBar Limited symbology
 */
@interface GS1DataBarLimited : NSObject

@property (assign,nonatomic) BOOL enabled;
//Global GS1 parameters
@property (assign,nonatomic) BOOL enableGS1CompositeCodes;
@property (assign,nonatomic) BOOL enableUPC_EANversion;
@property (assign,nonatomic) int compositeCodeMinMessageLength;
@property (assign,nonatomic) int compositeCodeMaxMessageLength;
@property (assign,nonatomic) GS1Emulation emulationMode;

@end

/**
 @brief GS1DataBarExpanded is the object used to configure the GS1 DataBar Expanded symbology
 */
@interface GS1DataBarExpanded : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;
//Global GS1 parameters
@property (assign,nonatomic) BOOL enableGS1CompositeCodes;
@property (assign,nonatomic) BOOL enableUPC_EANversion;
@property (assign,nonatomic) int compositeCodeMinMessageLength;
@property (assign,nonatomic) int compositeCodeMaxMessageLength;
@property (assign,nonatomic) GS1Emulation emulationMode;

@end

/**
 @brief CodablockA is the object used to configure the Codablock A symbology
 */
@interface CodablockA : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief CodablockF is the object used to configure the Codablock F symbology
 */
@interface CodablockF : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief PDF417 is the object used to configure the PDF417 symbology
 */
@interface PDF417 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief ChineseSensible is the object used to configure the Chinese Sensible symbology
 */
@interface ChineseSensible : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief Aztec is the object used to configure the Aztec symbology
 */
@interface Aztec : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief MaxiCode is the object used to configure the MaxiCode symbology
 */
@interface MaxiCode : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief DataMatrix is the object used to configure the Data Matrix symbology
 */
@interface DataMatrix : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief MicroPDF417 is the object used to configure the MicroPDF417 symbology
 */
@interface MicroPDF417 : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end

/**
 @brief TCIFLinkedCode39 is the object used to configure the TCIF Linked Code 39 symbology
 */
@interface TCIFLinkedCode39 : NSObject

@property (assign,nonatomic) BOOL enabled;

@end

/**
 @brief QRCode is the object used to configure the QR Code symbology
 */
@interface QRCode : NSObject

@property (assign,nonatomic) BOOL enabled;
@property (assign,nonatomic) int minMessageLength;
@property (assign,nonatomic) int maxMessageLength;

@end


/*
 @brief cupertinoBatteryCharger is the object used to setting Cupertino battery charging for Apple device
 1.enable, Cupertino can charge for Apple device. enable=NO, Cupertino can NOT charge for Apple device(YES/NO).
 2.start: it means Apple device battery percentage is lower than "start" value, Cupertino battery start charging for Apple device(%).
 3.stop: it means Apple device battery percentage is higher than "stop" value, Cupertino battery stop charging for Apple device(%).
 4.sledminLimitPower: it means Cupertino battery percentage is too low to charging for Apple device(%).
 */
@interface cupertinoBatteryCharger : NSObject
@property (nonatomic,assign) BOOL enable;
@property (nonatomic,assign) UInt8 start;
@property (nonatomic,assign) UInt8 stop;
@property (nonatomic,assign) UInt8 sledminLimitPower;
@end

/*
 @brief cupertinoBatteryDetailInfo is the object which include the Cupertino battery detail information
 Valid data:-provide if the Cupertino battery is valid or not(YES/NO).
 Percentage:-provide the current Cupertino battery percentage(%).
 Remaining Capacity mAh:-provide the Cupertino battery current remaining capacity(mAh).
 Total Capacity mAh:-provide the Cupertino battery total capacity(mAh).
 Temperture:-provide the Cupertino battery temperure use Kelvin(K).
 Voltage:-provide the Cupertino battery current voltage(V).
 */
@interface cupertinoBatteryDetailInfo : NSObject
@property (nonatomic,assign) BOOL valid ;
@property (nonatomic,assign) UInt16 percentage ;
@property (nonatomic,assign) UInt16 remainCapacity;
@property (nonatomic,assign) UInt16 totalCapacity;
@property (nonatomic,assign) CGFloat temperture ;
@property (nonatomic,assign) CGFloat voltage ;
@end

/*
 @brief cupertinoBatteryChargingInfo is the object which is the Cupertino device with external power related.
 isExternalPowerPlugin:-Cupertino has been plugined by external power or not(YES/NO).
 isChargingforCupertino: -External pwer charging for Cupertino or not(YES/NO).
 //isChargingforAppledevice:-Cupertino is charging for Apple device or not. this property is too confuse user that want to remove it(YES/NO).
 reserved: -This byte reserved, that will be used(YES/NO).
 */
@interface cupertinoBatteryChargingInfo : NSObject
@property (nonatomic,assign)BOOL isExternalPowerPlugin;
@property (nonatomic,assign)BOOL isChargingforCupertino;
//@property (nonatomic,assign)BOOL isChargingforAppledevice;
@property (nonatomic,assign)BOOL reserved;
@end


/*
 @brief LedSchemeResponse is the object which include the Led scheme configuration response info
 LedScheme:-provide two scheme that can be used.
 scheme:-  which scheme are trying to configure
 bConfigSuccess- indicate whether or not configure successfully
 */

@interface LedSchemeResponse : NSObject

typedef enum {
    DefaultLedScheme,
    AlternateLedScheme
} LedScheme;

@property (nonatomic,assign) BOOL bConfigSuccess ;
@property (nonatomic,assign) LedScheme scheme ;

@end

#pragma mark -
#pragma mark CaptuvoSDK provided All the Protocol Events
/**
 @brief The protocol that must be implemented to become a SDK delegate.

 Each method defined in the protocol represents a specific response from SDK actions. Each is optional and only needs to be implemented by delegate objects that are interested in the specific response.
  */
@protocol CaptuvoEventsProtocol <NSObject>

@optional

/**
 @brief This delegate method is called when the Captuvo hardware connects to the iOS device.
 */
-(void)captuvoConnected;//

/**
 @brief This delegate method is called when the Captuvo hardware disconnects from the iOS device.
 */
-(void)captuvoDisconnected;//

/**
 */
- (void)decoderReady;

/**
 */
- (void)msrReady;

/**
 */
- (void)pmReady ;

#pragma mark decoder delegates
/**
 @brief This delegate method is called when the decoder read string data from a barcode.

 */
-(void)decoderDataReceived:(NSString*)data;//


/**
 @brief This delegate method is called when the decoder reads raw data from a barcode.

 */
-(void)decoderRawDataReceived:(NSData*)data;//


/**
 @brief This delegate method is called when the decoder revision is requested.

 The delegate message passes the decoder revision data from the <em>-(void)requestDecoderRevision</em> method. This revision number is for the decoder subsystem in the device.

 */
-(void)decoderRevisionReceived:(NSString*)revision;//

/**
 @brief This delegate method is called when the decoder software revision is requested.

 The delegate message passes the decoder software revision data from the <em>-(void)requestDecoderSoftwareRevision</em> method. This revision number is for the decoder software on the device.

 */
-(void)decoderSoftwareRevision:(NSString*)revision;//

/**
 @brief This delegate method is called when the decoder driver revision is requested.

 The delegate message passes the decoder driver revision data from the <em>-(void)requestDecoderDriverRevision</em> method. This revision number is for the decoder driver for the device.

 */
-(void)decoderDriverRevision:(NSString*)revision;//

/**
 @brief This delegate method is called when the decoder driver revision is requested.

 The delegate message passes the decoder serial number data from the <em>-(void)requestDecoderSerialNumber</em> method. This decoder serial number is for the decoder serial number of the device.

 */
-(void)decoderSerialNumber:(NSString*)seralNumber;//


/**
 @brief This delegate method is called when the decoder driver revision is requested.
 
 The delegate message passes the engine serial number data from the <em>-(void)requestEngineSerialNumber</em> method. This engine serial number is for the engine serial number of the device.
 
 */
-(void)EngineSerialNumber:(NSString*)seralNumber;

/**
 @brief This delegate method is called when the status of the beep for a good read is requested.

 The delegate message passes the status of the good read beeper. It is requested from the <em>-(void)requestDecoderBeeperForGoodReadStatus</em> method.

 */
-(void)decoderBeeperForGoodReadStatus:(BOOL)isEnabled;//

/**
 @brief This delegate method is called when the status of the trigger click is requested.

 The delegate message passes the status of the trigger click. It is requested from the <em>-(void)requestDecoderTriggerClickStatus</em> method.

 */
-(void)decoderTriggerClickStatus:(BOOL)isEnabled;//

/**
 @brief This delegate method is called when the status of the power up beep is requested.

 The delegate message passes the status of the power up beep. It is requested from the <em>-(void)requestDecoderPowerUpBeepStatus</em> method.

 */
-(void)decoderPowerUpBeepStatus:(BOOL)isEnabled;//

/**
 @brief This delegate method is called when the volume of the beeper is requested for a good read.

 The delegate message passes the volume of the beeper on a good read. It is requested from the <em>-(void)requestDecoderGoodReadBeeperVolumeStatus</em> method.

 */
-(void)decoderGoodReadBeeperVolumeStatus:(BeeperVolume)volume;//

/**
 @brief This delegate method is called when the pitch of the beeper is requested for a good read.

 The delegate message passes the pitch of the beeper on a good read. It is requested from the <em>-(void)requestDecoderBeeperPitchGoodReadStatus</em> method.

 */
-(void)decoderBeeperPitchGoodReadStatus:(BeeperPitch)pitch;//

/**
 @brief This delegate method is called when the pitch of the beeper after an error is requested.

 The delegate message passes the pitch of the beeper after an error. It is requested from the <em>-(void)requestDecoderBeeperPitchErrorStatus</em> method.

 */
-(void)decoderBeeperPitchErrorStatus:(BeeperErrorPitch)pitch;//

/**
 @brief This delegate method is called when the duration of the beeper after a good read is requested.

 The delegate message passes the duration of the beeper after a good read. It is requested from the <em>-(void)requestDecoderBeeperDurationGoodReadStatus</em> method.

 */
-(void)decoderBeeperDurationGoodReadStatus:(BeeperDuration)duration;//

/**
 @brief This delegate method is called when the number of beeps after a good read is requested.

 The delegate message passes the number of beeps after a good read. It is requested from the <em>-(void)requestDecoderNumberOfBeepsGoodReadStatus</em> method.

 */
-(void)decoderNumberOfBeepsGoodReadStatus:(int)numberOfBeeps;//

/**
 @brief This delegate method is called when the number of beeps after an error is requested.

 The delegate message passes the number of beeps after an error. It is requested from the <em>-(void)requestDecoderNumberOfBeepsErrorStatus</em> method.

 */
-(void)decoderNumberOfBeepsErrorStatus:(int)numberOfBeeps;//

/**
 @brief This delegate method is called when the delay between good reads is requested.

 The delegate message passes the number milliseconds that must pass before a second good read can be done. It is requested from the <em>-(void)requestDecoderGoodReadDelayInMilliSecondsStatus</em> method.

 */
-(void)decoderGoodReadDelayInMilliSecondsStatus:(int)milliseconds;//

/**
 @brief This delegate method is called when the trigger timeout is requested.

 The delegate message passes the trigger timeout in milliseconds. It is requested from the <em>-(void)requestDecoderSerialTriggerTimeoutInMilliSecondsStatus</em> method.

 */
-(void)decoderSerialTriggerTimeoutInMilliSecondsStatus:(int)milliseconds;//

/**
 @brief This delegate method is called when the status of the interlaced aimer is requested.

 The delegate message passes the status of the interlaced aimer. It is requested from the <em>-(void)requestDecoderInterlacedAimerModeStatus</em> method.

 */
-(void)decoderInterlacedAimerModeStatus:(BOOL)isEnabled;//

/**
 @brief This delegate method is called when the status of the preferred symbology setting is requested.

 The delegate message passes the status of if the preferred symbology setting is enabled. It is requested from the <em>-(void)requestDecoderPreferredSymbologyStatus</em> method.

 */
-(void)decoderPreferredSymbologyStatus:(BOOL)isEnabled;//

/**
 @brief This delegate method is called when the high priority symbology is requested.

 The delegate message passes the symbology that is set as high priority. It is requested from the <em>-(void)requestDecoderHighPrioritySymbologyStatus</em> method.

 */
-(void)decoderHighPrioritySymbologyStatus:(Symbology)symbology;//

/**
 @brief This delegate method is called when the low priority symbology is requested.

 The delegate message passes the symbology that is set as low priority. It is requested from the <em>-(void)requestDecoderLowPrioritySymbologyStatus</em> method.

 */
-(void)decoderLowPrioritySymbologyStatus:(Symbology)symbology;//

/**
 @brief This delegate method is called when the preferred symbology timeout is requested.


 */
-(void)decoderPreferredSymbologyTimeoutInMilliSecondsStatus:(int)milliseconds;//


-(void)decoderCenteringStatus:(BOOL)isEnabled;//


-(void)decoderTopOfCenteringWindowLocation:(int)locationAsPrecent;//


-(void)decoderBottomOfCenteringWindowLocation:(int)locationAsPrecent;//

/**
 @brief This delegate method is called when the left of the centering window location is requested.


 */
-(void)decoderLeftOfCenteringWindowLocation:(int)locationAsPrecent;//


-(void)decoderRightOfCenteringWindowLocation:(int)locationAsPrecent;//

/**
 @brief This delegate method is called when data is returned from using the direct pass though method for the decoder.

 The delegate message passes response data from the use of the <em>-(void)decoderPassThrough:(NSData*)data expectingReturnData:(BOOL)returnData</em> method. The data received for this method is directly returned as an NSData.

 */
-(void)decoderPassThroughReturnData:(NSData*)data;//


-(void)DecoderEnhancedManualTriggerMode:(NSData*)data;


/*
  @brief This delegate method is called when call enableTriggerKey or disableTriggerKey to enable/disable trigger key.
 
 The delegate message passes response data from the use of the <em>enableTriggerKey/em> method or <em>disableTriggerKey/em> method */
-(void)triggerKey:(TriggerKeyStatus)status;

#pragma mark MSR Delegates

/**
  */
-(void)msrStringDataReceived:(NSString*)data validData:(BOOL)status;//

/**
 
 */
-(void)msrRawDataReceived:(NSData*)data validData:(BOOL)status;//

-(void)msrFirewareVersion:(NSString*)data validData:(BOOL)status;//

-(void)msrSerialNumber:(NSString*)data validData:(BOOL)status;//

-(void)msrCurrentTrackSelection:(TrackSelection)trackSelection validData:(BOOL)status;

-(void)msrCurrentSecurityLevel:(SecurityLevel)securityLevel validData:(BOOL)status;


-(void)msrPassThroughReturnData:(NSData*)data;

#pragma mark PM Delegates


-(void)pmChargeStatusChange:(ChargeStatus)newChargeStatus;//



-(void)pmBatteryStatusChange:(BatteryStatus)newBatteryStatus;//

/**
 @brief This delegate method is called when the battery is critically low.

 This delegate method is called when the remaining battery life reaches a critically state. This delegate method will get called repeatedly while the battery remains critically low and not connected to an external power source. Every app should respond to this delegate method
 */
-(void)pmLowBatteryWarning;

/**
 @brief This delegate method is called when the battery is no longer able to power the Captuvo device.

 This delegate method is called when the remaining battery life becomes to low to continue powering the Captuvo device. When this occours both the MSR and Decoder will be shutdown. This delegate will be called repeatedly while in this state and not conencted to a external power source. Every app should respond to this delegate method.
 */
-(void)pmLowBatteryShutdown;




-(void)pmMfgBlockData:(MfgBlockData*)blockData;



-(void)stateHID:(HIDCurStatus)status ;


- (void)responseHIDTimeout:(NSInteger)timeout ;


- (void)responseHIDChangedDetail:(NSString*)changedInfo;


- (void)scanKeyAction:(ScanKeyStatus)status ;



- (void)upgradingFirmwareResult:(UPfirmwareResultCode)ResultCode;



- (void) upgradePercent: (CGFloat) percent;


/**
 @brief This method for iOS device UPGRADE FIRMWARE completed.

 After the upgrade all the firmware data completed, this method will be called. It is require by steps method as below:
 <em>- (void)startUpgradefirmware:(NSString*)filePath</em>

 When all data passed to island completed this method will be called.

 */

- (void)upgradeFirmwareCompleted;


/**
 @brief This method is response delegate method for query battery detail information.
 Valid data:-provide if the Cupertino battery is valid or not(YES/NO).
 Percentage:-provide the current Cupertino battery percentage(%).
 Remaining Capacity mAh:-provide the Cupertino battery current remaining capacity(mAh).
 Total Capacity mAh:-provide the Cupertino battery total capacity(mAh).
 Temperture:-provide the Cupertino battery temperure(K).
 Voltage:-provide the Cupertino battery current voltage(V).
 
 When battery protocol ready, It is required by the method as below:<em>-(void) queryBatteryDetailInfo</em> this delegate method will be called
 */
-(void) responseBatteryDetailInformation:(cupertinoBatteryDetailInfo*)batteryInfo HONEYWELL_AVAILABLE_CAPTUVO(3.01);


/**
 @brief This method is response delegate method for query MSR HID Mode.
 When Cupertino sled current MSR HID is activate, the delegate method response isHID = YES, else the isHID = NO.
 */
- (void)responseMSRHIDMode:(BOOL)isHID HONEYWELL_AVAILABLE_CAPTUVO(3.01);

/**
 @brief This method is response delegate method for setLedScheme.
 When invoking setLedScheme, the delegate method response, for more details of LedSchemeResponse,please see the defination of LedSchemeResponse
 */

-(void)responseLedScheme:(LedSchemeResponse*) status HONEYWELL_AVAILABLE_CAPTUVO(3.01);
@end


#pragma mark -
#pragma mark Captuvo SDK

/**
 @brief Main public interface for the Captuvo SDK Library.

 This should be included in all projects that intend to use the Honeywell Captuvo sled. All methods in this SDK should be assumed to not be thread safe. The External Accessory. framework
 */
@interface Captuvo : NSObject


#pragma mark -
#pragma mark General Methods

/**
 @brief This method is used to get the shared instance of the Captuvo object.

 When using this SDK, this is the proper way to initialize and get a reference to a Captuvo object.

 @return A Captuvo object that is shared between all callers of this method.
 */
+(Captuvo*)sharedCaptuvoDevice;//

/**
 @brief This method is used to get the shared instance of the Captuvo object and place the SDK into debug mode with verbose logging.

 This will behave the same as the <em>+ (Captuvo*) sharedCaptuvoDevice</em> method with the addition of placing the SDK into debug mode. This only needs to be called once to enter debug mode. Debug mode can be turned off by using the <em>-(void)enableCaptuvoDebug:(BOOL)enable</em> method.

 @return A Captuvo object that is shared between all callers of this method.
 */
+(Captuvo*)sharedCaptuvoDeviceDebug;//


-(void)enableCaptuvoDebug:(BOOL)enable;

/**
 @brief This method is used to stop active monitor battery status.
 */
- (void)stopbatterymonitor;



-(void)addCaptuvoDelegate:(id<CaptuvoEventsProtocol>)delegate;//


-(void)removeCaptuvoDelegate:(id<CaptuvoEventsProtocol>)delegate;//

/**
 @brief This method returns the name of the device.

 This method will return the name of the device as stored in its firmware.

 @return A NSString that is the name of the device.
 */
-(NSString*)getCaptuvoName;//

/**
 @brief This method returns the model number of the device.

 This method will return the model number of the device as stored in its firmware.

 @return A NSString that is the model number of the device.
 */
-(NSString*)getCaptuvoModelNumber;//

/**
 @brief This method returns the serial number of the device.

 This method will return the unique serial number of the device as stored in its firmware.

 @return A NSString that is the device serial number.
 */
-(NSString*)getCaptuvoSerialNumber;//

/**
 @brief This method returns the firmware revision of the device.

 This method will return the firmware revision of the device.

 @return A NSString that is the device firmware revision.
 */
-(NSString*)getCaptuvoFirmwareRevision;//

/**
 @brief This method returns the hardware revision of the device.

 This method will return the hardware revision of the device.

 @return A NSString that is the device hardware revision.
 */
-(NSString*)getCaptuvoHardwareRevision;//

/**
 @brief This method returns the manufacturer information of the device.

 This method will return the manufacturer information of the device.

 @return A NSString that is the device manufacturer information.
 */
-(NSString*)getCaptuvoManufacturer;//


#pragma mark -
#pragma mark Library Information Methods

/**
 @brief This method returns the build number of the Captuvo SDK library.

 @return A NSString representing the build number.
 */
-(NSString*)getSDKbuildNumber;//

/**
 @brief This method returns the short version number of the Captuvo SDK library.

 This method will return the short version number of the SDK. For example <em>1.0.0</em>.

 @return A NSString representing the short version number.
 */
-(NSString*)getSDKshortVersion;//

/**
 @brief This method returns the full version information of the Captuvo SDK library.

 This method will return the full version information of the SDK. This includes the short version number and the build number. For example <em>1.0.0 20120711</em>.

 @return A NSString representing the full version number.
 */
-(NSString*)getSDKfullVersion;//

#pragma mark -
#pragma mark Decoder Methods


/**
 @brief This method is used to turn on the decoder hardware in the device.

 This must be called before any other decoder methods. Until this method is called the decoder hardware is not initialized. Use <em>-(void)stopDecoderHarware</em> to shut down the decoder hardware

 @return ProtocolConnectionStatus The status of the requested action.
 */
-(ProtocolConnectionStatus)startDecoderHardware;//

/**
 @brief This method is used to turn on the decoder hardware in the device.

 It will retry to turn on the decoder hardware every 250ms until succeeded or timeout.

 This must be called before any other decoder methods. Until this method is called the decoder hardware is not initialized. Use <em>-(void)stopDecoderHarware</em> to shut down the decoder hardware

 @param (double)timeout The time to wait for decoder hardware to reply to the turn on request.

 @return ProtocolConnectionStatus The status of the requested action.
 */
//-(ProtocolConnectionStatus)startDecoderHardware:(double)timeout;//
- (void)startDecoderHardware:(double)timeout;
/**
 @brief This method is used to turn off the decoder hardware in the device.

 Once this method is called the decoder hardware is inactivated. No scanning methods can be called until <em>-(void) startDecoderHardware</em> is called again to re-initialize the decoder hardware
 */
-(void)stopDecoderHardware;//

/**
 @brief This method is used to determine if the decoder hardware is currently running.

 This method is used to determine if the decoder is currently running. It can be started and stopped with the methods <em>-(void)startDecoderHardware</em> and <em>-(void)stopDecoderHarware</em> respectively.

 @return BOOL YES if the decoder is running.
 */
-(BOOL)isDecoderRunning;

/**
 @brief This method is used to start scanning for a barcode.

 This method enables the scanner to be controlled by software. Once this command is sent the scanner will search for a barcode until either it finds one, time-outs or the <em>-(void)stopDecoderScanning</em> method is called.

 */
-(void)startDecoderScanning;//

/**
 @brief This method is used to stop the scanning.

 This method can be used to stop the scanner after the <em>-(void)startDecoderScanning</em> was called. If the decoder is not scanned at the time there will be no effect of this method call.
 */
-(void)stopDecoderScanning;//

/**
 @brief This method is used to enable scanning.

 This method enables the scanner.   The method <em>-(void)disableDecoderScanning</em> should be used to enable scanning.  Calling <em>-(void)disableDecoderScanning</em> does not enable/disable power to the decoder.

 */
-(void)enableDecoderScanning;//


-(void)disableDecoderScanning;//


-(void)enableDecoderPowerUpBeep:(BOOL)enabled;//

/**
 @brief This method is used to request the serial number of the decoder.

 This method is used to request the serial number of decoder from the engine firmware.The result of this method is returned with the <em>--(void)decoderSerialNumber:(NSString*)seralNumber;</em> delegate method.

 */

-(void)requestDecoderSerialNumber;

/**
 @brief This method is used to request the status of the power up beep.

 The power up beep is the noise heard when the decoder hardware is started. This method will request the status of this beep. The result of this method is returned with the <em>-(void)decoderPowerUpBeepStatus:(BOOL)isEnabled</em> delegate method.
 */
-(void)requestDecoderPowerUpBeepStatus;//


-(void)enableDecoderTriggerClick:(BOOL)enabled persistSetting:(BOOL)persist;//

/**
 @brief This method is used to request the status of the trigger click sound.

 The trigger click sound is the a click that is heard when the decoder starts to scan. This method will request the status of this click. The result of this method is returned with the <em>-(void)decoderTriggerClickStatus:(BOOL)isEnabled</em> delegate method.
 */
-(void)requestDecoderTriggerClickStatus;//


-(void)enableDecoderBeeperForGoodRead:(BOOL)enable persistSetting:(BOOL)persist;//

/**
 @brief This method is used to request the status of the beeper after a successful read.

 After the decoder successfully scans a barcode it may make a beep sound. This method requests the status of the beep setting. The result of this method is returned with the <em>-(void)decoderBeeperForGoodReadStatus:(BOOL)isEnabled</em> delegate method.
 */
-(void)requestDecoderBeeperForGoodReadStatus;//


-(void)setDecoderGoodReadBeeperVolume:(BeeperVolume)beeperVolume persistSetting:(BOOL)persist;//

/**
 @brief This method is used to request the volume of the beeper after a successful read.

 After the decoder successfully scans a barcode it may make a beep sound. This method requests the volume of this beep. The result of this method is returned with the <em>-(void)decoderGoodReadBeeperVolumeStatus:(BeeperVolume)volume</em> delegate method.
 */
-(void)requestDecoderGoodReadBeeperVolumeStatus;//


-(void)setDecoderBeeperPitchGoodRead:(BeeperPitch)beeperPitch persistSetting:(BOOL)persist;//


-(void)requestDecoderBeeperPitchGoodReadStatus;//


-(void)setDecoderBeeperPitchError:(BeeperErrorPitch)beeperPitch persistSetting:(BOOL)persist;//

-(void)requestDecoderBeeperPitchErrorStatus;//


-(void)setDecoderBeeperDurationGoodRead:(BeeperDuration)beeperDuration persistSetting:(BOOL)persist;//


-(void)requestDecoderBeeperDurationGoodReadStatus;//


-(void)setDecoderNumberOfBeepsGoodRead:(int)numberOfBeeps persistSetting:(BOOL)persist;//


-(void)requestDecoderNumberOfBeepsGoodReadStatus;//



-(void)setDecoderNumberOfBeepsError:(int)numberOfBeeps persistSetting:(BOOL)persist;//


-(void)requestDecoderNumberOfBeepsErrorStatus;//


-(void)setDecoderGoodReadDelayInMilliSeconds:(int)delay persistSetting:(BOOL)persist;//


-(void)requestDecoderGoodReadDelayInMilliSecondsStatus;


-(void)enableDecoderEnhancedManualTriggerMode:(BOOL)enable persistSetting:(BOOL)persist;//


-(void)setDecoderSerialTriggerTimeoutInMilliSeconds:(int)timeout persistSetting:(BOOL)persist;//


-(void)requestDecoderSerialTriggerTimeoutInMilliSecondsStatus;


-(void)enableDecoderOptimizationsForMobilePhoneReading:(BOOL)enable persistSetting:(BOOL)persist;//



-(void)enableDecoderInterlacedAimerMode:(BOOL)enable persistSetting:(BOOL)persist;//


-(void)requestDecoderInterlacedAimerModeStatus;//

-(void)enableDecoderPreferredSymbology:(BOOL)enable persistSetting:(BOOL)persist;//


-(void)requestDecoderPreferredSymbologyStatus;


-(void)setDecoderPreferredSymbologyToDefaultPersistSetting:(BOOL)persist;//


-(void)setDecoderPreferredSymbologyTimeoutInMilliSeconds:(int)timeout persistSetting:(BOOL)persist;//


-(void)requestDecoderPreferredSymbologyTimeoutInMilliSecondsStatus;//


-(void)setDecoderHighPrioritySymbology:(Symbology)symbology persistSetting:(BOOL)persist;//


-(void)requestDecoderHighPrioritySymbologyStatus;//


-(void)setDecoderLowPrioritySymbology:(Symbology)symbology persistSetting:(BOOL)persist;//


-(void)requestDecoderLowPrioritySymbologyStatus;//


-(void)enableDecoderCentering:(BOOL)enable persistSetting:(BOOL)persist;//


-(void)requestDecoderCenteringStatus;//


-(void)setDecoderTopOfCenteringWindow:(int)locationAsPercent persistSetting:(BOOL)persist;//


-(void)requestDecoderTopOfCenteringWindowStatus;//


-(void)setDecoderBottomOfCenteringWindow:(int)locationAsPercent persistSetting:(BOOL)persist;//


-(void)requestDecoderBottomOfCenteringWindowStatus;//


-(void)setDecoderLeftOfCenteringWindow:(int)locationAsPercent persistSetting:(BOOL)persist;//


-(void)requestDecoderLeftOfCenteringWindowStatus;//


-(void)setDecoderRightOfCenteringWindow:(int)locationAsPercent persistSetting:(BOOL)persist;//


-(void)requestDecoderRightOfCenteringWindowStatus;//


-(void)requestDecoderRevision;//


-(void)requestDecoderDriverRevision;//


-(void)enableAllSymbologiesPersistSetting:(BOOL)persist;


-(void)enableDecoderAimer:(BOOL)persist;

-(void)disableDecoderAimer:(BOOL)persist;

-(void)enableDecoderIllumination:(BOOL)persist;

-(void)disableDecoderIllumination:(BOOL)persist;


-(void)disableAllSymbologiesPersistSetting:(BOOL)persist;


-(void)setDecoderUPCAConfiguration:(UPCA*)upca persistSetting:(BOOL)persist;


-(void)setDecoderEAN13Configuration:(EAN13*)ean13 persistSetting:(BOOL)persist;


-(void)setDecoderUPCE0Configuration:(UPCE0*)upce0 persistSetting:(BOOL)persist;


-(void)setDecoderEAN8Configuration:(EAN8*)ean8 persistSetting:(BOOL)persist;

-(void)setDecoderCodabarConfiguration:(Codabar*)codabar persistSetting:(BOOL)persist;

-(void)setDecoderCode39Configuration:(Code39*)code39 persistSetting:(BOOL)persist;


-(void)setDecoderInterleaved2of5Configuration:(Interleaved2of5*)interleaved2of5 persistSetting:(BOOL)persist;


-(void)setDecoderNEC2of5Configuration:(NEC2of5*)nec2of5 persistSetting:(BOOL)persist;


-(void)setDecoderCode93Configuration:(Code93*)code93 persistSetting:(BOOL)persist;


-(void)setDecoderStraight2of5IndustrialConfiguration:(Straight2of5Industrial*)straight2of5Industrial persistSetting:(BOOL)persist;


-(void)setDecoderStraight2of5IATAConfiguration:(Straight2of5IATA*)straight2of5IATA persistSetting:(BOOL)persist;


-(void)setDecoderMatrix2of5Configuration:(Matrix2of5*)matrix2of5 persistSetting:(BOOL)persist;


-(void)setDecoderCode11Configuration:(Code11*)code11 persistSetting:(BOOL)persist;


-(void)setDecoderCode128Configuration:(Code128*)code128 persistSetting:(BOOL)persist;


-(void)setDecoderGS1_128Configuration:(GS1_128*)gs1_128 persistSetting:(BOOL)persist;


-(void)setDecoderTelepenConfiguration:(Telepen*)telepen persistSetting:(BOOL)persist;


-(void)setDecoderMSIConfiguration:(MSI*)msi persistSetting:(BOOL)persist;


-(void) setDecoderGS1DataBarOmnidirectionalConfiguration: (GS1DataBarOmnidirectional*) gs1DataBarOmnidirectional persistSetting: (BOOL)persist;


-(void)setDecoderGS1DataBarLimitedConfiguration:(GS1DataBarLimited*)gs1DataBarLimited persistSetting:(BOOL)persist;


-(void)setDecoderGS1DataBarExpandedConfiguration:(GS1DataBarExpanded*)gs1DataBarExpanded persistSetting:(BOOL)persist;


-(void)setDecoderCodablockAConfiguration:(CodablockA*)codablockA persistSetting:(BOOL)persist;

-(void)setDecoderCodablockFConfiguration:(CodablockF*)codablockF persistSetting:(BOOL)persist;


-(void)setDecoderPDF417Configuration:(PDF417*)pdf417 persistSetting:(BOOL)persist;



-(void)setDecoderDataMatrixConfiguration:(DataMatrix*)dataMatrix persistSetting:(BOOL)persist;


-(void)setDecoderMaxiCodeConfiguration:(MaxiCode*)maxiCode persistSetting:(BOOL)persist;

-(void)setDecoderAztecConfiguration:(Aztec*)aztec persistSetting:(BOOL)persist;


-(void)setDecoderChineseSensibleConfiguration:(ChineseSensible*)chineseSensible persistSetting:(BOOL)persist;


-(void)setDecoderMicroPDF417Configuration:(MicroPDF417*)microPDF417 persistSetting:(BOOL)persist;

-(void)setDecoderTCIFLinkedCode39Configuration:(TCIFLinkedCode39*)tcifLinkedCode39 persistSetting:(BOOL)persist;


-(void)setDecoderQRCodeConfiguration:(QRCode*)qrCode persistSetting:(BOOL)persist;


-(void)requestDecoderSoftwareRevision;//




- (void)requestEngineSerialNumber;

-(void)decoderPassThrough:(NSData*)data expectingReturnData:(BOOL)returnData;

/**
 @brief This method is used to erase all your settings and reset the engine to the original factory defaults.

 This method is used to erase all your settings and reset the engine to the original factory defaults. We should be careful to use this interface.
 */
-(void)FactoryResetting;

#pragma mark -
#pragma mark MSR Methods

/**
 @brief This method is used to turn on the MSR hardware in the device.

 This must be called before any other MSR methods. Until this method is called the MSR hardware is not initialized. Use -stopMSRHarware to shut down the MSR hardware.

 @return ProtocolConnectionStatus The status of the requested action.
 */
-(ProtocolConnectionStatus)startMSRHardware;//

/**
 @brief This method is used to turn on the MSR hardware in the device.

 It will retry to turn on the MSR hardware every 250ms until succeeded or timeout.

 This must be called before any other MSR methods. Until this method is called the MSR hardware is not initialized. Use -stopMSRHarware to shut down the MSR hardware.

 @param (double)timeout The time to wait for decoder hardware to reply to the turn on request.

 @return ProtocolConnectionStatus The status of the requested action.
 */
//-(ProtocolConnectionStatus)startMSRHardware:(double)timeout;//
- (void)startMSRHardware:(double)timeout ;
/**
 @brief This method is used to turn off the MSR hardware in the device.

 Once this method is called the MSR hardware is inactivated. No MSR methods can be called until -startMSRHardware is called again to re-initialize the MSR hardware.
 */
-(void)stopMSRHardware;//

/**
 @brief This method is used to determine if the MSR hardware is currently running.

 This method is used to determine if the MSR is currently running. It can be started and stopped with the methods <em>-(void)startMSRHardware</em> and <em>-(void)stopMSRHarware</em> respectivly.

 @return BOOL YES if the MSR is running.
 */
-(BOOL)isMSRRunning;

/**
 @brief This method places the MSR reader in an enabled state.

 When this method is called the MSR reader will be active and will return data to its delegates when a card is swiped through the MSR reader.
 */
-(void)enableMSRReader;//

/**
 @brief This method places the MSR reader in a un-enabled state.

 When this method is called the MSR reader will be deactivated and will not read any data from the cards when swiped.
 */
-(void)disableMSRReader;//

/**
 @brief This method requests the firmware version of the MSR hardware.

 When this method is called a request is sent to the MSR hardware for its firmware version. This data is returned with the <em>-(void)msrFirewareVersion:(NSString*)data validData:(BOOL)status</em> delegate method.
 */
-(void)requestMSRFirmwareVersion;//

/**
 @brief This method requests the serial number from the MSR hardware.

 When this method is called a request is sent to the MSR hardware from its serial number. This data is returned with the <em>-(void) msrSerialNumber: (NSString*) data validation: (BOOL) status</em> delegate method.
 */
-(void)requestMSRSerialNumber;//


-(void)setMSRTrackSelection:(TrackSelection)selection;//

/**
 @brief This method requests the security level from the MSR hardware.

 When this method is called a request is sent to the MSR hardware for its current security level. This data is returned to the <em>-(void)msrCurrentSecurityLevel:(SecurityLevel)securityLevel validData:(BOOL)status</em> delegate method.
 */
-(void)requestMSRSecurityLevel;

/**
 @brief This method requests the track settings for the MSR hardware.

 When this method is called a request is sent to the MSR hardware for the current tacks that the device will read. This data is returned to the <em>-(void)msrCurrentTrackSelection:(TrackSelection)trackSelection validData:(BOOL)status</em> delegate method.
 */
-(void)requestMSRTrackSettings;


-(void)msrPassThrough:(NSData*)data expectingReturnData:(BOOL)returnData;

#pragma mark -
#pragma mark Power Management Methods

/**
 @brief This method is used to get the current charging status.

 This can be called to get the current status of the battery charging

 @return ChargeStatus The status of the battery charging.
 */
-(ChargeStatus)getChargeStatus;//

/**
 @brief This method is used to get the current remaining battery life.

 This can be called to get the current status of battery life remaining.

 @return BatteryStatus The current status of the battery.
 */
-(BatteryStatus)getBatteryStatus HONEYWELL_DEPRECATED_CAPTUVO(3.01); //

#pragma mark -
#pragma mark Mfg Block Data
/**
 @brief This method requests the current battery voltage of the device.

 When this method is called to request the current battery voltage of the device. This data is returned with the <em>-(void)pmBatteryVoltage:(float)voltage</em> delegate method. To track the battery status it is better to use the <em>-(BatteryStatus)requestBatteryStatus</em> method.
 */
-(void)requestBatteryVoltage;


/*
@brief This method set the current battery threshold Min/Max voltage of the device.

 When this method is called to set the threshold current battery voltage of the device. the Min voltage is the Captuvo(SLXX) device will charge battery for iOS devices(when it battery lower than Min voltage).
 When iOS devices battery is higher than the Max voltage, which set threshold Max voltage value, the Captuvo(SLXX) will not charge battery for iOS devices any more.

 When this method isn't called, Captuvo(SL42 Model A) will charging battery default, no matter the iOS devices' battery lower than Min voltage/Max voltage.

*/
-(void)setChargeBatteryThreshold:(int)min mx:(int)max ;


/**
 @brief This method requests the current charge status of a battery.

 When this method is called to request the current charge status of the device. This data is returned with the <em>-(void)pmChargeStatus:(ChargeStatus)chargeStatus</em> delegate method.
 */
-(void)requestChargeStatus;

/**
 @brief This method requests the current device manufacture information.

 When this method is called to request the current charge status of the device. This data is returned with the <em>-(void)pmChargeStatus:(ChargeStatus)chargeStatus</em> delegate method.
 */

-(void)requestPMMfgBlockData;

/**
 @brief This method start the current sled open power manager protocol.
 
 When this method is called, sled's current battery status/battery voltage can be managerment.
 */
-(ProtocolConnectionStatus)startPMHardware;

/**
 @brief This method start the current sled open power manager protocol with timeout.
 
 When this method is called, sled's current battery status/battery voltage can be managerment, this time out means wait for a few seconds to start.
 */
-(void)startPMHardware:(double)timeout;

/**
 @brief This method stop the current sled to close power manager protocol.
 
 When this method is called, sled's will close power manager protocol, uplayer application can NOT do battery operator.
 */
-(void)stopPMHardware;


/**
 @brief This method force sled do NOT working when the battery is too low to working.
 
 When this method is called, sled will stop all protocols.
 
 Waring:This method must cautious to use, it will stop all protocols between sled with iOS device
 */
-(void)forceBatteryLowShutdown HONEYWELL_DEPRECATED_CAPTUVO(3.01);

/**
 @brief This method set CaptuvoSDK enable debug.
 
 When this method is called, note the CaptuvoSDK enable debug, since sled hardware reasons it can NOT debug.
 */
-(BOOL)debug;


/**
 Enable Query Battery
 This method is send the apple devices battery value to SL22/SL42, when the battery is lower than setting value(the SL22/SL42 firmware configure threshold battery value), then the SL22/SL42 recognize the current apple devices
 battery is low, the SL22/SL42 auto charging for apple devices

 How to let SL22/SL42 charge battery for iPod/iPhone, should obay the following information:
 SL22/SL42 will charge iPod/iPhone once all the following requirement met.
 1. SDK API enableBatteryQuery is called by iOS application, AND
 2. iPod/iPhone battery percentage <= 13%, AND
 3. iSled battery voltage >= 3.7V

 The charging will stop once any of the following requirement met.
 1.SDK API disableBatteryQuery called by application, OR
 2.iPod/iPhone battery percentage >= 35%, OR
 3.SL22/SL42 battery voltage <= 3.4V
 4. Apple devices enter into suspend state.
 the charging for iOS devices, should keep applications be running in the foreground for this to occur. If the iPod is suspended or the application moves to the background, the battery charging will stop.

 */
- (void)enableBatteryQuery ;

/**
 Disable Query Battery

 When currently the SL22/SL42 is charging for iPod/iPhone, when called this method will stop charging.

 The charging will stop once any of the following requirement met.
 1.SDK API disableBatteryQuery called by application, OR
 2.iPod/iPhone battery percentage >= 35%, OR
 3.SL22/SL42 battery voltage <= 3.4V
 4. Apple devices enter into suspend state.
 The above situations are passive stop charging for Apple devices. if called, this disable battery query, that is active stop charging battery for Apple devices.

 */
- (void)disableBatteryQuery;

/**
 @brief This method active the current device's decoder activate HID function to let it working as HID mode.
 
 HID(Human Interface Device)

 Open Human interface device mode. In this mode, users can scan bar code into any input text controls.
 This mode will waste of battery of Apple devices and SL22/SL42, for these devices never into into suspend.

 How to open this feature should follow below steps:
 1. Initialize the PM protocol hardware.
 2. In PM protocol, call unLockHIDMode
 3. In PM protocol, call activated HID.
 
 When you opened HID feature, user can not open the decoder protocol to receive scan barcode values into iOS application which base on CaptuvoSDK lib develop like(mPOS/PriceCheck/EasyDLDemo).
 */
- (void)activateHID;

/**
 @brief This method requests the current device's decoder HID function switch to un-working.
 
 When this method is called to request the current sled to close the HID function, it will switch to unactive HID mode.
*/
- (void)deActivateHID ;

/**
 @brief This method requests the current device's decoder HID function switch mode to un lock mode.
 
 When this method is called to request the current sled, it will switch the sled from lock mode to unlock mode. When lock mode sled can not been set, else it been unlocked.
 */
- (void)unLockHIDMode;

/**
 @brief This method requests the current device's decoder HID function switch mode to lock mode.
 
 When this method is called to request the current sled, it will switch the sled from unlock mode to unlock mode to keep it locked status, else it easy been changed will cause HID can NOT working.
 
 */
- (void)lockHIDMode;

/**
 @brief This method requests the current device's decoder HID Status of the device.

 When this method is called to request the current HID State of the device. This data is returned with the <em>-(void)stateHID:(HIDCurStatus)status</em> delegate method. To track the HID status it is better to use the <em>-(void)requestHIDStatus</em> method.
 */

- (void)requestHIDStatus;


/*
 @brief This method query the current device's decoder HID timeout value.
 
 When this method is called to request the current HID timeout value. The async method <em>- (void)responseHIDTimeout:(NSInteger)timeout;</em> is delegate method will response user timeout value.
*/
- (void)queryHIDTimeout;

/*
 @brief This method requests the current device's HID setting timeout, the timeout means that the device using HID mode it will auto stop decoder for save battery of sled, when keep pressing 3 seconds of hard key of sled will wakeup of decoder.
 
 The timeout value must >=30seconds and<65535seconds when user setting.
 
 When this method is called to set the current HID setting timeout. It set successed or failed will post to user through the method<em>- (void)responseHIDChangedDetail:(NSString*)changedInfo ;</em> delegate method. 
 To enable the HID mode and set timeout value to sled, it will save sled's battery when user hasn't any action in timeout value time, it will automatic enter into save power mode(Close decoder).
 */
- (void)setHIDTimeout:(int)timeout ;

/**
 @brief This method is used to enable the hard key.
 
 This data is returned with the <em>-(void)triggerKey:(TriggerKeyStatus)status</em> delegate method
 */
-(void)enableTriggerKey;

/**
 @brief This method is used to disable the hard key.
 
 This data is returned with the <em>-(void)triggerKey:(TriggerKeyStatus)status</em> delegate method
 */
-(void)disableTriggerKey;

/**
 @brief This method is used to requre the hard key status.
 */
-(TriggerKeyStatus)requestTriggerKeyStatus;


// following API is just used in iphone6 and 6plus later.
#pragma mark Cupertino Upgrade firmware

/**
**
 @brief This method for iOS device's decoder start to send UPGRADE FIRMWARE data to sled.

 Call this method will let IOS device start to Upgrade firmware, when this Method is called, it can NOT be interrupted and can NOT send any commands to sled, else the upgrade firmware will be broken, the sled will be blocked can NOT work again.

 The file path is the absolute path should make the path can be accessed the file's content, else upgrade firmware method will fail.

 */

- (void)startUpgradefirmware:(NSString*)filePath;


/*
   Get Firmware file header information
 
 Sled firmware header struct contain version information, size of firmware file, version, firmware type, build firmware date, time.
 The firmware file header start address 0x26c
 
 unsigned short ver;            // Version information indicator, always KEYBRD_INFO_BASE(2 Bytes)
 unsigned char size;            // Size in bytes of this structure, always 0x34 byte (1 Byte)
 unsigned char version[16];     // 63.00.NB.r49 (16 Bytes)
 unsigned char type;            // Type of firmware: valid value 'b'/'m'/'u'(1 Byte)
 unsigned char date[16];        // eg."May 14 2004" (16 Bytes)
 unsigned char time[16];        // eg."18:00:00" (16 Bytes)
 Above 16X3 + 2 + 1 + 1 = 52, length of header is 52

 */
-(SledFirmwareHeader*) getFirmwareHeader:(NSString*)filePath HONEYWELL_AVAILABLE_CAPTUVO(3.01);


#pragma mark Cupertino Battery
/**
 @brief This method is for query Cupertino device battery detail information.
 
 Cupertino battery has capability provide for user more information about the battery detail.
 
 This battery information as below:
 Valid data:-provide if the Cupertino battery is valid or not(YES/NO).
 Percentage:-provide the current Cupertino battery percentage(%).
 Remaining Capacity:-provide the Cupertino battery current remaining capacity(mAh)
 Total Capacity:-provide the Cupertino battery total capacity(mAh).
 Temperture:-provide the Cupertino battery temperure use Kelvin(K).
 Voltage:-provide the Cupertino battery current voltage(V).
 This method callback delegate method is the <em>-(void) responseBatteryDetailInformation:(cupertinoBatteryDetailInfo*)batteryInfo;</em>
 */
-(void) queryBatteryDetailInfo HONEYWELL_AVAILABLE_CAPTUVO(3.01);


/**
 @brief This method is set Cupertino battery charge for iOS device battery operate.
 
CupertinoSDK provide this method for user to control the Cupertino battery charge for iOS device.
 The cupertinoBatteryCharge object propertys setting can control the Cupertino battery charging for iOS device operate.
 1.enable= YES, Cupertino can charge for Apple device. enable=NO, Cupertino can NOT charge for Apple device.
 2.start: it means Apple device battery percentage is lower than "start" value, Cupertino battery start charging for Apple device.
 3.stop: it means Apple device battery percentage is higher than "stop" value, Cupertino battery stop charging for Apple device.
 4.sledminLimitPower: it means Cupertino battery percentage is too low to charging for Apple device.
 
 The default value are: enable=YES, start=10%, stop=35%, sledminLimitPower=15%
*/
-(void) setBatteryChargingForAppleDevice:(cupertinoBatteryCharger*)charger HONEYWELL_AVAILABLE_CAPTUVO(3.01);


/**
 @brief This method is set current Cupertino MSR HID function activate or un-activate mode.
 This method parameter activate = YES, enable MSR HID function; activate = NO, disable MSR HID function.
 
 This method only for Cupertino devices, Captuvo device can NOT support.
 */
- (void)setMSRHID:(BOOL)activate ;

/**
 @brief This method is query current device HIS status, if it is activate or un-activate mode
 
 This method callback delegate method is the <em>- (void)responseMSRHIDMode:(BOOL)isHID</em>
 */
- (void)queryMSRHIDMode;

/**
 @brief This method is used to set the led scheme, defaultScheme = yes that means try to set led to DefaultLedScheme, if defaultScheme = NO menas try to set led to AlternateLedScheme
 
 This method callback delegate method is the <em>- (void)responseMSRHIDMode:(BOOL)isHID</em>
 */
- (void)setLedScheme:(BOOL)defaultScheme;



#pragma end

@end

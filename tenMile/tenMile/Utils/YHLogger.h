//
//  YHLogger.h
//  YOHOBoard
//
//  Created by Louis Zhu on 13-1-30.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM (NSInteger, YHLoggerLevel) {
    YHLoggerLevelDoom,          // very very extremely fatal accident that will cause app crashes immediately
    YHLoggerLevelError,         // critical errors
    YHLoggerLevelWarning,       // something goes wrong, may bring on some problems later
    YHLoggerLevelInformation,   // for developers to print their trival informations
    YHLoggerLevelTesting,       // just for test, remove these logs immediately after they have became useless
};


extern NSString * const kYHLoggerTagGeneral;
extern NSString * const kYHLoggerTagTesting;
extern NSString * const kYHLoggerTagNetwork;
extern NSString * const kYHLoggerTagFileOperation;
extern NSString * const kYHLoggerTagTableView;
extern NSString * const kYHLoggerTagViewController;

extern void YHLog(NSString *tag, YHLoggerLevel level, NSString *format, va_list args);
extern void YHLogDoom(NSString *tag, NSString *format, ...);
extern void YHLogError(NSString *tag, NSString *format, ...);
extern void YHLogWarning(NSString *tag, NSString *format, ...);

extern void LZLog(NSString *tag, NSString *format, ...);
extern void LZLogTesting(NSString *format, ...);

extern void SMLog(NSString *tag, NSString *format, ...);
extern void SMLogTesting(NSString *format, ...);

extern void LYLog(NSString *tag, NSString *format, ...);
extern void LYLogTesting(NSString *format, ...);

extern void PLLog(NSString *tag, NSString *format, ...);
extern void PLLogTesting(NSString *format, ...);

extern void SMYLog(NSString *tag, NSString *format, ...);
extern void SMYLogTesting(NSString *format, ...);

extern void HTLog(NSString *tag, NSString *format, ...);
extern void HTLogTesting(NSString *format, ...);

extern void HDDLog(NSString *tag, NSString *format, ...);
extern void HDDLogTesting(NSString *format, ...);


#define LOG_NETWORK(level, ...)    LogMessageF(__FILE__,__LINE__,__FUNCTION__,@"network",level,__VA_ARGS__)
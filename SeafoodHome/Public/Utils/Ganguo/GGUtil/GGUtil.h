//
//  GGGGUtil.h
//  DailyMovieReview
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//


@interface GGUtil : NSObject

+ (NSString *)urlAppendRetina:(NSMutableString *)urlString;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (UIImage *)imageMono:(UIImage *)image ;

+ (UIImage*)cropImage:(UIImage*)img withRect:(CGRect)rect;

+ (CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize;

+ (UIImage *)makeAShotWithView:(UIView*)aView;

+ (NSMutableDictionary *)getClassPropertys:(id)fromClass;

+ (UIColor *)randomColor;

+ (void) showAlert: (NSString *) theMessage title:(NSString *) theTitle;

+ (NSMutableDictionary *)stringToDictionary:(NSString *)sourceString withSeparator:(NSString *)separator;

+ (NSString *)getShowName:(NSString *)username 
            withFirstName:(NSString *)firstName 
             withLastName:(NSString *)lastName;

+ (BOOL)canSendSMS;

+ (NSString *)getDistanceText:(double)distance;

+ (void)storeBadge;

+ (int)getStoredBadge;

+ (void)simulateMemoryWarning;

+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length;

+ (NSString *)timeToText:(NSDate *)time;

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat;

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat;

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale;

+(BOOL)isValidateEmail:(NSString *)email;

+(BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isValidZipcode:(NSString*)value;

+ (NSString*)UUID;

+ (BOOL)hasLaunchBeforeAtThisVersion;

/**
 *  甘豆影评,对评分进行四舍五入和保留两位小数
 */
+ (NSString *)stringByRating:(NSString *)rating;

+ (NSString *)filterHTML:(NSString *)html;

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

@end

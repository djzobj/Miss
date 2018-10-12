//
//  MissDatabaseController.m
//  Miss
//
//  Created by 张得军 on 2018/9/30.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "MissDatabaseController.h"
#import <sqlite3.h>

static sqlite3 *db = nil;

@interface MissDatabaseController ()

@end

@implementation MissDatabaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (sqlite3 *)open {
    if (db) {
        return db;
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docPath stringByAppendingPathComponent:@"MissDB.sqlite"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:sqlPath]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MissDB" ofType:@"sqlite"];
        [fileManager copyItemAtPath:filePath toPath:sqlPath error:nil];
    }
    sqlite3_open([sqlPath UTF8String], &db);
    return db;
}

- (void)close {
    sqlite3_close(db);
    db = nil;
}

- (void)createTable {
    NSString *sql = @"create table if not exists stu (ID integer primary key, name text not null, gender text default '男')";
    sqlite3 *db = [self open];
    int result = sqlite3_exec(db, sql.UTF8String, nil, nil, nil);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    [self close];
}

- (NSArray *)allStudents {
    sqlite3 *db = [self open];
    
    //语句对象
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"select * from Students";
    NSMutableArray *mArray = nil;
    
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
    }
    sqlite3_finalize(stmt);
    return mArray;
}

- (NSObject *)selectStidentBuyID:(int)ID {
    sqlite3 *db = [self open];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"select * from Students where ID = ?";
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, ID);
        if (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cName = sqlite3_column_text(stmt, 1);
            const unsigned char *cGender = sqlite3_column_text(stmt, 2);
            
            NSString *name = [NSString stringWithUTF8String:(const char *)cName];
            NSString *gender = [NSString stringWithUTF8String:(const char *)cGender];
        }
    }
    sqlite3_finalize(stmt);
    return nil;
}

- (void)insertStudentWithID:(NSInteger)ID name:(NSString *)name gender:(NSString *)gender {
    sqlite3 *db = [self open];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "insert into Students values(?,?,?)", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, (int)ID);
        sqlite3_bind_text(stmt, 2, [name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [gender UTF8String], -1, nil);
        
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

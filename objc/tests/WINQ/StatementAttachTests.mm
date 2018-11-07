/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "WINQTestCase.h"
#import <WCDB/WCDB.h>

@interface StatementAttachTests : WINQTestCase

@end

@implementation StatementAttachTests {
    NSString* path;
    WCDB::Expression expression;
    WCDB::Schema schema;
}

- (void)setUp
{
    [super setUp];
    path = @"testPath";
    expression = path;
    schema = @"testSchema";
}

- (void)test_default_constructible
{
    WCDB::StatementAttach constructible __attribute((unused));
}

- (void)test_get_type
{
    XCTAssertEqual(WCDB::StatementAttach().getType(), WCDB::SQL::Type::AttachSTMT);
    XCTAssertEqual(WCDB::StatementAttach::type, WCDB::SQL::Type::AttachSTMT);
}

- (void)test_attach
{
    auto testingSQL = WCDB::StatementAttach().attach(expression).as(schema);

    auto testingTypes = { WCDB::SQL::Type::AttachSTMT, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Schema };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"ATTACH 'testPath' AS testSchema");
}

@end

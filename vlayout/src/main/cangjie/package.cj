/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package vlayout4cj

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.hilog.*
internal import ohos.display.*

internal import encoding.json.*
internal import std.convert.*

extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}
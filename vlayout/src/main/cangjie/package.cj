/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package vlayout4cj

internal import ohos.base.*
internal import ohos.component.*
internal import ohos.state_manage.*
internal import ohos.hilog.Hilog
internal import ohos.display.*

internal import stdx.encoding.json.JsonValue
internal import std.convert.*
internal import std.math.*
internal import std.collection.ArrayList
internal import vlayout4cj.commons.*
internal import vlayout4cj.util.Utils

extend<T> Option<T> {
    operator func ()(): T {
        this.getOrThrow()
    }
}
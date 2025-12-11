/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj.util
import ohos.base.Length

public class Utils {
    public static func binaryExpression(conditionLeft: Int64, conditionRight: Int64, resultLeft: Float64, resultRight: Float64): Float64 {
        if(conditionLeft == conditionRight) {
            return resultLeft
        } else {
            return resultRight
        }
    }

    public static func binaryExpression(condition: Bool, resultLeft: Float64, resultRight: Float64): Float64 {
        if(condition) {
            return resultLeft
        } else {
            return resultRight
        }
    }

    public static func binaryExpression(condition: Bool, arr: Array<Float64>, index: Int64, result: Float64): Float64 {
        if(condition) {
            return arr[index]
        } else {
            return result
        }
    }

    public static func binaryExpression(condition: Bool, result: Float64, arr: Array<Float64>, index: Int64): Float64 {
        if(condition) {
            return result
        } else {
            return arr[index]
        }
    }

    public static func binaryExpression(condition: Bool, result: Int32, arr: Array<Float64>, index: Int64): Int32 {
        if(condition) {
            return result
        } else {
            return Int32(arr[index])
        }
    }

    public static func binaryExpression(condition: Bool, resultLeft: Int32, resultRight: Int32): Int32 {
        if(condition) {
            return resultLeft
        } else {
            return resultRight
        }
    }

    public static func binaryExpression(condition: Bool, resultLeft: Int64, resultRight: Int64): Int64 {
        if(condition) {
            return resultLeft
        } else {
            return resultRight
        }
    }

    public static func binaryExpression(condition: Bool, resultLeft: Length, resultRight: Length): Length {
        if(condition) {
            return resultLeft
        } else {
            return resultRight
        }
    }
}
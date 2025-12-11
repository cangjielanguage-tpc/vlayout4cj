/**
 * Created on 2025/12/11
 */
package vlayout4cj.util

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
}
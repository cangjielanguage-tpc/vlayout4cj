/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj.commons

let BottomFixesHeight: Float64 = 40.0
public class CommonFunc {
    public static func computedRange(range: Array<Int64>, vLayoutData: Array<layoutDataType>): Array<layoutDataType> {
        var data: Array<layoutDataType> = vLayoutData
        if(range.size != 2) {
            return data
        }
        if(range[0] >= 0 && range[1] > range[0]) {
            if(range[0] > vLayoutData.size) {
                return Array<layoutDataType>()
            }
            if(range[1] > (vLayoutData.size - range[0])) {
                return data.slice(range[0], vLayoutData.size - range[0])
            } else {
                return data.slice(range[0], range[1])
            }
        }
        return data

    }

    public static func spanCountAndWeight(spanCount: Int64, weights: Array<Float64>): (Int64, Array<Float64>) {
        let spanCounts: Int64 = if (spanCount <= 0 && weights.size == 0) {
            4
        } else if(spanCount == 0 && weights.size != 0){
            weights.size
        } else {
            spanCount
        }
        let weightss: Array<Float64> = if (spanCount == 0 && weights.size == 0) {
            [25.0, 25.0, 25.0, 25.0]
        } else {
            weights
        }
        
        return (spanCounts, weightss)
    }

    public static func computedAlignType(xOffset: Float64, yOffset: Float64, alignType: Int32, screenWidth: Float64, screenHeight: Float64, layoutWidth: Float64, layoutHeight: Float64): (Float64, Float64) {
        var xOffsets: Float64 = 0.0
        var yOffsets: Float64 = 0.0
        match (alignType) {
            case 0 =>//左上
                xOffsets = 0.0
                yOffsets = 0.0
            case 1 =>//右上
                xOffsets = screenWidth - layoutWidth
                yOffsets = 0.0
            case 2 =>//左下
                xOffsets = 0.0
                yOffsets = screenHeight - layoutHeight - BottomFixesHeight
            case 3 =>//右下
                xOffsets = screenWidth - layoutWidth
                yOffsets = screenHeight - layoutHeight - BottomFixesHeight
            case _ =>
                xOffsets = xOffset
                yOffsets = yOffset
        }
        return (xOffsets, yOffsets)
    }

    public static func initComponentSize(layoutWidth: Float64, layoutHeight: Float64, aspectRatio: Float64): (Float64, Float64, Float64) {
        var layoutWidths: Float64 = 0.0
        var layoutHeights: Float64 = 0.0
        var aspectRatios: Float64 = 0.0
        if (layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0) {
            layoutHeights = 100.0
            aspectRatios = 1.0
            layoutWidths = layoutHeights * aspectRatios
        } else if (layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio <= 0.0) {
            layoutWidths = layoutWidth
            layoutHeights = 100.0
            aspectRatios = layoutWidths / layoutHeights
        } else if (layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0) {
            layoutHeights = layoutHeight
            aspectRatios = 1.0
            layoutWidths = layoutHeights * aspectRatios
        } else if (layoutWidth <= 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0) {
            layoutHeights = 100.0
            aspectRatios = aspectRatio
            layoutWidths = layoutHeights * aspectRatios
        } else if (layoutWidth > 0.0 && layoutHeight > 0.0 && aspectRatio > 0.0) {
            layoutWidths = layoutWidth
            layoutHeights = layoutHeight
            aspectRatios = aspectRatio
        } else if (layoutWidth > 0.0 && layoutHeight > 0.0 && aspectRatio <= 0.0) {
            layoutWidths = layoutWidth
            layoutHeights = layoutHeight
            aspectRatios = layoutWidths / layoutHeights
        } else if (layoutWidth > 0.0 && layoutHeight <= 0.0 && aspectRatio > 0.0) {
            layoutWidths = layoutWidth
            aspectRatios = aspectRatio
            layoutHeights = layoutWidths / aspectRatios
        } else if (layoutWidth <= 0.0 && layoutHeight > 0.0 && aspectRatio > 0.0) {
            layoutHeights = layoutHeight
            aspectRatios = aspectRatio
            layoutWidths = layoutHeights * aspectRatios
        } else if(layoutWidth < 0.0 || layoutHeight < 0.0){
            return (0.0, 0.0, 0.0)
        } else {
            return (0.0, 0.0, 0.0)
        }
        return (layoutWidths, layoutHeights, aspectRatios)
    }

}

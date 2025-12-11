/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import vlayout4cj.util.Utils

private const TAG = 'vlayout COLUMN_LAYOUT '

@Component
public class ColumnLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var columnAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //容器高度
    private var builderWidth: Float64 = 0.0 //获取的宽度
    private var builderItemHeight: Float64 = 0.0 //获取的高度

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(columnAttribute.range, vLayoutData)
        computedColWeights()
    }

    func dataOperation(element: Float64): Float64 {
        var elementTemp: Float64 = element
        colWeightArray = columnAttribute.colWeights
        var sum: Float64 = 0.0
        var item: Float64 = 0.0
        let count: Int64 = vLayoutData.size - colWeightArray.size
        var otnerColWeightArray: Array<Float64> = Array<Float64>(count, repeat: 0.0)
        if (colWeightArray.size == 0) {
            colWeightArray = []
        } else {
            for (i in 0..colWeightArray.size) {
                elementTemp = colWeightArray[i]
                sum += elementTemp
                if (sum < 100.0) {
                    item = (100.0 - sum) / Float64(count)
                } else {
                    item = 0.0
                }
            }
            for (j in 0..count) {
                otnerColWeightArray[j] = item
            }
        }
        colWeightArray = colWeightArray.concat(otnerColWeightArray)
        return elementTemp
    }

    func computedColWeights() {
        var element: Float64 = 0.0
        if (columnAttribute.colWeights.size != 0) {
            for (idx in 0..columnAttribute.colWeights.size) {
                element = columnAttribute.colWeights[idx]
                if (element < 0.0) {
                    columnAttribute.colWeights[idx] = 0.0
                }
            }
            if (vLayoutData.size == columnAttribute.colWeights.size) { //数据源数组长度等于列权重数组长度时
                colWeightArray = columnAttribute.colWeights
            } else if (vLayoutData.size < columnAttribute.colWeights.size) { //数据源数组长度小于列权重数组长度时
                colWeightArray = columnAttribute.colWeights
                var arr: Array<Float64> = Array<Float64>(colWeightArray.size, repeat: 0.0)
                for (i in 0..vLayoutData.size) {
                    arr[i] = colWeightArray[i]
                }
                colWeightArray = arr
            } else { //数据源数组长度大于列权重数组长度时
                element = dataOperation(element)
            }
            Hilog.info(0x000000, "computedColWeights", '${TAG} colWeightArray = ${colWeightArray}')
        } else {
            if(vLayoutData.size != 0) {
                colWeightArray = Array<Float64>(vLayoutData.size, repeat: Float64(100/vLayoutData.size))
            }
        }
    }

    func build() {
        Column() {
            Row() {
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Stack() {
                        vLayoutContent(item, position, columnAttribute.layoutHeight)
                    }
                    .width(colWeightArray[position].percent)
                    .layoutWeight(if(colWeightArray.size == 0) { 1 } else { 0})
                    .onAreaChange({oldValue, newValue =>
                        let builderItemWidth = px2vp(newValue.width.px)().value
                        builderItemHeight = px2vp(newValue.height.px)().value
                        Hilog.info(0x000000, "builderItem", TAG + 'builderItemWidth = ${builderItemWidth}, builderItemHeight = ${builderItemHeight}')
                    })
                })
            }
            .onAreaChange({oldValue, newValue =>
                builderWidth = px2vp(newValue.width.px)().value
                let builderHeight = px2vp(newValue.height.px)().value
                Hilog.info(0x000000, "builder", TAG + 'builderWidth = ${builderWidth}, builderHeight = ${builderHeight}')
            })
            .height(columnAttribute.layoutHeight)
            .width(columnAttribute.layoutWidth)
            .padding(
                top: Utils.binaryExpression(columnAttribute.padding.size == 4, columnAttribute.padding, 0, columnAttribute.topPadding),
                right: Utils.binaryExpression(columnAttribute.padding.size == 4, columnAttribute.padding, 1, columnAttribute.rightPadding),
                bottom: Utils.binaryExpression(columnAttribute.padding.size == 4, columnAttribute.padding, 2, columnAttribute.bottomPadding),
                left: Utils.binaryExpression(columnAttribute.padding.size == 4, columnAttribute.padding, 3, columnAttribute.leftPadding)
            )
        }
        .backgroundColor(columnAttribute.bgColor)
        .opacity(columnAttribute.bgOpacity)
        .zIndex(columnAttribute.zIndex)
        .margin(
            top: Utils.binaryExpression(columnAttribute.margin.size == 4, columnAttribute.margin, 0, columnAttribute.topMargin),
            right:  Utils.binaryExpression(columnAttribute.margin.size == 4, columnAttribute.margin, 1, columnAttribute.rightMargin),
            bottom: Utils.binaryExpression(columnAttribute.margin.size == 4, columnAttribute.margin, 2, columnAttribute.bottomMargin),
            left: Utils.binaryExpression(columnAttribute.margin.size == 4, columnAttribute.margin, 3, columnAttribute.leftMargin)
        )

    }
}
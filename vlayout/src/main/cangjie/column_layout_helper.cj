/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout COLUMN_LAYOUT '

@Component
public class ColumnLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //容器高度
    private var builderWidth: Float64 = 0.0 //获取的宽度
    private var builderItemHeight: Float64 = 0.0 //获取的高度

    protected override func aboutToAppear() {
        this.computedRange()
        this.computedColWeights()
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        let range = if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range }
        if (range.size == 2 && range[0] >= 0 && range[1] > range[0]) {
            vLayoutData = vLayoutData.slice(range[0], range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func computedColWeights() {
        var element: Float64 = 0.0
        if (this.vLayoutAttribute.colWeights.size != 0) {
            for (index in 0..this.vLayoutAttribute.colWeights.size) {
                element = this.vLayoutAttribute.colWeights[index]
                if (element < 0.0) {
                    this.vLayoutAttribute.colWeights = []
                } else {
                    this.vLayoutAttribute.colWeights = this.vLayoutAttribute.colWeights
                }
            }
            if (this.vLayoutData.size == this.vLayoutAttribute.colWeights.size) { //数据源数组长度等于列权重数组长度时
                this.colWeightArray = this.vLayoutAttribute.colWeights
            } else if (this.vLayoutData.size < this.vLayoutAttribute.colWeights.size) { //数据源数组长度小于列权重数组长度时
                this.colWeightArray = this.vLayoutAttribute.colWeights
                var arr: Array<Float64> = Array<Float64>(this.colWeightArray.size, item: 0.0)
                for (i in 0..this.vLayoutData.size) {
                    arr[i] = this.colWeightArray[i]
                }
                this.colWeightArray = arr
            } else { //数据源数组长度大于列权重数组长度时
                this.colWeightArray = this.vLayoutAttribute.colWeights
                var sum: Float64 = 0.0
                var item: Float64 = 0.0
                let count: Int64 = this.vLayoutData.size - this.colWeightArray.size
                var otnerColWeightArray: Array<Float64> = Array<Float64>(count, item: 0.0)
                if (this.colWeightArray.size == 0) {
                    this.colWeightArray = []
                } else {
                    for (i in 0..this.colWeightArray.size) {
                        element = this.colWeightArray[i]
                        sum += element
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
                this.colWeightArray = this.colWeightArray.concat(otnerColWeightArray)
            }
            Hilog.info(0x000000, "computedColWeights", '${TAG} colWeightArray = ${this.colWeightArray}')
        } else {
            this.colWeightArray = Array<Float64>(this.vLayoutData.size, item: Float64(100/this.vLayoutData.size))
        }

    }

    func build() {
        Column() {
            Row() {
                ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Stack() {
                        this.vLayoutContent(item, position, this.layoutHeight)
                    }
                    .width(Length(Float64(this.colWeightArray[position]), unitType: percent))
                    .layoutWeight(if(this.colWeightArray.size == 0) { 1 } else { 0})
                    .onAreaChange({oldValue, newValue =>
                        let builderItemWidth = px2vp(newValue.width.px)().value
                        this.builderItemHeight = px2vp(newValue.height.px)().value
                        Hilog.info(0x000000, "builderItem", TAG + 'builderItemWidth = ${builderItemWidth}, builderItemHeight = ${this.builderItemHeight}')
                    })
                })
            }
            .onAreaChange({oldValue, newValue =>
                this.builderWidth = px2vp(newValue.width.px)().value
                let builderHeight = px2vp(newValue.height.px)().value
                Hilog.info(0x000000, "builder", TAG + 'builderWidth = ${this.builderWidth}, builderHeight = ${builderHeight}')
            })
            .height(vLayoutAttribute.layoutHeight)
            .width(vLayoutAttribute.layoutWidth)
            .padding(
                top: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[0]
                } else {
                    vLayoutAttribute.topPadding
                },
                right: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[1]
                } else {
                    vLayoutAttribute.rightPadding
                },
                bottom: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[2]
                } else {
                    vLayoutAttribute.bottomPadding
                },
                left: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[3]
                } else {
                    vLayoutAttribute.leftPadding
                }
            )
        }
        .backgroundColor(this.vLayoutAttribute.bgColor)
        .zIndex(this.vLayoutAttribute.zIndex)
        .margin(
            top: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            right:  if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[1]
            } else {
                this.vLayoutAttribute.rightMargin
            },
            bottom: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[2]
            } else {
                this.vLayoutAttribute.bottomMargin
            },
            left: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[3]
            } else {
                this.vLayoutAttribute.leftMargin
            }
        )

    }
}
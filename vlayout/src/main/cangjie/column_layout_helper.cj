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

    @State @Watch[defaultValueInit] var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性
    @State var columnInfo: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //容器高度
    private var builderWidth: Float64 = 0.0 //获取的宽度
    private var builderItemHeight: Float64 = 0.0 //获取的高度

    protected override func aboutToAppear() {
        this.defaultValueInit()
    }

    func defaultValueInit() {
        this.columnInfo = AbstractFullFillAttributes(
            range: if(this.vLayoutAttribute.range == [0, 0] || this.vLayoutAttribute.range[1] > this.vLayoutData.size) {[0, this.vLayoutData.size] } else {this.vLayoutAttribute.range } ,
            colWeights: this.vLayoutAttribute.colWeights,
            aspectRatio: this.vLayoutAttribute.aspectRatio,
            bgColor: this.vLayoutAttribute.bgColor,
            zIndex: this.vLayoutAttribute.zIndex,
            padding: this.vLayoutAttribute.padding,
            topPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[0]
            } else {
                this.vLayoutAttribute.topPadding
            },
            rightPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[1]
            } else {
                this.vLayoutAttribute.rightPadding
            },
            bottomPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[2]
            } else {
                this.vLayoutAttribute.bottomPadding
            },
            leftPadding: if(this.vLayoutAttribute.padding.size == 4) {
                this.vLayoutAttribute.padding[3]
            } else {
                this.vLayoutAttribute.leftPadding
            },
            margin: this.vLayoutAttribute.margin,
            topMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            rightMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[1]
            } else {
                this.vLayoutAttribute.rightMargin
            },
            bottomMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[2]
            } else {
                this.vLayoutAttribute.bottomMargin
            },
            leftMargin: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[3]
            } else {
                this.vLayoutAttribute.leftMargin
            }
            )

        this.computedRange()
        this.computedColWeights()
    }
    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.columnInfo.range.size == 2 && this.columnInfo.range[0] >= 0 && this.columnInfo.range[1] > this.columnInfo.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.columnInfo.range[0], this.columnInfo.range[1])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func computedColWeights() {
        var element: Float64 = 0.0
        if (this.columnInfo.colWeights.size != 0) {
            for (index in 0..this.columnInfo.colWeights.size) {
                element = this.columnInfo.colWeights[index]
                if (element < 0.0) {
                    this.columnInfo.colWeights = []
                } else {
                    this.columnInfo.colWeights = this.columnInfo.colWeights
                }
            }
            if (this.vLayoutData.size == this.columnInfo.colWeights.size) { //数据源数组长度等于列权重数组长度时
                this.colWeightArray = this.columnInfo.colWeights
            } else if (this.vLayoutData.size < this.columnInfo.colWeights.size) { //数据源数组长度小于列权重数组长度时
                this.colWeightArray = this.columnInfo.colWeights
                var arr: Array<Float64> = Array<Float64>(this.colWeightArray.size, item: 0.0)
                for (i in 0..this.vLayoutData.size) {
                    arr[i] = this.colWeightArray[i]
                }
                this.colWeightArray = arr
            } else { //数据源数组长度大于列权重数组长度时
                this.colWeightArray = this.columnInfo.colWeights
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

    func computedHeight() {
        if (this.columnInfo.aspectRatio > 0.0) {
            let mHeight = this.builderWidth / this.columnInfo.aspectRatio
            this.layoutHeight = mHeight
            this.computedExtraHeight()
        } else {
            this.layoutHeight = this.builderWidth
            this.computedExtraHeight()
        }
    }

    func computedExtraHeight() {
        this.layoutHeight = this.layoutHeight + this.columnInfo.topPadding
        this.layoutHeight = this.layoutHeight + this.columnInfo.bottomPadding
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
                this.computedHeight()
            })
            .height(this.layoutHeight)
            .padding(
                top: this.columnInfo.topPadding,
                right: this.columnInfo.rightPadding,
                bottom: this.columnInfo.bottomPadding,
                left: this.columnInfo.leftPadding
            )
        }
        .backgroundColor(this.columnInfo.bgColor)
        .zIndex(this.columnInfo.zIndex)
        .margin(
            top: this.columnInfo.topMargin,
            right: this.columnInfo.rightMargin,
            bottom: this.columnInfo.bottomMargin,
            left: this.columnInfo.leftMargin
        )

    }
}
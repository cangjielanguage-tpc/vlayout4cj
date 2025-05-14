/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout DEFAULT_LAYOUT '

@Component
public class DefaultLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: LinearAttributes = LinearAttributes() //属性
    @State var defaultInfo: LinearAttributes = LinearAttributes() //属性

    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //list高度
    private var listWidth: Float64 = 0.0 //获取的list高度
    private var listHeight: Float64 = 0.0 //获取的list高度
    private var listItemWidth: Float64 = 0.0 //获取的listItem宽度
    private var listItemHeight: Float64 = 0.0 //获取的listItem高度

    protected override func aboutToAppear() {
        this.defaultValueInit()
    }

    func defaultValueInit() {
        this.defaultInfo = LinearAttributes(
            range: if(this.vLayoutAttribute.range == [0, 0] || this.vLayoutAttribute.range[1] > this.vLayoutData.size) {[0, this.vLayoutData.size] } else {this.vLayoutAttribute.range } ,
            dividerHeight: this.vLayoutAttribute.dividerHeight,
            layoutHeight: this.vLayoutAttribute.layoutHeight,
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
    }
    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.defaultInfo.range.size == 2 && this.defaultInfo.range[0] >= 0 && this.defaultInfo.range[1] > this.defaultInfo.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.defaultInfo.range[0], this.defaultInfo.range[1])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func computedHeight() {
        let rowCount: Int64 = this.vLayoutData.size
        Hilog.error(0,"", TAG + 'rowCount = ${rowCount}')
        if (this.defaultInfo.layoutHeight == 0.0 && this.defaultInfo.aspectRatio == 0.0) {
            this.layoutHeight = this.listItemHeight * Float64(rowCount)
            this.computedExtraHeight(rowCount)
            Hilog.error(0,"", TAG + 'the first case layoutHeight = ${this.layoutHeight}')
        } else if (this.defaultInfo.layoutHeight == 0.0 && this.defaultInfo.aspectRatio > 0.0) {
            this.oneRowHeight = this.listWidth / this.defaultInfo.aspectRatio
            this.layoutHeight = this.oneRowHeight * Float64(rowCount)
            this.computedExtraHeight(rowCount)
            Hilog.error(0,"", TAG + 'the second case oneRowHeight = ${this.oneRowHeight}, layoutHeight = ${this.layoutHeight}')
        } else if (this.defaultInfo.layoutHeight != 0.0 && this.defaultInfo.aspectRatio > 0.0) {
            this.oneRowHeight = this.listWidth / this.defaultInfo.aspectRatio
            Hilog.error(0,"", TAG + 'the third case oneRowHeight = ${this.oneRowHeight}, layoutHeight = ${this.defaultInfo.layoutHeight}')
        } else if (this.defaultInfo.layoutHeight != 0.0 && this.defaultInfo.aspectRatio == 0.0) {
            this.defaultInfo.layoutHeight = this.defaultInfo.layoutHeight
            Hilog.error(0,"", TAG + 'the fourth case layoutHeight = ${this.defaultInfo.layoutHeight}')
        } else {
            Hilog.error(0,"", TAG + 'something else computedHeight')
        }
    }

    func computedExtraHeight(rowCount: Int64) {
        if (this.defaultInfo.dividerHeight > 0 && this.layoutHeight > 0.0) {
            this.layoutHeight = this.layoutHeight + Float64(this.defaultInfo.dividerHeight * (rowCount - 1))
        }

        if (this.defaultInfo.topPadding > 0.0 && this.layoutHeight > 0.0) {
            this.layoutHeight = this.layoutHeight + this.defaultInfo.topPadding
        }

        if (this.defaultInfo.bottomPadding > 0.0 && this.layoutHeight > 0.0) {
            this.layoutHeight = this.layoutHeight + this.defaultInfo.bottomPadding
        }
    }


    func build() {
        List(space: this.vLayoutAttribute.dividerHeight) {
            ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                ListItem() {
                    this.vLayoutContent(item, position, this.oneRowHeight)
                }
                .height(this.oneRowHeight)
                .onAreaChange({oldValue, newValue =>
                    this.listItemWidth = px2vp(newValue.width.px)().value
                    this.listItemHeight = px2vp(newValue.height.px)().value
                    this.computedHeight()
                     Hilog.info(0,"", TAG + 'ListItem listItemWidth = ${this.listItemWidth}, listItemHeight = ${this.listItemHeight}')
                })
            })
        }
        .onAreaChange({oldValue, newValue =>
            this.listWidth = px2vp(newValue.width.px)().value
            this.listHeight = px2vp(newValue.height.px)().value
            this.computedHeight()
            Hilog.info(0,"", TAG + 'List listWidth = ${this.listWidth}, listHeight = ${this.listHeight}')
        })
        .height(if(this.defaultInfo.layoutHeight == 0.0) { this.layoutHeight} else { this.defaultInfo.layoutHeight })
        .edgeEffect(EdgeEffect.None)
        .padding(
            top: this.defaultInfo.topPadding,
            right: this.defaultInfo.rightPadding,
            bottom: this.defaultInfo.bottomPadding,
            left: this.defaultInfo.leftPadding
        )
        .nestedScroll(NestedScrollOptions(NestedScrollMode.SELF_FIRST, NestedScrollMode.SELF_FIRST))
        .backgroundColor(this.defaultInfo.bgColor)
        .zIndex(this.defaultInfo.zIndex)
        .margin(
            top: this.defaultInfo.topMargin,
            right: this.defaultInfo.rightMargin,
            bottom: this.defaultInfo.bottomMargin,
            left: this.defaultInfo.leftMargin
        )
    }
}
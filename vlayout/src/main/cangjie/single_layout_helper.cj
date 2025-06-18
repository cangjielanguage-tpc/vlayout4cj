/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = 'vlayout SINGLE_LAYOUT '

@Component
public class SingleLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    protected override func aboutToAppear() {
        computedRange()
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

    func build() {
        Column() {
            Stack(){
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Column() {
                        vLayoutContent(item, position)
                    }
                    .onAreaChange({oldValue, newValue =>
                        itemWidth = px2vp(newValue.width.px)().value
                        itemHeight = px2vp(newValue.height.px)().value
                        Hilog.info(0x000000,"item", TAG + 'itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                    })
                })
            }
            .width(vLayoutAttribute.layoutWidth)
            .height(vLayoutAttribute.layoutHeight)
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
        .backgroundColor(vLayoutAttribute.bgColor)
        .zIndex(vLayoutAttribute.zIndex)
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
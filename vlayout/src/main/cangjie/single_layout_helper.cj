/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

private const TAG = 'vlayout SINGLE_LAYOUT '

@Component
public class SingleLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var singleAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(singleAttribute.range, vLayoutData)
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
            .width(singleAttribute.layoutWidth)
            .height(singleAttribute.layoutHeight)
            .padding(
                top: if(singleAttribute.padding.size == 4) {
                    singleAttribute.padding[0]
                } else {
                    singleAttribute.topPadding
                },
                right: if(singleAttribute.padding.size == 4) {
                    singleAttribute.padding[1]
                } else {
                    singleAttribute.rightPadding
                },
                bottom: if(singleAttribute.padding.size == 4) {
                    singleAttribute.padding[2]
                } else {
                    singleAttribute.bottomPadding
                },
                left: if(singleAttribute.padding.size == 4) {
                    singleAttribute.padding[3]
                } else {
                    singleAttribute.leftPadding
                }
            )
        }
        .backgroundColor(singleAttribute.bgColor)
        .opacity(singleAttribute.bgOpacity)
        .zIndex(singleAttribute.zIndex)
        .margin(
            top: if(singleAttribute.margin.size == 4) {
                singleAttribute.margin[0]
            } else {
                singleAttribute.topMargin
            },
            right:  if(singleAttribute.margin.size == 4) {
                singleAttribute.margin[1]
            } else {
                singleAttribute.rightMargin
            },
            bottom: if(singleAttribute.margin.size == 4) {
                singleAttribute.margin[2]
            } else {
                singleAttribute.bottomMargin
            },
            left: if(singleAttribute.margin.size == 4) {
                singleAttribute.margin[3]
            } else {
                singleAttribute.leftMargin
            }
        )

    }
}
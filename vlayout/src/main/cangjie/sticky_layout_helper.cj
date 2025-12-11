/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Prop

private const TAG = 'vlayout STICKY_LAYOUT '

@Component
public class StickyLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var stickyAttribute: FixAreaAttributes = FixAreaAttributes() //属性

    @Prop var isSticky: Bool

    private var layoutWidth: Float64 = 0.0 //获取的容器高度
    private var layoutHeight: Float64 = 0.0 //获取的容器高度
    private var aspectRatio: Float64 = 0.0 //宽高比

    protected override func aboutToAppear() {
        layoutWidth = CommonFunc.initComponentSize(
            stickyAttribute.layoutWidth,
            stickyAttribute.layoutHeight,
            stickyAttribute.aspectRatio
            )[0]
        layoutHeight = CommonFunc.initComponentSize(
            stickyAttribute.layoutWidth,
            stickyAttribute.layoutHeight,
            stickyAttribute.aspectRatio
            )[1]
        aspectRatio = CommonFunc.initComponentSize(
            stickyAttribute.layoutWidth,
            stickyAttribute.layoutHeight,
            stickyAttribute.aspectRatio
            )[2]
    }

    func build() {
        Column() {
            if(isSticky) {
                Stack() {
                    ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                        vLayoutContent(item, position)
                    })
                }

                .width(layoutWidth)
                .height(layoutHeight)
                .aspectRatio(aspectRatio)
                .backgroundColor(stickyAttribute.bgColor)
                .padding(
                    top: stickyAttribute.topPadding,
                    right: stickyAttribute.rightPadding,
                    bottom: stickyAttribute.bottomPadding,
                    left: stickyAttribute.leftPadding
                )
                .zIndex(stickyAttribute.zIndex)
                .margin(
                    top: stickyAttribute.topMargin,
                    right: stickyAttribute.rightMargin,
                    bottom: stickyAttribute.bottomMargin,
                    left: stickyAttribute.leftMargin
                )
                .position(x: 0.0, y: 0.0)
            } else{
                Stack() {
                    ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                        vLayoutContent(item, position)
                    })
                }

                .width(layoutWidth)
                .height(layoutHeight)
                .aspectRatio(aspectRatio)
                .backgroundColor(stickyAttribute.bgColor)
                .opacity(stickyAttribute.bgOpacity)
                .padding(
                    top: Utils.binaryExpression(stickyAttribute.padding.size == 4, stickyAttribute.padding[0], stickyAttribute.topPadding),
                    right: Utils.binaryExpression(stickyAttribute.padding.size == 4, stickyAttribute.padding[1], stickyAttribute.rightPadding),
                    bottom: Utils.binaryExpression(stickyAttribute.padding.size == 4, stickyAttribute.padding[2], stickyAttribute.bottomPadding),
                    left: Utils.binaryExpression(stickyAttribute.padding.size == 4, stickyAttribute.padding[3], stickyAttribute.leftPadding)
                )
                .zIndex(stickyAttribute.zIndex)
                .margin(
                    top: Utils.binaryExpression(stickyAttribute.margin.size == 4, stickyAttribute.margin[0], stickyAttribute.topMargin),
                    right:  Utils.binaryExpression(stickyAttribute.margin.size == 4, stickyAttribute.margin[1], stickyAttribute.rightMargin),
                    bottom: Utils.binaryExpression(stickyAttribute.margin.size == 4, stickyAttribute.margin[2], stickyAttribute.bottomMargin),
                    left: Utils.binaryExpression(stickyAttribute.margin.size == 4, stickyAttribute.margin[3], stickyAttribute.leftMargin)
                )
            }

        }
    }
}
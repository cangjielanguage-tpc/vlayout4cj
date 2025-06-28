/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch

private const TAG = "vlayout BANNER_LAYOUT "

@Component
public class BannerLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var bannerAttribute: BannerAttributes = BannerAttributes() //属性

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(bannerAttribute.range, vLayoutData)
    }

    func build() {
        Column() {
            Swiper() {
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Column() {
                       vLayoutContent(item, position)
                    }
                    .onAreaChange({oldValue, newValue =>
                        itemWidth = newValue.width
                        itemHeight = newValue.height
                        Hilog.info(0x000000,"item",  '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                    })
               })
            }
            .width(bannerAttribute.layoutWidth)
            .height(bannerAttribute.layoutHeight)
            .index(bannerAttribute.layoutIndex)
            .autoPlay(bannerAttribute.layoutAutoPlay)
            .interval(bannerAttribute.layoutInterval)
            .indicator(bannerAttribute.layoutIndicator)
            .loop(bannerAttribute.layoutLoop)
            .duration(bannerAttribute.layoutDuration)
            .vertical(bannerAttribute.layoutVertical)
            .itemSpace(bannerAttribute.layoutItemSpace)
            .effectMode(
                match (bannerAttribute.layoutEffectMode) {
                	case 1 => EdgeEffect.Spring
                	case 2 => EdgeEffect.Fade
                	case _ => EdgeEffect.None
                }
            )
        }
        .backgroundColor(bannerAttribute.bgColor)
        .opacity(bannerAttribute.bgOpacity)
        .zIndex(bannerAttribute.zIndex)
        .margin(
            top: if(bannerAttribute.margin.size == 4) {
                bannerAttribute.margin[0]
            } else {
                bannerAttribute.topMargin
            },
            right:  if(bannerAttribute.margin.size == 4) {
                bannerAttribute.margin[1]
            } else {
                bannerAttribute.rightMargin
            },
            bottom: if(bannerAttribute.margin.size == 4) {
                bannerAttribute.margin[2]
            } else {
                bannerAttribute.bottomMargin
            },
            left: if(bannerAttribute.margin.size == 4) {
                bannerAttribute.margin[3]
            } else {
                bannerAttribute.leftMargin
            }
        )
    }
}
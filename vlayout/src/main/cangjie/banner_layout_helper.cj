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

    @State var vLayoutAttribute: BannerAttributes = BannerAttributes() //属性

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    protected override func aboutToAppear() {
        this.computedRange()
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.vLayoutAttribute.range.size == 2 && this.vLayoutAttribute.range[0] >= 0 && this.vLayoutAttribute.range[1] > this.vLayoutAttribute.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.vLayoutAttribute.range[0], this.vLayoutAttribute.range[1] - this.vLayoutAttribute.range[0])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func build() {
        Column() {
            Swiper() {
                ForEach(this.vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    Column() {
                       this.vLayoutContent(item, position)
                    }
                    .onAreaChange({oldValue, newValue =>
                        this.itemWidth = newValue.width
                        this.itemHeight = newValue.height
                        Hilog.info(0x000000,"item",  '${TAG} itemWidth = ${this.itemWidth}, itemHeight = ${this.itemHeight}')
                    })
               })
            }
            .width(this.vLayoutAttribute.layoutWidth)
            .height(this.vLayoutAttribute.layoutHeight)
            .index(UInt32(this.vLayoutAttribute.layoutIndex))
            .autoPlay(this.vLayoutAttribute.layoutAutoPlay)
            .interval(UInt32(this.vLayoutAttribute.layoutInterval))
            .indicator(this.vLayoutAttribute.layoutIndicator)
            .loop(this.vLayoutAttribute.layoutLoop)
            .duration(UInt32(this.vLayoutAttribute.layoutDuration))
            .vertical(this.vLayoutAttribute.layoutVertical)
            .itemSpace(this.vLayoutAttribute.layoutItemSpace)
            .effectMode(
                match (this.vLayoutAttribute.layoutEffectMode) {
                	case 1 => EdgeEffect.Spring
                	case 2 => EdgeEffect.Fade
                	case _ => EdgeEffect.None
                }
            )
        }
        .backgroundColor(this.vLayoutAttribute.bgColor)
        .zIndex(Int32(this.vLayoutAttribute.zIndex))
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
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

    @State @Watch[defaultValueInit] var vLayoutAttribute: BannerAttributes = BannerAttributes() //属性
    @State var bannerInfo: BannerAttributes = BannerAttributes() //属性

    @State var layoutHeight: Float64 = 0.0 //banner布局的高度
    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //每个item的高度

    protected override func aboutToAppear() {
        this.defaultValueInit()
    }

    func defaultValueInit() {
        this.bannerInfo = BannerAttributes(
            range: this.vLayoutAttribute.range,
            layoutWidth: this.vLayoutAttribute.layoutWidth,
            layoutHeight: this.vLayoutAttribute.layoutHeight,
            aspectRatio: this.vLayoutAttribute.aspectRatio,
            bgColor: this.vLayoutAttribute.bgColor,
            layoutIndex: this.vLayoutAttribute.layoutIndex,
            layoutAutoPlay: this.vLayoutAttribute.layoutAutoPlay,
            layoutInterval: this.vLayoutAttribute.layoutInterval,
            layoutIndicator: this.vLayoutAttribute.layoutIndicator,
            layoutLoop: this.vLayoutAttribute.layoutLoop,
            layoutDuration: this.vLayoutAttribute.layoutDuration,
            layoutVertical: this.vLayoutAttribute.layoutVertical,
            layoutItemSpace: this.vLayoutAttribute.layoutItemSpace,
            layoutEffectMode: this.vLayoutAttribute.layoutEffectMode,
            zIndex: this.vLayoutAttribute.zIndex,
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

        this.initComponentSize()
        this.computedRange()
    }

    func initComponentSize() {
        //当容器宽度layoutWidth定义了，无法同时给左右外边距
        //当容器纵横比aspectRatio定义了就相当于容器宽度layoutWidth定义了
        //八种情况下只有两种情况同时给定左右外边距能生效
        if (this.bannerInfo.layoutWidth == 0.0 && this.bannerInfo.layoutHeight == 0.0 && this.bannerInfo.aspectRatio == 0) {
            this.bannerInfo.layoutWidth = 0.0
            this.bannerInfo.layoutHeight = 0.0
            this.bannerInfo.aspectRatio = 0
        } else if (this.bannerInfo.layoutWidth != 0.0 && this.bannerInfo.layoutHeight == 0.0 && this.bannerInfo.aspectRatio == 0) {
            this.bannerInfo.layoutWidth = this.bannerInfo.layoutWidth
            this.bannerInfo.layoutHeight = 0.0
            this.bannerInfo.aspectRatio = 0
        } else if (this.bannerInfo.layoutWidth == 0.0 && this.bannerInfo.layoutHeight != 0.0 && this.bannerInfo.aspectRatio == 0) {
            this.bannerInfo.layoutWidth = 0.0
            this.bannerInfo.layoutHeight = this.bannerInfo.layoutHeight
            this.bannerInfo.aspectRatio = 0
        } else if (this.bannerInfo.layoutWidth == 0.0 && this.bannerInfo.layoutHeight == 0.0 && this.bannerInfo.aspectRatio != 0) {
            this.bannerInfo.layoutWidth = 0.0
            this.bannerInfo.layoutHeight = 0.0
            this.bannerInfo.aspectRatio = this.bannerInfo.aspectRatio
        } else if (this.bannerInfo.layoutWidth != 0.0 && this.bannerInfo.layoutHeight != 0.0 && this.bannerInfo.aspectRatio != 0) {
            this.bannerInfo.layoutWidth = this.bannerInfo.layoutWidth
            this.bannerInfo.layoutHeight = this.bannerInfo.layoutHeight
            this.bannerInfo.aspectRatio = this.bannerInfo.aspectRatio
        } else if (this.bannerInfo.layoutWidth != 0.0 && this.bannerInfo.layoutHeight != 0.0 && this.bannerInfo.aspectRatio == 0) {
            this.bannerInfo.layoutWidth = this.bannerInfo.layoutWidth
            this.bannerInfo.layoutHeight = this.bannerInfo.layoutHeight
            this.bannerInfo.aspectRatio = 0
        } else if (this.bannerInfo.layoutWidth != 0.0 && this.bannerInfo.layoutHeight == 0.0 && this.bannerInfo.aspectRatio != 0) {
            this.bannerInfo.layoutWidth = this.bannerInfo.layoutWidth
            this.bannerInfo.layoutHeight = 0.0
            this.bannerInfo.aspectRatio = this.bannerInfo.aspectRatio
        } else if (this.bannerInfo.layoutWidth != 0.0 && this.bannerInfo.layoutHeight != 0.0 && this.bannerInfo.aspectRatio != 0) {
            this.bannerInfo.layoutWidth = 0.0
            this.bannerInfo.layoutHeight = this.bannerInfo.layoutHeight
            this.bannerInfo.aspectRatio = this.bannerInfo.aspectRatio
        } else {
            Hilog.error(0, "", TAG + 'initComponentSize else')
        }
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (this.bannerInfo.range.size == 2 && this.bannerInfo.range[0] >= 0 && this.bannerInfo.range[1] > this.bannerInfo.range[0]) {
            this.vLayoutData = this.vLayoutData.slice(this.bannerInfo.range[0], this.bannerInfo.range[1] - this.bannerInfo.range[0])
        } else {
            this.vLayoutData = this.vLayoutData
        }
    }

    func computedHeight() {
        this.layoutHeight = this.itemHeight
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
                        Hilog.info(0,"",  '${TAG} itemWidth = ${this.itemWidth}, itemHeight = ${this.itemHeight}')
                        this.computedHeight()
                    })
               })
            }
            .width(this.bannerInfo.layoutWidth)
            .height(this.bannerInfo.layoutHeight)
            .aspectRatio(this.bannerInfo.aspectRatio)
            .index(UInt32(this.bannerInfo.layoutIndex))
            .autoPlay(this.bannerInfo.layoutAutoPlay)
            .interval(UInt32(this.bannerInfo.layoutInterval))
            .indicator(this.bannerInfo.layoutIndicator)
            .loop(this.bannerInfo.layoutLoop)
            .duration(UInt32(this.bannerInfo.layoutDuration))
            .vertical(this.bannerInfo.layoutVertical)
            .itemSpace(this.bannerInfo.layoutItemSpace)
            .effectMode(
                match (this.bannerInfo.layoutEffectMode) {
                	case 1 => EdgeEffect.Spring
                	case 2 => EdgeEffect.Fade
                	case _ => EdgeEffect.None
                }
            )
        }
        .backgroundColor(this.bannerInfo.bgColor)
        .zIndex(Int32(this.bannerInfo.zIndex))
        .margin(
            top: this.bannerInfo.topMargin,
            right: this.bannerInfo.rightMargin,
            bottom: this.bannerInfo.bottomMargin,
            left: this.bannerInfo.leftMargin
        )
    }
}
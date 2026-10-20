package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State

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
            top: Utils.binaryExpression(bannerAttribute.margin.size == 4, bannerAttribute.margin, 0, bannerAttribute.topMargin),
            right:  Utils.binaryExpression(bannerAttribute.margin.size == 4, bannerAttribute.margin, 1, bannerAttribute.rightMargin),
            bottom: Utils.binaryExpression(bannerAttribute.margin.size == 4, bannerAttribute.margin, 2, bannerAttribute.bottomMargin),
            left: Utils.binaryExpression(bannerAttribute.margin.size == 4, bannerAttribute.margin, 3, bannerAttribute.leftMargin)
        )
    }
}
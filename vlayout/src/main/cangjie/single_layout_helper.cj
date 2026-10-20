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
                top: Utils.binaryExpression(singleAttribute.padding.size == 4, singleAttribute.padding, 0, singleAttribute.topPadding),
                right: Utils.binaryExpression(singleAttribute.padding.size == 4, singleAttribute.padding, 1, singleAttribute.rightPadding),
                bottom: Utils.binaryExpression(singleAttribute.padding.size == 4, singleAttribute.padding, 2, singleAttribute.bottomPadding),
                left: Utils.binaryExpression(singleAttribute.padding.size == 4, singleAttribute.padding, 3, singleAttribute.leftPadding)
            )
        }
        .backgroundColor(singleAttribute.bgColor)
        .opacity(singleAttribute.bgOpacity)
        .zIndex(singleAttribute.zIndex)
        .margin(
            top: Utils.binaryExpression(singleAttribute.margin.size == 4, singleAttribute.margin, 0, singleAttribute.topMargin),
            right:  Utils.binaryExpression(singleAttribute.margin.size == 4, singleAttribute.margin, 1, singleAttribute.rightMargin),
            bottom: Utils.binaryExpression(singleAttribute.margin.size == 4, singleAttribute.margin, 2, singleAttribute.bottomMargin),
            left: Utils.binaryExpression(singleAttribute.margin.size == 4, singleAttribute.margin, 3, singleAttribute.leftMargin)
        )

    }
}
package ohos_app_cangjie_entry.level0

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStickyFixLayoutWidthHeightAspectRatio {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0")
    ]
    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, listItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(if(position % 2 == 0){ 0xdaa520 } else { 0xbdb76b })
            .border(width: 0.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(18)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.Start)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
           })
    }

    @Builder func layoutContent(item: layoutDataType, position: Int64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    func build() {
        Scroll(Scroller()){
            Column(){
                Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                    .shape(ShapeType.Capsule).width(95.percent)
                    .stateEffect(true).id("back")
                    .onClick ({ evt =>
                        Router.back()
                    })
                // layoutWidth != 0.0 && layoutHeight != 0.0 && aspectRatio != 0.0
                //layoutWidths = layoutWidth
                //layoutHeights = layoutHeight
                //aspectRatios = aspectRatio
                Text("layoutWidth != 0.0 && layoutHeight != 0.0 && aspectRatio != 0.0，预期：显示------").height(80).fontSize(14)
                StickyLayout(
                    vLayoutContent: this.layoutContent,
                    vLayoutData: data,
                    isSticky: false,
                    stickyAttribute: FixAreaAttributes(
                        layoutWidth: 50.0,
                        layoutHeight: 50.0,
                        aspectRatio: 2.0,
                        alignType: 0
                    )
                )
                // layoutWidth != 0.0 && layoutHeight != 0.0 && aspectRatio != 0.0
                //layoutWidths = layoutWidth
                //layoutHeights = layoutHeight
                //aspectRatios = aspectRatio
               Text("layoutWidth != 0.0 && layoutHeight == 0.0 && aspectRatio != 0.0，预期：显示------").height(80).fontSize(14)
                StickyLayout(
                    vLayoutContent: this.layoutContent,
                    vLayoutData: data,
                    isSticky: false,
                    stickyAttribute: FixAreaAttributes(
                        layoutWidth: 50.0,
                        aspectRatio: 2.0,
                        alignType: 1
                    )
                )
                // layoutWidth != 0.0 && layoutHeight != 0.0 && aspectRatio != 0.0
                //layoutWidths = layoutWidth
                //layoutHeights = layoutHeight
                //aspectRatios = aspectRatio
                Text("layoutWidth == 0.0 && layoutHeight != 0.0 && aspectRatio != 0.0，预期：显示------").height(80).fontSize(14)
                StickyLayout(
                    vLayoutContent: this.layoutContent,
                    vLayoutData: data,
                    isSticky: false,
                    stickyAttribute: FixAreaAttributes(
                        layoutHeight: 50.0,
                        aspectRatio: 2.0,
                        alignType: 3
                    )
                )

            }
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xDCDCDC)
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.On)
    }

}
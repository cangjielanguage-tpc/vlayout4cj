package ohos_app_cangjie_entry.level0

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStickyAspectRatio {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0")
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(Color(0x22EEEEEE))
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
        Stack(Alignment.TopStart) {
            Scroll(Scroller()){
                Column(){
                    Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                     // aspectRatio 缺省，预期：显示
                    //layoutWidth == 0.0 && layoutHeight == 0.0 && aspectRatio == 0.0
                    // 默认layoutHeights = 100.0 aspectRatios = 1.0 layoutWidths = layoutHeights * aspectRatios
                    Text("aspectRatio 缺省，预期：显示------").height(80).fontSize(14)
                    StickyLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        isSticky: false,
                        stickyAttribute: FixAreaAttributes(
                            bgColor: 0xFF0000,
                        )
                    )
                    //aspectRatio -1.0 预期：不显示  level2
//                    Text("aspectRatio: -1.0 预期：显示------").height(80).fontSize(14)
//                    StickyLayout(
//                        vLayoutContent: this.layoutContent,
//                        vLayoutData: data,
//                        isSticky: false,
//                        stickyAttribute: FixAreaAttributes(
//                            aspectRatio: -1.0,
//                            bgColor: 0xFF0000,
//                        )
//                    )
                    //0.0 < aspectRatio <2.0，预期：显示
                    //layoutWidth == 0.0 && layoutHeight == 0.0 && aspectRatio != 0.0
                    //layoutHeights = 100.0
                    //aspectRatios = aspectRatio
                    //layoutWidths = layoutHeights * aspectRatios
                    Text("0.0 < aspectRatio <2.0，预期：显示------").height(80).fontSize(14)  //
                    StickyLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        isSticky: false,
                        stickyAttribute: FixAreaAttributes(
                            aspectRatio: 1.0,
                            bgColor: 0xFF0000,
                        )
                    )
                     //aspectRatio > 2.0，预期：显示-----
                    //layoutWidth == 0.0 && layoutHeight == 0.0 && aspectRatio != 0.0
                    //layoutHeights = 100.0
                    //aspectRatios = aspectRatio
                    //layoutWidths = layoutHeights * aspectRatios
                    Text("aspectRatio > 2.0，预期：显示------").height(80).fontSize(14)  //
                    StickyLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        isSticky: false,
                        stickyAttribute: FixAreaAttributes(
                            aspectRatio: 3.0,
                            bgColor: 0xFF0000,
                        )
                    )
                }
            }
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.On)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }

}
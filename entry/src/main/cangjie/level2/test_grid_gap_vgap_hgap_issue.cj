package ohos_app_cangjie_entry.level2

import ohos.state_macro_manage.*

@Entry
@Component
class TestGridGapVgapHgapIssue {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6")
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64, itemHeight: Float64) {
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
        Stack(Alignment.TopStart) {
            Scroll(Scroller()){
                Column(){
                    Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                            .shape(ShapeType.Capsule).width(95.percent)
                            .stateEffect(true).id("back")
                            .onClick ({ evt =>
                                Router.back()
                            })
                    Text("gap = 10，预期：------").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            gap: 10
                        )
                    )
                    Text("vGap = 10 hGap = 10 gap = 10，预期：------").height(80).fontSize(14)
                    GridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        gridAttribute: GridAttributes(
                            layoutHeight: 300.0,
                            bgColor: 0xFF0000,
                            vGap: 10,
                            hGap: 10,
                            gap: 10
                        )
                    )


                }
            }
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.On)
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xAAAAAA)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xAAAAAA)
    }

}
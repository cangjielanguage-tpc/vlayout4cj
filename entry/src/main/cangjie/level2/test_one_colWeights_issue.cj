package ohos_app_cangjie_entry.level2

import ohos.state_macro_manage.*

@Entry
@Component
class TestOneColWeightsIssue {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4")
    ]

    @Builder func layoutContent(item: layoutDataType) {
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
                    Text("colWeights 长度为1，预期：正常------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                            colWeights: [10.0]
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
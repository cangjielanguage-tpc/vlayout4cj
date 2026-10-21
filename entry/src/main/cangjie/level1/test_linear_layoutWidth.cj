package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestLinearLayoutWidth {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4")
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64, itemHeight: Float64) {
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
                    Text("layoutWidth 缺省，预期：不显示------").height(80).fontSize(14)
                    LinearLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        linearAttribute: LinearAttributes(
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("layoutWidth 200.vp 预期：显示------").height(80).fontSize(14)
                    LinearLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        linearAttribute: LinearAttributes(
                            layoutWidth: 200.vp,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("layoutWidth <= 0，预期：不显示------").height(80).fontSize(14)  // D
                    LinearLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        linearAttribute: LinearAttributes(
                            layoutWidth: (-100).vp,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("0 < layoutWidth <= 设备宽度，预期：显示------").height(80).fontSize(14)  // D
                    LinearLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        linearAttribute: LinearAttributes(
                            layoutWidth: 200.vp,
                            layoutHeight: 20.percent,
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
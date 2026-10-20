package ohos_app_cangjie_entry.level0

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestDefaultDividerHeight {
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
                    Text("dividerHeight 缺省，预期：0------").height(80).fontSize(14)
                    DefaultLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("dividerHeight <= 0，预期：0------").height(80).fontSize(14)
                    DefaultLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            dividerHeight: -10
                        )
                    )

                    Text("0 < dividerHeight <= 设备高度，预期：正常间隔------").height(80).fontSize(14)  // D
                    DefaultLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            dividerHeight: 50
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
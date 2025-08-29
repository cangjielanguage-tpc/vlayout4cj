/**
 * Created on 2025/6/27
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestLayoutDataType {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0",colsSpan: 2,layoutColor: 0x00ff00,textSize:12, bgColor: 0xee82ee,top: 20.0,left: 10.0,tag: "第0个"),
        layoutDataType(layoutText: "1",layoutColor: 0x00ffff,textSize:15,bgColor: 0xd8bfd8,top: 22.0,left: 12.0,tag: "第1个"),
        layoutDataType(layoutText: "2",layoutColor: 0x5f9ea0,textSize:17,bgColor: 0xee82ee,top: 24.0,left: 14.0,tag: "第2个"),
        layoutDataType(layoutText: "3",layoutColor: 0x7fff00,textSize:19,bgColor: 0xffdead,top: 26.0,left: 16.0,tag: "第3个"),
        layoutDataType(layoutText: "4",layoutColor: 0xf4a460,textSize:22,bgColor: 0xffd700,top: 28.0,left: 18.0,tag: "第4个")
    ]

    @Builder func layoutContent(item: layoutDataType) {
        Text("${item.layoutText}-${item.tag}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(item.bgColor)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(item.textSize)
            .fontColor(item.layoutColor)
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .padding(top: item.top,left: item.left)
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
                    Text("layoutWidth 200.vp 预期：显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 400.vp,
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
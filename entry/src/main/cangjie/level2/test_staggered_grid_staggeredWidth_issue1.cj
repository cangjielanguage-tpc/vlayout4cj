package ohos_app_cangjie_entry.level2

import ohos.state_macro_manage.*

@Entry
@Component
class TestStaggeredGridStaggeredWidthIssue1 {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64) {
        if (position % 2 == 0) {
          Text("${item.layoutText}")
            .width(100.percent)
            .height(220)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .backgroundColor(0x33EEEEEE)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
        } else {
          Text("${item.layoutText}")
            .width(100.percent)
            .height(150)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .backgroundColor(0x33EEEEEE)
            .fontColor(Color(0x999999))
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
        }
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
                    Text("staggeredWidth 缺省，预期：默认屏幕宽度------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED1',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes()
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
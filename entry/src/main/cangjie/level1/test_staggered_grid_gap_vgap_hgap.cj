package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStaggeredGridGapVgapHgap {
    private var vScroller: Scroller = Scroller()
    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px).getOrThrow().value
    var data1: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data2: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data3: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data4: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data5: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data6: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data7: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data8: Array<layoutDataType> = [
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
                    Text("gap vGap hGap缺省，预期：没有间隔------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED1',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data1,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000
                        )
                    )
                    Text("gap < 0，预期：有间隔------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED2',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data2,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            gap: -10.0
                        )
                    )
                    Text("vGap < 0，预期：有间隔------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED3',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data3,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            vGap: -10.0
                        )
                    )
                    Text("hGap 缺省 < 0，预期：有间隔------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED4',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data4,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            hGap: -10.0
                        )
                    )
                    Text("gap = 10，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED5',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            gap: 10.0
                        )
                    )
                    Text("hGap = 10，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED6',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data6,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            hGap: 10.0
                        ),
                    )
                    Text("vGap = 10，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED7',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data7,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            vGap: 10.0
                        ),
                    )
                    Text("vGap = 10 hGap = 10 gap = 10，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED8',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data8,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                            vGap: 10.0,
                            hGap: 10.0,
                            gap: 10.0
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
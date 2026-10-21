package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStaggeredGridZindexMarginPadding {
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
            Scroll(Scroller()) {
                Column(){
                     Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                    Text("zIndex 缺省，预期：0------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED1',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("zIndex <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED2',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            zIndex: -10
                        )
                    )

                    Text("0 < zIndex <= 6，预期：正常------").height(80).fontSize(14)  // D
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED3',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            zIndex: 6
                        )
                    )

                    Text("margin，缺省：默认[]------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED4',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("margin 元素 < 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED5',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            margin:[-10.0,-10.0,-10.0,-10.0]
                        )
                    )

                    Text("0< margin 元素 < 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED6',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            margin:[50.0,50.0,50.0,50.0]
                        )
                    )

                    Text("topMargin 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED7',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("topMargin <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED8',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            topMargin: -20.0
                        )
                    )

                    Text("0 < topMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED9',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            topMargin: 50.0
                        )
                    )

                    Text("rightMargin 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED11',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("rightMargin <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED12',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            rightMargin: -20.0
                        )
                    )

                    Text("0 < rightMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED13',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            rightMargin: 50.0
                        )
                    )

                    Text("bottomMargin 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED14',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("bottomMargin <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED15',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            bottomMargin: -20.0
                        )
                    )


                    Text("0 < bottomMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED16',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            bottomMargin: 50.0
                        )
                    )


                    Text("leftMargin 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED17',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )


                    Text("leftMargin <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED18',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            leftMargin: -20.0
                        )
                    )


                    Text("0 < leftMargin <= 设备高度，预期：正常------").height(80).fontSize(14)
                    Divider().color(0x000000).strokeWidth(1)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED19',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            leftMargin: 50.0
                        )
                    )

                    //----padding----
                    Text("padding，缺省：默认[]------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED20',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("padding 元素 < 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED21',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            padding:[-10.0,-10.0,-10.0,-10.0]
                        )
                    )
                    Text("0< padding 元素 < 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED22',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            padding:[50.0,50.0,50.0,50.0]
                        )
                    )

                    Text("topPadding 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED23',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("topPadding <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED24',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            topMargin: -20.0
                        )
                    )

                    Text("0 < topPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED25',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            topPadding: 50.0
                        )
                    )

                    Text("rightPadding 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED26',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("rightPadding <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED27',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            rightPadding: -20.0
                        )
                    )

                    Text("0 < rightPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED28',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            rightPadding: 50.0
                        )
                    )

                    Text("bottomMargin 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED29',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("bottomPadding <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED30',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            bottomPadding: -20.0
                        )
                    )

                    Text("0 < bottomPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED31',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            bottomPadding: 50.0
                        )
                    )

                    Text("leftPadding 缺省，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED32',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                        )
                    )

                    Text("leftPadding <= 0，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED33',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            leftPadding: -20.0
                        )
                    )

                    Text("0 < leftPadding <= 设备高度，预期：正常------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED34',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            leftPadding: 50.0
                        )
                    )

                    Text("组合 padding 和 rightPadding ，预期：优先级 padding------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED35',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            padding: [10.0,10.0,10.0,10.0],
                            leftPadding: 50.0
                        )
                    )

                    Text("组合 margin 和 leftMargin ，预期：优先级 margin------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED36',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            margin: [10.0,10.0,10.0,10.0],
                            leftMargin: 50.0
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
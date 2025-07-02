/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStaggeredGridRange {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5"),
        layoutDataType(layoutText: "6"),
        layoutDataType(layoutText: "7"),
        layoutDataType(layoutText: "8"),
        layoutDataType(layoutText: "9"),
        layoutDataType(layoutText: "10"),
        layoutDataType(layoutText: "11")
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
                    Text("range 缺省，预期：显示全部 vLayoutData------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED1',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("range [0,2]，预期：显示 2 个 vLayoutData------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED2',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            range:[0,2]
                        )
                    )


                    Text("range [120,520]，预期：不显示------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED3',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            range:[120,520]
                        )
                    )

                    Text("range [0,3]小于等于vLayoutData长度范围[0,6]，预期：显示 3 个 vLayoutData------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED4',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 200.0,
                            bgColor: 0xFF0000,
                            range:[0,3]
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
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestStaggeredGridStaggeredWidth {
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

                    Text("staggeredWidth 300，预期：显示------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED2',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 300.0,
                            bgColor: 0xFF0000,
                        )
                    )
                    Text("staggeredWidth -300，预期：不显示------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED3',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: -300.0,
                            bgColor: 0xFF0000,
                        )
                    )
                    Text("staggeredWidth 700，预期：显示------").height(80).fontSize(14)
                    StaggeredGridLayout(
                        vLayoutId: 'STAGGERED4',
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        staggeredGridAttribute: StaggeredGridAttributes(
                            staggeredWidth: 700.0,
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
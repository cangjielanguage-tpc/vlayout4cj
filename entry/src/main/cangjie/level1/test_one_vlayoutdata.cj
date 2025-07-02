/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestOneVlayoutData {
    private var vScroller: Scroller = Scroller()
    var data1: Array<layoutDataType> = [
        layoutDataType(layoutText: "0")
    ]
    var data2: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1")
    ]
    var data3: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2")
    ]
    var data4: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3")
    ]
    var data5: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4")
    ]
    var data6: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5")
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
                    Text("vLayoutData 1，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data1,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )
                    Text("vLayoutData 2，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data2,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )
                    Text("vLayoutData 3，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data3,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )
                    Text("vLayoutData 4，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data4,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )
                    Text("vLayoutData 5，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
                        )
                    )
                    Text("vLayoutData 6，预期：正常显示------").height(80).fontSize(14)
                    OneLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data5,
                        oneAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0x808000,
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
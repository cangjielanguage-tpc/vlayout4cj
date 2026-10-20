package ohos_app_cangjie_entry.level0

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestFloatXOffsetYOffset {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0")
    ]
    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, listItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(if(position % 2 == 0){ 0xdaa520 } else { 0xbdb76b })
            .border(width: 0.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(18)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.Start)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
           })
    }

    @Builder func layoutContent(item: layoutDataType, position: Int64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .backgroundColor(if(position % 2 == 0){ 0x00ff00 } else { 0xff00ff })
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
        Stack(){
            List(scroller: vScroller) {
                ListItem() {
                    Button("back").height(40).margin(top: 5, bottom: 5).fontSize(16)
                        .shape(ShapeType.Capsule).width(95.percent)
                        .stateEffect(true).id("back")
                        .onClick ({ evt =>
                            Router.back()
                        })
                }
                ListItem() {
                    DefaultLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "0"),
                            layoutDataType(layoutText: "1"),
                            layoutDataType(layoutText: "2"),
                            layoutDataType(layoutText: "3"),
                            layoutDataType(layoutText: "4"),
                            layoutDataType(layoutText: "5"),
                            layoutDataType(layoutText: "6")
                        ],
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 500.vp,
                            dividerHeight: 5,
                            margin: [25.0, 5.0, 2.0, 5.0],
                            padding:[15.0, 10.0, 12.0, 10.0]
                        )
                    )
                }
                ListItem() {
                    DefaultLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "8"),
                            layoutDataType(layoutText: "9")
                            ],
                        defaultAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 800.vp,
                            dividerHeight: 5,
                            margin: [13.0, 5.0, 12.0, 5.0],
                            padding:[23.0, 20.0, 22.0, 30.0]
                        )
                    )
                }
            }
            // xOffset 缺省xOffset 缺省，预期：左上角
            FloatLayout(
                vLayoutContent: this.layoutContent,
                vLayoutData: data,
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 100.0,
                    layoutHeight: 100.0
                )
            )
            // xOffset<= 0.0 yOffset <= 0.0，预期：正常
            FloatLayout(
                vLayoutContent: this.layoutContent,
                vLayoutData: data,
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 100.0,
                    layoutHeight: 100.0,
                    xOffset: -20.0,
                    yOffset: -20.0,
                )
            )
            // 0.0 < xOffset <= 设备宽度 0.0 < yOffset <= 设备高度，预期：正常
            FloatLayout(
                vLayoutContent: this.layoutContent,
                vLayoutData: data,
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 100.0,
                    layoutHeight: 100.0,
                    xOffset: 120.0,
                    yOffset: 120.0,
                )
            )
            // xOffset > 设备宽度yOffset > 设备高度,预期 消失
            FloatLayout(
                vLayoutContent: this.layoutContent,
                vLayoutData: data,
                floatAttribute: FixAreaAttributes(
                    layoutWidth: 100.0,
                    layoutHeight: 100.0,
                    xOffset: 520.0,
                    yOffset: 1120.0,
                )
            )

        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xDCDCDC)
    }

}
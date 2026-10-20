package ohos_app_cangjie_entry.level0

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestBannerLayoutVerticalItemSpace {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType(layoutText: "0"),
        layoutDataType(layoutText: "1"),
        layoutDataType(layoutText: "2"),
        layoutDataType(layoutText: "3"),
        layoutDataType(layoutText: "4"),
        layoutDataType(layoutText: "5")
    ]

    @Builder func bannerLayoutContent(item: layoutDataType, position: Int64) {
        Text("Banner: ${item.layoutText}")
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
                    Text("layoutVertical 缺省，预期：水平------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000
                        )
                    )

                    Text("layoutVertical true，预期：垂直------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            layoutAutoPlay: true,
                            layoutLoop: true,
                            layoutVertical: true
                        )
                    )

                    Text("layoutItemSpace 缺省，预期：默认0------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            layoutAutoPlay: true,
                            layoutLoop: true
                        )
                    )

                    Text("layoutItemSpace <= 0，预期：默认0------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            layoutAutoPlay: true,
                            layoutLoop: true,
                            layoutItemSpace: -40
                        )
                    )
                    Text("0 < layoutItemSpace <= 100，预期：正常------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            layoutAutoPlay: true,
                            layoutLoop: true,
                            layoutItemSpace: 40
                        )
                    )
                    Text("100 < layoutItemSpace < 设备宽度 ，预期：正常------").height(80).fontSize(14)
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: data,
                        bannerAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            layoutAutoPlay: true,
                            layoutLoop: true,
                            layoutItemSpace: 140
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
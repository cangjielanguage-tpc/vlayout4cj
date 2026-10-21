package ohos_app_cangjie_entry.level1

import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.Builder

@Entry
@Component
class TestRangeGridAll {
    private var vScroller: Scroller = Scroller()
    var data: Array<layoutDataType> = [
        layoutDataType( layoutText: '0', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '1', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '2', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '3', layoutColor: 0x00FF00 ),

        layoutDataType( layoutText: '4', colsSpan: 2, layoutColor: 0xFF0000 ),
        layoutDataType( layoutText: '5', colsSpan: 2, layoutColor: 0xFF0000 ),
        layoutDataType( layoutText: '6', colsSpan: 2, layoutColor: 0xFF0000 ),
        layoutDataType( layoutText: '7', colsSpan: 2, layoutColor: 0xFF0000 ),

        layoutDataType( layoutText: '8',  layoutColor: 0xFFFF00 ),
        layoutDataType( layoutText: '9',  layoutColor: 0xFFFF00 ),
        layoutDataType( layoutText: '10',  layoutColor: 0xFFFF00 ),
        layoutDataType( layoutText: '11',  layoutColor: 0xFFFF00 ),

        layoutDataType( layoutText: '12', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '13', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '14', layoutColor: 0x00FF00 ),
        layoutDataType( layoutText: '15', layoutColor: 0x00FF00 )
    ]

    @Builder func layoutContent(item: layoutDataType, position: Int64, itemHeight: Float64) {
        Column() {
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

        }
        .padding(5)
        .backgroundColor(item.layoutColor)
        .margin(
           top: if(position == 4 || position == 5 || position == 8 || position == 9) { 10 } else { 0 },
           right: if(position == 5 || position == 7 || position == 9 || position == 11) { 10 } else { 0 } ,
           bottom: if(position == 6 || position == 7 || position == 10 || position == 11) { 5 } else { 0},
           left: if(position == 4 || position == 6 || position == 8 || position == 10) { 10 } else { 0 }
         )
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
                    Text("layoutHeight-spanCount-weights-aspectRatio---").height(80).fontSize(14)
                    RangeGridLayout(
                        vLayoutContent: this.layoutContent,
                        vLayoutData: data,
                        rangeGridAttribute: GridAttributes(
                            layoutHeight: 500.0,
                            spanCount: 4,
                            weights: [20.0, 26.6, 26.6, 26.6],
                            aspectRatio: 4.0,
                            bgColor: 0x00FF00,
                            padding: [10.0, 10.0, 10.0, 10.0],
                            margin: [10.0, 10.0, 10.0, 10.0],
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
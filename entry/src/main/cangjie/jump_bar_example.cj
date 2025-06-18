/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package ohos_app_cangjie_entry

import ohos.state_macro_manage.*
import std.collection.ArrayList

@Entry
@Component
class JumpBarExample {
    private var vScroller: Scroller = Scroller()
    @State var scroller: Array<Scroller> = [this.vScroller]
    @State var textFirst: Int64 = 0
    @State var textExisting: Int64 = 0
    @State var textCreated: Int64 = 0
    @State var textCount: Int64 = 0
    @State var textInput: Int32 = 0

    private var beArr: Array<Int64> = []
    private var num: Int64 = 0

    @State var data: Array<Array<layoutDataType>> = [
        [
            layoutDataType(layoutText: "0"),
            layoutDataType(layoutText: "1"),
            layoutDataType(layoutText: "2"),
            layoutDataType(layoutText: "3"),
            layoutDataType(layoutText: "4"),
            layoutDataType(layoutText: "5")
        ],
        [
          layoutDataType(layoutText: "1"),
          layoutDataType(layoutText: "2"),
          layoutDataType(layoutText: "3"),
          layoutDataType(layoutText: "4"),
          layoutDataType(layoutText: "5"),
          layoutDataType(layoutText: "6"),
          layoutDataType(layoutText: "7"),
          layoutDataType(layoutText: "8")
        ],
        [
          layoutDataType(layoutText: "9"),
          layoutDataType(layoutText: "10")
        ],
         [
            layoutDataType(layoutText: "14"),
            layoutDataType(layoutText: "15"),
            layoutDataType(layoutText: "16"),
            layoutDataType(layoutText: "17")
        ],
         [
            layoutDataType(layoutText: "18"),
            layoutDataType(layoutText: "19"),
            layoutDataType(layoutText: "20"),
            layoutDataType(layoutText: "21"),
            layoutDataType(layoutText: "22")
        ],
        [
            layoutDataType(layoutText: "23"),
            layoutDataType(layoutText: "24"),
            layoutDataType(layoutText: "25"),
            layoutDataType(layoutText: "26"),
            layoutDataType(layoutText: "27")
        ],
        [
        layoutDataType(layoutText: "28"),
        layoutDataType(layoutText: "29"),
        layoutDataType(layoutText: "30"),
        layoutDataType(layoutText: "31"),
        layoutDataType(layoutText: "32")
        ],

        [
        layoutDataType(layoutText: "33"),
        layoutDataType(layoutText: "34"),
        layoutDataType(layoutText: "35"),
        layoutDataType(layoutText: "36"),
        layoutDataType(layoutText: "37")
        ],

        [
            layoutDataType(layoutText: "38"),
            layoutDataType(layoutText: "39"),
            layoutDataType(layoutText: "40"),
            layoutDataType(layoutText: "41"),
            layoutDataType(layoutText: "42"),
            layoutDataType(layoutText: "43")
        ],

        [
            layoutDataType(layoutText: "44"),
            layoutDataType(layoutText: "45"),
            layoutDataType(layoutText: "46"),
            layoutDataType(layoutText: "47"),
            layoutDataType(layoutText: "48"),
            layoutDataType(layoutText: "49"),
            layoutDataType(layoutText: "50")
        ],
        [
        layoutDataType(layoutText: "51"),
        layoutDataType(layoutText: "52"),
        layoutDataType(layoutText: "53"),
        layoutDataType(layoutText: "54"),
        layoutDataType(layoutText: "55")
        ],
        [
            layoutDataType(layoutText: "56"),
            layoutDataType(layoutText: "57"),
            layoutDataType(layoutText: "58"),
            layoutDataType(layoutText: "59"),
            layoutDataType(layoutText: "60"),
            layoutDataType(layoutText: "61"),
            layoutDataType(layoutText: "62")
        ],
        [
            layoutDataType(layoutText: "63"),
            layoutDataType(layoutText: "64"),
            layoutDataType(layoutText: "65"),
            layoutDataType(layoutText: "66"),
            layoutDataType(layoutText: "67"),
            layoutDataType(layoutText: "68"),
            layoutDataType(layoutText: "69")
        ]

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

    @Builder func gridLayoutContent(item: layoutDataType, position: Int64, gridItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(98.percent)
            .backgroundColor(0xEEEEEE)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(0x999999)
            .fontWeight(FontWeight.Bold)
            .maxLines(1)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)
            .onClick({ _ =>
                Hilog.info(0, "", 'position = ${position}')
            })
    }

    @Builder func onenLayoutContent(item: layoutDataType) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .border(width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
            .fontSize(25)
            .fontColor(Color.BLACK)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .textOverflow(TextOverflow.Ellipsis)

    }

    @Builder func columnLayoutContent(item: layoutDataType, position: Int64, layoutHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(0xEEEEEE)
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

    @Builder func defaultLayoutContent(item: layoutDataType, position: Int64, listItemHeight: Float64) {
        Text("${item.layoutText}")
            .width(100.percent)
            .height(100.percent)
            .backgroundColor(if(position % 2 == 0){ 0xaa00ff00 } else { 0xccff00ff })
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

    func build() {
        Stack(Alignment.Bottom){
            List(scroller: vScroller) {
                ListItem() {
                    BannerLayout(
                        vLayoutContent: this.bannerLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "0"),
                            layoutDataType(layoutText: "1"),
                            layoutDataType(layoutText: "2"),
                            layoutDataType(layoutText: "3"),
                            layoutDataType(layoutText: "4"),
                            layoutDataType(layoutText: "5")
                        ],
                        vLayoutAttribute: BannerAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 20.percent,
                            bgColor: 0xFF0000,
                            margin: [10.0, 10.0,10.0,10.0]
                        )
                    )
                }

                ListItem() {
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "1"),
                          layoutDataType(layoutText: "2"),
                          layoutDataType(layoutText: "3"),
                          layoutDataType(layoutText: "4"),
                          layoutDataType(layoutText: "5"),
                          layoutDataType(layoutText: "6"),
                          layoutDataType(layoutText: "7"),
                          layoutDataType(layoutText: "8")
                        ],
                        vLayoutAttribute: GridAttributes(
                            aspectRatio: 3.0,
                            bgColor: 0xAAAAAA,
                            spanCount: 4,
                            vGap: 3,
                            topMargin: 5.0,
                            bottomMargin: 3.0,
                        )
                  )
                }

                ListItem() {
                    GridLayout(
                        vLayoutContent: this.gridLayoutContent,
                        vLayoutData: [
                          layoutDataType(layoutText: "9"),
                          layoutDataType(layoutText: "10")
                        ],
                        vLayoutAttribute: GridAttributes(
                            aspectRatio: 3.0,
                            bgColor: 0xAAAAAA,
                            spanCount: 2,
                            vGap: 3,
                            topMargin: 2.0,
                            bottomMargin: 2.0,
                        )
                  )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "14"),
                            layoutDataType(layoutText: "15"),
                            layoutDataType(layoutText: "16"),
                            layoutDataType(layoutText: "17")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xff87e543,
                            margin: [5.0, 5.0, 5.0, 5.0],
                            padding:[5.0, 5.0, 5.0, 5.0]
                        )
                    )
                }

                ListItem() {
                    OneLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "18"),
                            layoutDataType(layoutText: "19"),
                            layoutDataType(layoutText: "20"),
                            layoutDataType(layoutText: "21"),
                            layoutDataType(layoutText: "22")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            topMargin: 5.0,
                            bottomMargin: 5.0
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "23"),
                            layoutDataType(layoutText: "24"),
                            layoutDataType(layoutText: "25"),
                            layoutDataType(layoutText: "26"),
                            layoutDataType(layoutText: "27")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "28"),
                            layoutDataType(layoutText: "29"),
                            layoutDataType(layoutText: "30"),
                            layoutDataType(layoutText: "31"),
                            layoutDataType(layoutText: "32")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            colWeights: [40.0, 45.0, 15.0, 60.0, 0.0],
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "33"),
                            layoutDataType(layoutText: "34"),
                            layoutDataType(layoutText: "35"),
                            layoutDataType(layoutText: "36"),
                            layoutDataType(layoutText: "37")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            colWeights: [20.0, 80.0, 0.0, 60.0, 20.0],
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "38"),
                            layoutDataType(layoutText: "39"),
                            layoutDataType(layoutText: "40"),
                            layoutDataType(layoutText: "41"),
                            layoutDataType(layoutText: "42"),
                            layoutDataType(layoutText: "43")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    OneExLayout(
                        vLayoutContent: this.onenLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "44"),
                            layoutDataType(layoutText: "45"),
                            layoutDataType(layoutText: "46"),
                            layoutDataType(layoutText: "47"),
                            layoutDataType(layoutText: "48"),
                            layoutDataType(layoutText: "49"),
                            layoutDataType(layoutText: "50")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            bgColor: 0xba55d3,
                            topMargin: 5.0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    ColumnLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "51"),
                            layoutDataType(layoutText: "52"),
                            layoutDataType(layoutText: "53"),
                            layoutDataType(layoutText: "54"),
                            layoutDataType(layoutText: "55")
                            ],
                        vLayoutAttribute: AbstractFullFillAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 300.vp,
                            colWeights: [40.0, 5.0, 40.0],
                            bgColor: 0xff00f0f0,
                            bottomMargin: 5.0,
                        )
                    )
                }

                ListItem() {
                    DefaultLayout(
                        vLayoutContent: this.defaultLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "56"),
                            layoutDataType(layoutText: "57"),
                            layoutDataType(layoutText: "58"),
                            layoutDataType(layoutText: "59"),
                            layoutDataType(layoutText: "60"),
                            layoutDataType(layoutText: "61"),
                            layoutDataType(layoutText: "62")
                        ],
                        vLayoutAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 200.vp,
                            dividerHeight: 5,
                            margin: [25.0, 5.0, 2.0, 5.0],
                            padding:[15.0, 10.0, 12.0, 10.0]
                        )
                    )
                }

                ListItem() {
                    LinearLayout(
                        vLayoutContent: this.columnLayoutContent,
                        vLayoutData: [
                            layoutDataType(layoutText: "63"),
                            layoutDataType(layoutText: "64"),
                            layoutDataType(layoutText: "65"),
                            layoutDataType(layoutText: "66"),
                            layoutDataType(layoutText: "67"),
                            layoutDataType(layoutText: "68"),
                            layoutDataType(layoutText: "69")
                        ],
                        vLayoutAttribute: LinearAttributes(
                            layoutWidth: 100.percent,
                            layoutHeight: 50.percent,
                        )
                    )
                }


            }
            .onScrollIndex({start: Int32, end: Int32 =>
                //获取First
                this.textFirst = Int64.parse(this.data[Int64(start)][0].layoutText)
                    
                //获取Count
                var afArr: ArrayList<Int64> = ArrayList<Int64>()
                for (i in start..=end) {
                    afArr.append(this.data[Int64(i)].size)
                }
                if (this.num == 0) {
                    this.beArr = afArr.toArray()
                    for (i in 0..this.beArr.size) {
                        this.textCount += this.beArr[i]
                    }
                } else {
                    var after: Int64 = 0
                    for (j in 0..afArr.size) {
                        after += afArr[j]
                    }
                    this.textCount = after
                    this.beArr = afArr.toArray()
                }
                this.num++
            })
            .onScroll({scrollOffset: Float64, state: ScrollState =>
                //获取Existing和Created
                if (scrollOffset < 0.0) {
                    this.textCreated++
                    this.textExisting++
                } else {
                    this.textExisting--
                }
            })

            JumpBar(
                textShow: true,
                textFirst: this.textFirst,
                textExisting: this.textExisting,
                textCreated: this.textCreated,
                textCount: this.textCount,
                textInput: this.textInput,
                scroller: this.scroller,
          )

        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xDCDCDC)
    }
}
/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import std.collection.ArrayList

private const TAG = 'vlayout ONEN_EX_LAYOUT '

  /*
   * 1 + 4
   * -------------------------
   * |       |       |       |
   * |       |   2   |   3   |
   * |       |       |       |
   * |   1   |-------|-------|
   * |       |       |       |
   * |       |   4   |   5   |
   * |       |       |       |
   * -------------------------
   *
   *  1 + 5
   * -------------------------
   * |           |     2     |
   * |     1     |-----------|
   * |           |     3     |
   * -------------------------
   * |       |       |       |
   * |   4   |   5   |   6   |
   * |       |       |       |
   * -------------------------
   *
   *  1 + 6
   * -------------------------
   * |       |   2   |   3   |
   * |       |-------|-------|
   * |   1   |   4   |   5   |
   * |       |-------|-------|
   * |       |   6   |   7   |
   * -------------------------
   */
@Component
public class OneExLayout {
    @BuilderParam var vLayoutContent: (layoutDataType) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var oneExAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var rowWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //一拖n布局的高度

    private var mWeight: Int32 = 0 //一拖5布局的第二行的权重
    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //第一个item的高度
    private var itemHeight1: Float64 = 0.0 //第二个item的高度
    private var itemHeight2: Float64 = 0.0 //第三个item的高度
    private var itemHeight3: Float64 = 0.0 //第四个item的高度
    private var itemHeight4: Float64 = 0.0//第五个item的高度
    private var itemHeight5: Float64 = 0.0//第六个item的高度
    private var itemHeight6: Float64 = 0.0//第七个item的高度


    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(oneExAttribute.range, vLayoutData)
        computedColWeights()
        computedRowWeights()
        computedSize()
    }

    func computedColWeights() {
        if (oneExAttribute.colWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>(vLayoutData.size)
            weightArray.appendAll(oneExAttribute.colWeights)

            if (vLayoutData.size > oneExAttribute.colWeights.size) { //数据源数组长度大于列权重数组长度时
                match (oneExAttribute.colWeights.size) {
                	case 1 =>
                        weightArray = computedColWeights1(weightArray)
                    case 2 =>
                        weightArray = computedColWeights2(weightArray)
                    case 3 =>
                        weightArray = computedColWeights3(weightArray)
                    case 4 =>
                        weightArray = computedColWeights4(weightArray)
                    case 5 =>
                        weightArray = computedColWeights5(weightArray)
                    case 6 =>
                        weightArray = computedColWeights6(weightArray)
                    case _ =>
                        Hilog.error(0x000000, "computedColWeights", '${TAG}computedColWeights else')
                }
            } else { //数据源数组长度小于等于列权重数组长度时
                Hilog.error(0x000000, "computedColWeights", '${TAG}colWeightArray = ${colWeightArray}')
            }
            colWeightArray = weightArray.toArray()
            Hilog.info(0x000000, "computedColWeights", '${TAG}colWeightArray = ${colWeightArray}')
        }
    }

    func computedColWeights1(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        var sum: Float64 = 0.0
        for (i in 0..oneExAttribute.colWeights.size) {
            let element: Float64 = oneExAttribute.colWeights[i];
            sum += element
        }
        match (vLayoutData.size) {
            case 5 =>
                if (sum <= 100.0) {
                    for (j in 0..4) {
                        weightArray.append((100.0 - sum)/2.0)
                    }
                }
            case 6 =>
                if (sum < 100.0) {
                    weightArray.append(100.0 - sum)
                    for (j in 0..2) {
                        weightArray.append((100.0 - sum))
                    }
                    mWeight = 1
                }
            case 7 =>
                if (sum < 100.0) {
                    weightArray.append(100.0 - sum)
                    for (j in 0..6) {
                        weightArray.append((100.0 - sum) / 2.0)
                    }
                }
            case _ =>
                Hilog.error(0x000000, "computedColWeights", '${TAG}computedColWeights error')
        }
        return weightArray
    }

    func computedColWeights2(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 5) {
            weightArray.append(100.0 - weightArray[0] - weightArray[1])
            for (j in 0..2) {
              weightArray.append((100.0 - weightArray[0]) / 2.0)
            }
        }
        if (vLayoutData.size == 6) {
            weightArray.append(100.0 - weightArray[0])
            mWeight = 1
        }
        if (vLayoutData.size == 7) {
            weightArray.append(100.0 - weightArray[0] - weightArray[1])
            for (j in 0..4) {
                weightArray.append((100.0 - weightArray[0]) / 2.0)
            }
        }
        return weightArray
    }

    func computedColWeights3(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 5) {
            for (j in 0..2) {
                weightArray.append((100.0 - weightArray[0] - weightArray[2]) / 2.0)
            }
        }
        if (vLayoutData.size == 6) {
            mWeight = 1
        }
        if (vLayoutData.size == 7) {
            for (j in 0..4) {
                weightArray.append((100.0 - weightArray[0]) / 2.0)
            }
        }
        return weightArray
    }

    func computedColWeights4(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 5) {
            weightArray.append(100.0 - weightArray[0] - weightArray[3])
        }
        if (vLayoutData.size == 6) {
            for (j in 0..2) {
                weightArray.append((100.0 - weightArray[3]) / 2.0)
            }
        }
        if (vLayoutData.size == 7) {
            weightArray.append((100.0 - weightArray[0] - weightArray[3]))
            for (j in 0..2) {
                weightArray.append((100.0 - weightArray[0]) / 2.0)
            }
        }
        return weightArray
    }

    func computedColWeights5(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 6) {
            weightArray.append((100.0 - weightArray[3]- weightArray[4]))
        }
        if (vLayoutData.size == 7) {
            weightArray.append((100.0 - weightArray[0]) / 2.0)
        }
        return weightArray
    }
    func computedColWeights6(weightArrays: ArrayList<Float64>): ArrayList<Float64> {
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 7) {
            weightArray.append((100.0 - weightArray[0]- weightArray[5]))
        }
        return weightArray
    }

    func computedRowWeights() {
        if (oneExAttribute.rowWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>()
            weightArray.appendAll(oneExAttribute.rowWeights)

            if (oneExAttribute.rowWeights.size == 1) {
                if (vLayoutData.size == 5 || vLayoutData.size == 6) {
                    weightArray.append(oneExAttribute.rowWeights[0])
                }
                if (vLayoutData.size == 7) {
                    for (j in 0..2) {
                        weightArray.append(weightArray[0])
                    }
                    weightArray.append(oneExAttribute.rowWeights[0])
                }
            } else if(oneExAttribute.rowWeights.size == 2) {
                if (vLayoutData.size == 7) {
                    weightArray.append(oneExAttribute.rowWeights[0])
                }
            } else {
                Hilog.error(0x000000, "computedRowWeights", '${TAG}computedRowWeights else')
            }
            rowWeightArray = weightArray.toArray()
            Hilog.info(0x000000, "computedRowWeights", '${TAG}rowWeightArray = ${rowWeightArray}')
        }
    }

    func computedSize() {
        layoutHeight = oneExAttribute.layoutHeight.value
        computedLayoutHeight()
    }

    func computedLayoutHeight() {
        match (vLayoutData.size) {
        	case 5 =>
                if (max(itemHeight1 + itemHeight3, itemHeight2 + itemHeight4) >= itemHeight) {
                    layoutHeight = max(itemHeight1 + itemHeight3, itemHeight2 + itemHeight4)
                } else {
                    layoutHeight = itemHeight
                }
        	case 6 =>
                if (itemHeight1 + itemHeight2 >= itemHeight) {
                    layoutHeight = max(max(itemHeight3, itemHeight4), itemHeight5) + itemHeight1 + itemHeight2
                } else {
                    layoutHeight = max(max(itemHeight3, itemHeight4), itemHeight5) + itemHeight
                }
        	case 7 =>
                if (max(itemHeight1 + itemHeight3 + itemHeight5, itemHeight2 + itemHeight4 + itemHeight6) >= itemHeight) {
                    layoutHeight = max(itemHeight1 + itemHeight3 + itemHeight5, itemHeight2 + itemHeight4 + itemHeight6)
                } else {
                    layoutHeight = itemHeight
                }
        	case _ => Hilog.error(0x000000, "computedLayoutHeight", '${TAG}computedLayoutHeight error')
        }

        computedExtraHeight()
    }

    func computedExtraHeight() {
        layoutHeight = layoutHeight + oneExAttribute.topPadding
        layoutHeight = layoutHeight + oneExAttribute.bottomPadding
    }

    func build() {
        Column() {
            Row(){
                if(vLayoutData.size == 5) {
                    Row() {
                        Column() {vLayoutContent(vLayoutData[0])}
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {34.percent} else {colWeightArray[0].percent})
                        .height(if(rowWeightArray.size == 0) {100.percent} else {rowWeightArray[0].percent})

                        Column() {
                            Row() {
                                Row() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent}else {colWeightArray[1].percent})

                                Row() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent}else {colWeightArray[2].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {
                                Row() {vLayoutContent(vLayoutData[3])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight3 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    computedSize()
                                })
                                .width( if(colWeightArray.size == 0) {50.percent}else {colWeightArray[3].percent})

                                Row() {vLayoutContent(vLayoutData[4])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight4 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent}else {colWeightArray[4].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})
                        }
                        .alignItems(HorizontalAlign.Start)
                        .width( if(colWeightArray.size == 0) {66.percent} else {100.percent})
                    }
                }
                else if(vLayoutData.size == 6) {
                    Column() {
                        Row() {
                            Column() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(if(colWeightArray.size == 0) {50.percent}else {colWeightArray[0].percent})

                            Column() {
                                Row() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                                .layoutWeight(1)

                                Row() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                                .layoutWeight(1)
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                        .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                        Row() {
                            Column() {vLayoutContent(vLayoutData[3])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight3 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight3}')
                                computedSize()
                            })
                            .width(if(colWeightArray.size == 0) {33.percent} else {colWeightArray[3].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {mWeight})

                            Column() {vLayoutContent(vLayoutData[4])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                computedSize()
                            })
                            .width(if(colWeightArray.size == 0) {33.percent} else {colWeightArray[4].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {mWeight})

                            Column() {vLayoutContent(vLayoutData[5])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight5 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight5}')
                                computedSize()
                            })
                            .width(if(colWeightArray.size == 0) {33.percent} else {colWeightArray[5].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {mWeight})
                        }
                        .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})

                    }.alignItems(HorizontalAlign.Start)
                }
                else if(vLayoutData.size == 7) {
                    Row() {
                        Column() {vLayoutContent(vLayoutData[0])}
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {34.percent} else {colWeightArray[0].percent})

                        Column() {
                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})

                                Column() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[3])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight3 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight3}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[3].percent})

                                Column() {vLayoutContent(vLayoutData[4])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight4 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[4].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[5])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight5 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight5}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[5].percent})

                                Column() {vLayoutContent(vLayoutData[6])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight6 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight6}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[6].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[2])})
                        }
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {66.percent}else {100.percent})
                    }
                }
                else {
                    TextCommon(text: "please more than 1+3 and less than 1+7")
                }

            }
            .width(oneExAttribute.layoutWidth)
            .height(if(oneExAttribute.layoutHeight.value == 0.0) { layoutHeight.vp } else { oneExAttribute.layoutHeight })
            .padding(
                top: if(oneExAttribute.padding.size == 4) {
                    oneExAttribute.padding[0]
                } else {
                    oneExAttribute.topPadding
                },
                right: if(oneExAttribute.padding.size == 4) {
                    oneExAttribute.padding[1]
                } else {
                    oneExAttribute.rightPadding
                },
                bottom: if(oneExAttribute.padding.size == 4) {
                    oneExAttribute.padding[2]
                } else {
                    oneExAttribute.bottomPadding
                },
                left: if(oneExAttribute.padding.size == 4) {
                    oneExAttribute.padding[3]
                } else {
                    oneExAttribute.leftPadding
                }
            )
        }
        .backgroundColor(oneExAttribute.bgColor)
        .opacity(oneExAttribute.bgOpacity)
        .zIndex(oneExAttribute.zIndex)
        .margin(
            top: if(oneExAttribute.margin.size == 4) {
                oneExAttribute.margin[0]
            } else {
                oneExAttribute.topMargin
            },
            right:  if(oneExAttribute.margin.size == 4) {
                oneExAttribute.margin[1]
            } else {
                oneExAttribute.rightMargin
            },
            bottom: if(oneExAttribute.margin.size == 4) {
                oneExAttribute.margin[2]
            } else {
                oneExAttribute.bottomMargin
            },
            left: if(oneExAttribute.margin.size == 4) {
                oneExAttribute.margin[3]
            } else {
                oneExAttribute.leftMargin
            }
        )
    }
}
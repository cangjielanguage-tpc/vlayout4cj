/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import std.collection.ArrayList

private const TAG = 'vlayout ONEN_LAYOUT '

/*
 * 1 + 0
 * -------------------------
 * |                       |
 * |                       |
 * |           1           |
 * |                       |
 * |                       |
 * |                       |
 * -------------------------
 *
 * 1 + 1
 * -------------------------
 * |           |           |
 * |           |           |
 * |           |           |
 * |     1     |     2     |
 * |           |           |
 * |           |           |
 * |           |           |
 * -------------------------
 *
 * 1 + 2
 * -------------------------
 * |           |           |
 * |           |     2     |
 * |           |           |
 * |     1     |-----------|
 * |           |           |
 * |           |     3     |
 * |           |           |
 * -------------------------
 *
 * 1 + 3
 * -------------------------
 * |           |           |
 * |           |     2     |
 * |           |           |
 * |     1     |-----------|
 * |           |     |     |
 * |           |  3  |  4  |
 * |           |     |     |
 * -------------------------
 *
 *  1 + 4
 * -------------------------
 * |           |           |
 * |           |     2     |
 * |           |           |
 * |     1     |-----------|
 * |           |   |   |   |
 * |           | 3 | 4 | 5 |
 * |           |   |   |   |
 * -------------------------
 */
@Component
public class OneLayout {
    @BuilderParam var vLayoutContent: (layoutDataType) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State var oneAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var rowWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //一拖n布局的高度

    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //第一个item的高度
    private var itemHeight1: Float64 = 0.0 //第二个item的高度
    private var itemHeight2: Float64 = 0.0 //第三个item的高度
    private var itemHeight3: Float64 = 0.0 //第四个item的高度
    private var itemHeight4: Float64 = 0.0//第五个item的高度

    protected override func aboutToAppear() {
        vLayoutData = CommonFunc.computedRange(oneAttribute.range, vLayoutData)
        computedColWeights()
        computedRowWeights()
        computedSize()
    }

    func computedColWeights() {
        if (oneAttribute.colWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>(vLayoutData.size)
            weightArray.add(all: oneAttribute.colWeights)

            if (vLayoutData.size > oneAttribute.colWeights.size) { //数据源数组长度大于列权重数组长度时
                match (oneAttribute.colWeights.size) {
                	case 1 =>
                        weightArray = computedColWeightsSize1(weightArray)
                    case 2 =>
                        weightArray = computedColWeightsSize2(weightArray)
                    case 3 =>
                        weightArray = computedColWeightsSize3(weightArray)
                    case 4 =>
                        weightArray = computedColWeightsSize4(weightArray)
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

    func computedColWeightsSize1(weightArrays: ArrayList<Float64>): ArrayList<Float64>{
        var weightArray: ArrayList<Float64> = weightArrays
        var sum: Float64 = 0.0
        for (i in 0..oneAttribute.colWeights.size) {
            let element: Float64 = oneAttribute.colWeights[i];
            sum += element
        }
        match (vLayoutData.size) {
            case 2 =>
                if (sum <= 100.0) {
                    weightArray.add(100.0 - sum)
                }
            case 3 =>
                if (sum <= 100.0) {
                    for (j in 0..2) {
                        weightArray.add(100.0 - sum)
                    }
                }
            case 4 =>
                if (sum < 100.0) {
                    weightArray.add(100.0 - sum)
                    for (j in 0..2) {
                        weightArray.add((100.0 - sum) / 2.0)
                    }
                }
            case 5 =>
                if (sum < 100.0) {
                    weightArray.add(100.0 - sum)
                    for (j in 0..3) {
                        weightArray.add((100.0 - sum) / 3.0)
                    }
                }
            case _ =>
                Hilog.error(0x000000, "computedColWeights", '${TAG}computedColWeights error')

        }
        return weightArray
    }

    func computedColWeightsSize2(weightArrays: ArrayList<Float64>): ArrayList<Float64>{
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 3) {
            weightArray.add(100.0 - weightArray[0])
        }
        if (vLayoutData.size == 4) {
            for (j in 0..2) {
                weightArray.add((100.0 - weightArray[0]) / 2.0)
            }
        }
        if (vLayoutData.size == 5) {
            for (j in 0..3) {
                weightArray.add((100.0 - weightArray[0]) / 3.0)
            }
        }
        return weightArray
    }

    func computedColWeightsSize3(weightArrays: ArrayList<Float64>): ArrayList<Float64>{
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 4) {
            weightArray.add(100.0 - weightArray[0] - weightArray[2])
        }
        if (vLayoutData.size == 5) {
            for (j in 0..2) {
                weightArray.add((100.0 - weightArray[0] - weightArray[2]) / 2.0)
            }
        }
        return weightArray
    }

    func computedColWeightsSize4(weightArrays: ArrayList<Float64>): ArrayList<Float64>{
        var weightArray: ArrayList<Float64> = weightArrays
        if (vLayoutData.size == 5) {
            weightArray.add(100.0 - weightArray[0] - weightArray[2] - weightArray[3])
        }
        return weightArray
    }

    func computedRowWeights() {
        if (oneAttribute.rowWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>()
            weightArray.add(all: oneAttribute.rowWeights)

            if (oneAttribute.rowWeights.size == 1) {
                if (vLayoutData.size == 3 || vLayoutData.size == 4 || vLayoutData.size == 5) {
                    weightArray.add(100.0 - oneAttribute.rowWeights[0])
                }
            } else {
                Hilog.error(0x000000, "computedRowWeights", '${TAG}computedRowWeights else')
            }
            rowWeightArray = weightArray.toArray()
            Hilog.info(0x000000, "computedRowWeights", '${TAG}rowWeightArray = ${rowWeightArray}')
        }
    }

    func computedSize() {
        layoutHeight = oneAttribute.layoutHeight.value
        computedLayoutHeight()
    }

    func computedLayoutHeight() {
        match (vLayoutData.size) {
        	case 1 => layoutHeight = itemHeight
        	case 2 => layoutHeight = max(itemHeight1, itemHeight2)
        	case 3 =>
                computedLayoutHeight3()
        	case 4 =>
                computedLayoutHeight4()
        	case 5 =>
                computedLayoutHeight5()
        	case _ => Hilog.error(0x000000, "computedLayoutHeight", '${TAG}computedLayoutHeight error')
        }

        computedExtraHeight()
    }

    func computedLayoutHeight3() {
        if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
            layoutHeight = max(itemHeight1, itemHeight2) + itemHeight
        } else if (!oneAttribute.hasHeader && oneAttribute.hasFooter) {
            layoutHeight = max(itemHeight, itemHeight1) + itemHeight2
        } else if (oneAttribute.hasHeader && oneAttribute.hasFooter) {
            layoutHeight = itemHeight + itemHeight1 + itemHeight2
        } else {
            if (itemHeight1 + itemHeight2 >= itemHeight) {
                layoutHeight = itemHeight1 + itemHeight2
            } else {
                layoutHeight = max(max(itemHeight, itemHeight1), itemHeight2)
            }
        }
    }

    func computedLayoutHeight4() {
        if (itemHeight1 >= itemHeight2 + itemHeight3) {
            if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
                layoutHeight = itemHeight + itemHeight1
            } else {
                layoutHeight = itemHeight + itemHeight2 + itemHeight3
            }
        } else if (!oneAttribute.hasHeader && oneAttribute.hasFooter) {
            if (itemHeight1 + itemHeight2 >= itemHeight) {
                layoutHeight = itemHeight1 + itemHeight2 + itemHeight3
            } else {
                layoutHeight = itemHeight + itemHeight3
            }
        } else if (oneAttribute.hasHeader && oneAttribute.hasFooter) {
            layoutHeight = itemHeight + max(itemHeight1, itemHeight2) + itemHeight3
        } else {
            if (itemHeight1 + max(itemHeight2, itemHeight3) >= itemHeight) {
                layoutHeight = itemHeight1 + max(itemHeight2, itemHeight3)
            } else {
                layoutHeight = max(max(itemHeight, itemHeight1), max(itemHeight2, itemHeight3))
            }
        }
    }

    func computedLayoutHeight5() {
        if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
            if (itemHeight2 + max(itemHeight3, itemHeight4) >= itemHeight1) {
                layoutHeight = itemHeight + itemHeight2 + max(itemHeight3, itemHeight4)
            } else {
                layoutHeight = itemHeight + itemHeight1
            }
        } else if (!oneAttribute.hasHeader && oneAttribute.hasFooter) {
            if (itemHeight1 + max(itemHeight2, itemHeight3) >= itemHeight) {
                layoutHeight = itemHeight1 + max(itemHeight2, itemHeight3) + itemHeight4
            } else {
                layoutHeight = itemHeight + itemHeight4
            }
        } else if (oneAttribute.hasHeader && oneAttribute.hasFooter) {
            if (itemHeight2 + itemHeight3 >= itemHeight1) {
                layoutHeight = itemHeight + itemHeight2 + itemHeight3 + itemHeight4
            } else {
                layoutHeight = itemHeight + itemHeight1 + itemHeight4
            }
        } else {
            if (itemHeight1 + max(max(itemHeight2, itemHeight3), itemHeight4) >= itemHeight) {
                layoutHeight = itemHeight1 + max(max(itemHeight2, itemHeight3), itemHeight4)
            } else {
                layoutHeight = max(max(itemHeight, itemHeight1),max(max(itemHeight2, itemHeight3), itemHeight4))
            }
        }
    }

    func computedExtraHeight() {
        layoutHeight = layoutHeight + oneAttribute.topPadding
        layoutHeight = layoutHeight + oneAttribute.bottomPadding
    }

    func build() {
        Column() {
            Row(){
                if(vLayoutData.size == 1) {
                    Row() {
                        Column() {vLayoutContent(vLayoutData[0])}
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {100.percent } else {colWeightArray[0].percent})
                        .height(if(rowWeightArray.size == 0) {100.percent} else {rowWeightArray[0].percent})
                    }
                }
                else if (vLayoutData.size == 2) {
                    Row() {
                        Column() {vLayoutContent(vLayoutData[0])}
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight1 = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[0].percent})

                        Column() {vLayoutContent(vLayoutData[1])}
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight2 =px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                    }
                } else if (vLayoutData.size == 3) {
                    if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if(colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1} else { Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent })

                                Column() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if(colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent  })
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1 } else {Int32(rowWeightArray[1]) })

                        }.alignItems(HorizontalAlign.Start)
                    } else if(!oneAttribute.hasHeader && oneAttribute.hasFooter) {
                        Column() {
                            Row() {
                                Column() {vLayoutContent(vLayoutData[0])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                    computedSize()
                                })
                                .width( if (colWeightArray.size == 0) {50.percent} else {colWeightArray[0].percent})

                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})}
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() { vLayoutContent(vLayoutData[2]) }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight2 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) { 100.percent } else { colWeightArray[2].percent })
                            .layoutWeight(if (rowWeightArray.size == 0) { 1 } else { Int32(rowWeightArray[1]) })
                        }.alignItems(HorizontalAlign.Start)
                    } else if(oneAttribute.hasHeader && oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {vLayoutContent(vLayoutData[1])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight1 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[1].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})

                            Row() {vLayoutContent(vLayoutData[2])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight2 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[2].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})
                        }.alignItems(HorizontalAlign.Start)
                    } else {
                        Row() {
                            Column() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[0].percent})

                            Column() {
                                Row() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                                .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                                Row() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                                .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])}
                                )
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                } else if(vLayoutData.size == 4) {
                    if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})

                                Column() {
                                    Row() {vLayoutContent(vLayoutData[2])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                                    .layoutWeight(if(oneAttribute.layoutHeight.value == 0.0) {0}else {1})

                                    Row() {vLayoutContent(vLayoutData[3])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[3].percent})
                                    .layoutWeight(if(oneAttribute.layoutHeight.value == 0.0) {0}else {1})
                                }.alignItems(HorizontalAlign.Start)
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[1])}
                            )
                        }.alignItems(HorizontalAlign.Start)
                    }else if (oneAttribute.hasHeader && oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})

                                Column() {vLayoutContent(vLayoutData[2])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                            }
                            .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[1])})

                            Row() {vLayoutContent(vLayoutData[3])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight3 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[3].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[0])})
                        }.alignItems(HorizontalAlign.Start)
                    }else {
                        Row() {
                            Column() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[0].percent})

                            Column() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .alignItems(HorizontalAlign.Start)
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                                .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[0])})

                                Row() {
                                    Column() {vLayoutContent(vLayoutData[2])}
                                    .onAreaChange({ oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})

                                    Column() {vLayoutContent(vLayoutData[3])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[3].percent})
                                }
                                .width(if (colWeightArray.size == 0) {50.percent} else {100.percent})
                                .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[1])}
                                )
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                }
                else if (vLayoutData.size == 5) {
                    if (oneAttribute.hasHeader && !oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if(rowWeightArray.size == 0) {1}else {Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})

                                Column() {
                                    Row() {vLayoutContent(vLayoutData[2])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})

                                    Row() {
                                        Column() {vLayoutContent(vLayoutData[3])}
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight3 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                            computedSize()
                                        })
                                        .width(if (colWeightArray.size == 0) {25.percent} else {colWeightArray[3].percent})

                                        Column() {vLayoutContent(vLayoutData[4])}
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight4 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                            computedSize()
                                        })
                                        .width(if (colWeightArray.size == 0) {25.percent} else {colWeightArray[4].percent})
                                    }
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                            }
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})
                        }.alignItems(HorizontalAlign.Start)
                    }else if (!oneAttribute.hasHeader && oneAttribute.hasFooter) {
                        Column() {
                            Row() {
                                Column() {vLayoutContent(vLayoutData[0])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, height = ${itemHeight}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[0].percent})

                                Column() {
                                    Row() {vLayoutContent(vLayoutData[1])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight1 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})

                                    Row() {
                                        Column() {vLayoutContent(vLayoutData[2])}
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight2 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                            computedSize()
                                        })
                                        .width(if (colWeightArray.size == 0) {25.percent} else {colWeightArray[2].percent})

                                        Column() {vLayoutContent(vLayoutData[3])}
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight3 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                            computedSize()
                                        })
                                        .width(if (colWeightArray.size == 0) {25.percent} else {colWeightArray[3].percent})
                                    }
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                            }
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {vLayoutContent(vLayoutData[4])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[4].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})
                        }.alignItems(HorizontalAlign.Start)
                    } else if (oneAttribute.hasHeader && oneAttribute.hasFooter) {
                        Column() {
                            Row() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[0].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                            Row() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(if (colWeightArray.size == 0) {50.percent } else {colWeightArray[1].percent})

                                Column() {
                                    Row() {vLayoutContent(vLayoutData[2])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[2].percent})
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})

                                    Row() {vLayoutContent(vLayoutData[3])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[3].percent})
                                    .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(if (oneAttribute.layoutHeight.value == 0.0) {0} else {1})
                            }
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})

                            Row() {vLayoutContent(vLayoutData[4])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                computedSize()
                            })
                            .width(if (colWeightArray.size == 0) {100.percent} else {colWeightArray[4].percent})
                            .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})
                        }.alignItems(HorizontalAlign.Start)
                    }else {
                        Row() {
                            Column() {vLayoutContent(vLayoutData[0])}
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(if (colWeightArray.size == 0) {50.percent } else {colWeightArray[0].percent})

                            Column() {
                                Column() {vLayoutContent(vLayoutData[1])}
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .alignItems(HorizontalAlign.Start)
                                .width(if (colWeightArray.size == 0) {50.percent} else {colWeightArray[1].percent})
                                .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[0])})

                                Row() {
                                    Column() {vLayoutContent(vLayoutData[2])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {33.percent} else {colWeightArray[2].percent})
                                    .layoutWeight(if (rowWeightArray.size == 0) {1} else {0})

                                    Column() {vLayoutContent(vLayoutData[3])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {33.percent} else {colWeightArray[3].percent})
                                    .layoutWeight(if (rowWeightArray.size == 0) {1} else {0})

                                    Column() {vLayoutContent(vLayoutData[4])}
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight4 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                        computedSize()
                                    })
                                    .width(if (colWeightArray.size == 0) {33.percent} else {colWeightArray[4].percent})
                                    .layoutWeight(if (rowWeightArray.size == 0) {1} else {0})

                                }
                                .width(if (colWeightArray.size == 0) {50.percent} else {100.percent})
                                .layoutWeight(if (rowWeightArray.size == 0) {1} else {Int32(rowWeightArray[1])})
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                }
                else {
                    TextCommon(text: "please less than 1+5")
                }

            }
            .width(oneAttribute.layoutWidth)
            .height(if(oneAttribute.layoutHeight.value == 0.0) { layoutHeight.vp } else { oneAttribute.layoutHeight })
            .padding(
                top: if(oneAttribute.padding.size == 4) {
                    oneAttribute.padding[0]
                } else {
                    oneAttribute.topPadding
                },
                right: if(oneAttribute.padding.size == 4) {
                    oneAttribute.padding[1]
                } else {
                    oneAttribute.rightPadding
                },
                bottom: if(oneAttribute.padding.size == 4) {
                    oneAttribute.padding[2]
                } else {
                    oneAttribute.bottomPadding
                },
                left: if(oneAttribute.padding.size == 4) {
                    oneAttribute.padding[3]
                } else {
                    oneAttribute.leftPadding
                }
            )
        }
        .backgroundColor(oneAttribute.bgColor)
        .opacity(oneAttribute.bgOpacity)
        .zIndex(oneAttribute.zIndex)
        .margin(
            top: if(this.oneAttribute.margin.size == 4) {
                this.oneAttribute.margin[0]
            } else {
                this.oneAttribute.topMargin
            },
            right:  if(this.oneAttribute.margin.size == 4) {
                this.oneAttribute.margin[1]
            } else {
                this.oneAttribute.rightMargin
            },
            bottom: if(this.oneAttribute.margin.size == 4) {
                this.oneAttribute.margin[2]
            } else {
                this.oneAttribute.bottomMargin
            },
            left: if(this.oneAttribute.margin.size == 4) {
                this.oneAttribute.margin[3]
            } else {
                this.oneAttribute.leftMargin
            }
        )
    }
}
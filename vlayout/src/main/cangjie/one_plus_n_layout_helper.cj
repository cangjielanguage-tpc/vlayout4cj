/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
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

    @State @Watch[defaultValueInit] var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性
    @State var onePlusNInfo: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

    @State var colWeightArray: Array<Float64> = []
    @State var rowWeightArray: Array<Float64> = []
    @State var layoutHeight: Float64 = 0.0 //一拖n布局的高度
    @State var aspectRatio: Float64 = 0.0 //
    @State var layoutWidth: Float64 = 0.0 //
    private var itemWidth: Float64 = 0.0 //每个item的宽度
    private var itemHeight: Float64 = 0.0 //第一个item的高度
    private var itemHeight1: Float64 = 0.0 //第二个item的高度
    private var itemHeight2: Float64 = 0.0 //第三个item的高度
    private var itemHeight3: Float64 = 0.0 //第四个item的高度
    private var itemHeight4: Float64 = 0.0//第五个item的高度

    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        defaultValueInit()
        computedRange()
        computedColWeights()
        computedRowWeights()
        computedSize()
    }

    func defaultValueInit() {
        onePlusNInfo = AbstractFullFillAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            rowWeights: vLayoutAttribute.rowWeights,
            colWeights:  vLayoutAttribute.colWeights,
            hasHeader: vLayoutAttribute.hasHeader,
            hasFooter: vLayoutAttribute.hasFooter,
            layoutWidth: vLayoutAttribute.layoutWidth,
            layoutHeight: vLayoutAttribute.layoutHeight,
            aspectRatio: vLayoutAttribute.aspectRatio,
            bgColor: vLayoutAttribute.bgColor,
            zIndex: vLayoutAttribute.zIndex,
            padding: vLayoutAttribute.padding,
            topPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[0]
            } else {
                vLayoutAttribute.topPadding
            },
            rightPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[1]
            } else {
                vLayoutAttribute.rightPadding
            },
            bottomPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[2]
            } else {
                vLayoutAttribute.bottomPadding
            },
            leftPadding: if(vLayoutAttribute.padding.size == 4) {
                vLayoutAttribute.padding[3]
            } else {
                vLayoutAttribute.leftPadding
            },
            margin: vLayoutAttribute.margin,
            topMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[0]
            } else {
                vLayoutAttribute.topMargin
            },
            rightMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[1]
            } else {
                vLayoutAttribute.rightMargin
            },
            bottomMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[2]
            } else {
                vLayoutAttribute.bottomMargin
            },
            leftMargin: if(vLayoutAttribute.margin.size == 4) {
                vLayoutAttribute.margin[3]
            } else {
                vLayoutAttribute.leftMargin
            }
            )
    }
    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        if (onePlusNInfo.range.size == 2 && onePlusNInfo.range[0] >= 0 && onePlusNInfo.range[1] > onePlusNInfo.range[0]) {
            vLayoutData = vLayoutData.slice(onePlusNInfo.range[0], onePlusNInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func computedColWeights() {
        if (onePlusNInfo.colWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>(vLayoutData.size)
            weightArray.appendAll(onePlusNInfo.colWeights)

            if (vLayoutData.size > onePlusNInfo.colWeights.size) { //数据源数组长度大于列权重数组长度时
                match (onePlusNInfo.colWeights.size) {
                	case 1 =>
                        var sum: Float64 = 0.0
                        for (i in 0..onePlusNInfo.colWeights.size) {
                            let element: Float64 = onePlusNInfo.colWeights[i];
                            sum += element
                        }
                        match (vLayoutData.size) {
                            case 2 =>
                                if (sum <= 100.0) {
                                    weightArray.append(100.0 - sum)
                                }
                            case 3 =>
                                if (sum <= 100.0) {
                                    for (j in 0..2) {
                                        weightArray.append(100.0 - sum)
                                    }
                                }
                            case 4 =>
                                if (sum < 100.0) {
                                    weightArray.append(100.0 - sum)
                                    for (j in 0..2) {
                                        weightArray.append((100.0 - sum) / 2.0)
                                    }
                                }
                            case 5 =>
                                if (sum < 100.0) {
                                    weightArray.append(100.0 - sum)
                                    for (j in 0..3) {
                                        weightArray.append((100.0 - sum) / 3.0)
                                    }
                                }
                            case _ =>
                                Hilog.error(0x000000, "computedColWeights", '${TAG}computedColWeights error')

                        }
                    case 2 =>
                        if (vLayoutData.size == 3) {
                            weightArray.append(100.0 - weightArray[0])
                        }
                        if (vLayoutData.size == 4) {
                            for (j in 0..2) {
                                weightArray.append((100.0 - weightArray[0]) / 2.0)
                            }
                        }
                        if (vLayoutData.size == 5) {
                            for (j in 0..3) {
                                weightArray.append((100.0 - weightArray[0]) / 3.0)
                            }
                        }
                    case 3 =>
                        if (vLayoutData.size == 4) {
                            weightArray.append(100.0 - weightArray[0] - weightArray[2])
                        }
                        if (vLayoutData.size == 5) {
                            for (j in 0..2) {
                                weightArray.append((100.0 - weightArray[0] - weightArray[2]) / 2.0)
                            }
                        }
                    case 4 =>
                        if (vLayoutData.size == 5) {
                            weightArray.append(100.0 - weightArray[0] - weightArray[2] - weightArray[3])
                        }
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

    func computedRowWeights() {
        if (onePlusNInfo.rowWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>()
            weightArray.appendAll(onePlusNInfo.rowWeights)

            if (onePlusNInfo.rowWeights.size == 1) {
                if (vLayoutData.size == 3 || vLayoutData.size == 4 || vLayoutData.size == 5) {
                    weightArray.append(100.0 - onePlusNInfo.rowWeights[0])
                }
            } else {
                Hilog.error(0x000000, "computedRowWeights", '${TAG}computedRowWeights else')
            }
            rowWeightArray = weightArray.toArray()
            Hilog.info(0x000000, "computedRowWeights", '${TAG}rowWeightArray = ${rowWeightArray}')
        }
    }

    func computedSize() {
        //当容器宽度未定义了，默认屏幕宽度
        //当容器纵横比定义了就相当于容器宽度定义了
        if (onePlusNInfo.layoutWidth == 0.0 && onePlusNInfo.layoutHeight == 0.0 && onePlusNInfo.aspectRatio == 0.0) {
            //当不设置容器宽度、高度、纵横比时，宽度默认屏幕宽度，纵横比默认1；
            layoutWidth = screenWidth
            aspectRatio = 1.0
            layoutHeight = layoutWidth / aspectRatio

            computedLayoutHeight()
        } else if (onePlusNInfo.layoutWidth != 0.0 && onePlusNInfo.layoutHeight == 0.0 && onePlusNInfo.aspectRatio == 0.0) {
            //当设置容器宽度，不设置高度、纵横比时，纵横比默认1；
            layoutWidth = onePlusNInfo.layoutWidth
            aspectRatio = 1.0
            layoutHeight = layoutWidth / aspectRatio
            computedLayoutHeight()
        } else if (onePlusNInfo.layoutWidth == 0.0 && onePlusNInfo.layoutHeight != 0.0 && onePlusNInfo.aspectRatio == 0.0) {
            layoutWidth = screenWidth
            layoutHeight = onePlusNInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (onePlusNInfo.layoutWidth == 0.0 && onePlusNInfo.layoutHeight == 0.0 && onePlusNInfo.aspectRatio != 0.0) {
            layoutWidth = screenWidth
            layoutHeight = layoutWidth / onePlusNInfo.aspectRatio
            aspectRatio = onePlusNInfo.aspectRatio
            computedLayoutHeight()
        } else if (onePlusNInfo.layoutWidth != 0.0 && onePlusNInfo.layoutHeight != 0.0 && onePlusNInfo.aspectRatio != 0.0) {
            layoutWidth = onePlusNInfo.layoutWidth
            layoutHeight = onePlusNInfo.layoutHeight
            aspectRatio = onePlusNInfo.aspectRatio
        } else if (onePlusNInfo.layoutWidth != 0.0 && onePlusNInfo.layoutHeight != 0.0 && onePlusNInfo.aspectRatio == 0.0) {
            layoutWidth = onePlusNInfo.layoutWidth
            layoutHeight = onePlusNInfo.layoutHeight
            aspectRatio = layoutWidth / layoutHeight
        } else if (onePlusNInfo.layoutWidth != 0.0 && onePlusNInfo.layoutHeight == 0.0 && onePlusNInfo.aspectRatio != 0.0) {
            layoutWidth = onePlusNInfo.layoutWidth
            layoutHeight = layoutWidth / onePlusNInfo.aspectRatio
            aspectRatio = onePlusNInfo.aspectRatio
            computedLayoutHeight()
        } else if (onePlusNInfo.layoutWidth == 0.0 && onePlusNInfo.layoutHeight != 0.0 && onePlusNInfo.aspectRatio != 0.0) {
            layoutWidth = onePlusNInfo.layoutHeight * onePlusNInfo.aspectRatio
            layoutHeight = onePlusNInfo.layoutHeight
            aspectRatio = onePlusNInfo.aspectRatio
        } else {
            Hilog.error(0x000000, "computedSize", '${TAG}computedSize else')
        }
    }

    func computedLayoutHeight() {
        match (vLayoutData.size) {
        	case 1 => layoutHeight = itemHeight
        	case 2 => layoutHeight = max(itemHeight1, itemHeight2)
        	case 3 =>
                if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                    layoutHeight = max(itemHeight1, itemHeight2) + itemHeight
                } else if (!vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                    layoutHeight = max(itemHeight, itemHeight1) + itemHeight2
                } else if (vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                    layoutHeight = itemHeight + itemHeight1 + itemHeight2
                } else {
                    if (itemHeight1 + itemHeight2 >= itemHeight) {
                        layoutHeight = itemHeight1 + itemHeight2
                    } else {
                        layoutHeight = max(max(itemHeight, itemHeight1), itemHeight2)
                    }
                }
        	case 4 =>
                if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                    if (itemHeight1 >= itemHeight2 + itemHeight3) {
                        layoutHeight = itemHeight + itemHeight1
                    } else {
                        layoutHeight = itemHeight + itemHeight2 + itemHeight3
                    }
                } else if (!vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                    if (itemHeight1 + itemHeight2 >= itemHeight) {
                        layoutHeight = itemHeight1 + itemHeight2 + itemHeight3
                    } else {
                        layoutHeight = itemHeight + itemHeight3
                    }
                } else if (vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                    layoutHeight = itemHeight + max(itemHeight1, itemHeight2) + itemHeight3
                } else {
                    if (itemHeight1 + max(itemHeight2, itemHeight3) >= itemHeight) {
                        layoutHeight = itemHeight1 + max(itemHeight2, itemHeight3)
                    } else {
                        layoutHeight = max(max(itemHeight, itemHeight1), max(itemHeight2, itemHeight3))
                    }
                }
        	case 5 =>
                if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                    if (itemHeight2 + max(itemHeight3, itemHeight4) >= itemHeight1) {
                        layoutHeight = itemHeight + itemHeight2 + max(itemHeight3, itemHeight4)
                    } else {
                        layoutHeight = itemHeight + itemHeight1
                    }
                } else if (!vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                    if (itemHeight1 + max(itemHeight2, itemHeight3) >= itemHeight) {
                        layoutHeight = itemHeight1 + max(itemHeight2, itemHeight3) + itemHeight4
                    } else {
                        layoutHeight = itemHeight + itemHeight4
                    }
                } else if (vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
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
        	case _ => Hilog.error(0x000000, "computedLayoutHeight", '${TAG}computedLayoutHeight error')
        }

        computedExtraHeight()
    }

    func computedExtraHeight() {
        layoutHeight = layoutHeight + onePlusNInfo.topPadding
        layoutHeight = layoutHeight + onePlusNInfo.bottomPadding
    }

    func build() {
        Column() {
            Row(){
                if(vLayoutData.size == 1) {
                    Row() {
                        Column() {
                            vLayoutContent(vLayoutData[0])
                        }
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(
                            if(colWeightArray.size == 0) {
                                100.percent

                            } else {
                                colWeightArray[0].percent
                            }
                        )
                        .height(
                            if(rowWeightArray.size == 0) {
                                100.percent
                            } else {
                                rowWeightArray[0].percent
                            }
                        )
                    }
                }
                else if (vLayoutData.size == 2) {
                    Row() {
                        Column() {
                            vLayoutContent(vLayoutData[0])
                        }
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight1 = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(
                            if(colWeightArray.size == 0) {
                                50.percent
                            } else {
                                colWeightArray[0].percent
                            }
                        )

                        Column() {
                            vLayoutContent(vLayoutData[1])
                        }
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight2 =px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                            computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(
                            if(colWeightArray.size == 0) {
                                50.percent
                            } else {
                                colWeightArray[1].percent
                            }
                        )
                    }
                } else if (vLayoutData.size == 3) {
                    if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if(colWeightArray.size == 0) {
                                    100.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                } else {
                                    Int32(rowWeightArray[0]) //可能有问题
                                }
                            )

                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if(rowWeightArray.size == 0) {
                                        50.percent
                                    } else {
                                        rowWeightArray[1].percent //可能有问题
                                    }
                                )

                                Column() {
                                    vLayoutContent(vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(
                                    if(rowWeightArray.size == 0) {
                                        50.percent
                                    } else {
                                        rowWeightArray[2].percent //可能有问题
                                    }
                                )
                            }
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                } else {
                                    Int32(rowWeightArray[1]) //可能有问题
                                }
                            )

                        }.alignItems(HorizontalAlign.Start)
                    } else if(!vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[0])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                        50.percent
                                    } else {
                                        colWeightArray[0].percent
                                    })

                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                        50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )
                            }
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[2])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight2 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[2].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[1])
                                }
                            )
                        }.alignItems(HorizontalAlign.Start)
                    } else if(vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[1])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight1 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[1].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[1])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[2])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight2 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[2].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }
                            )
                        }.alignItems(HorizontalAlign.Start)
                    } else {
                        Row() {
                            Column() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(
                                if (colWeightArray.size == 0) {
                                   50.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )

                            Column() {
                                Row() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )
                                .layoutWeight(
                                    if (rowWeightArray.size == 0) {
                                       1
                                    } else {
                                        Int32(rowWeightArray[0])
                                    }
                                )

                                Row() {
                                    vLayoutContent(vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[2].percent
                                    }
                                )
                                .layoutWeight(
                                    if (rowWeightArray.size == 0) {
                                       1
                                    } else {
                                        Int32(rowWeightArray[1])
                                    }
                                )
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                } else if(vLayoutData.size == 4) {
                    if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                       100.percent
                                    } else {
                                        colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }

                            )

                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )

                                Column() {
                                    Row() {
                                        vLayoutContent(vLayoutData[2])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[2].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if(onePlusNInfo.layoutHeight == 0.0) {
                                            0
                                        }else {
                                            1
                                        }
                                    )

                                    Row() {
                                        vLayoutContent(vLayoutData[3])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[3].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if(onePlusNInfo.layoutHeight == 0.0) {
                                            0
                                        }else {
                                            1
                                        }
                                    )
                                }.alignItems(HorizontalAlign.Start)
                            }
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                }else {
                                    Int32(rowWeightArray[1])
                                }

                            )
                        }.alignItems(HorizontalAlign.Start)
                    }else if (vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                }else {
                                    Int32(rowWeightArray[0])
                                }
                            )

                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )

                                Column() {
                                    vLayoutContent(vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[2].percent
                                    }
                                )
                            }
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                }else {
                                    Int32(rowWeightArray[1])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[3])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight3 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[3].percent
                                }
                            )
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                }else {
                                    Int32(rowWeightArray[0])
                                }
                            )
                        }.alignItems(HorizontalAlign.Start)
                    }else {
                        Row() {
                            Column() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(
                                if (colWeightArray.size == 0) {
                                   50.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )

                            Column() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .alignItems(HorizontalAlign.Start)
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )
                                .layoutWeight(
                                    if(rowWeightArray.size == 0) {
                                        1
                                    }else {
                                        Int32(rowWeightArray[0])
                                    }
                                )

                                Row() {
                                    Column() {
                                        vLayoutContent(vLayoutData[2])
                                    }
                                    .onAreaChange({ oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[2].percent
                                        }
                                    )

                                    Column() {
                                        vLayoutContent(vLayoutData[3])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[3].percent
                                        }
                                    )
                                }
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        100.percent
                                    }
                                )
                                .layoutWeight(
                                    if(rowWeightArray.size == 0) {
                                        1
                                    }else {
                                        Int32(rowWeightArray[1])
                                    }

                                )
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                }
                else if (vLayoutData.size == 5) {
                    if (vLayoutAttribute.hasHeader && !vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if(rowWeightArray.size == 0) {
                                    1
                                }else {
                                    Int32(rowWeightArray[0])
                                }
                            )

                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )

                                Column() {
                                    Row() {
                                        vLayoutContent(vLayoutData[2])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[2].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )

                                    Row() {
                                        Column() {
                                            vLayoutContent(vLayoutData[3])
                                        }
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight3 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                            computedSize()
                                        })
                                        .width(
                                            if (colWeightArray.size == 0) {
                                               25.percent
                                            } else {
                                                colWeightArray[3].percent
                                            }
                                        )

                                        Column() {
                                            vLayoutContent(vLayoutData[4])
                                        }
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight4 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                            computedSize()
                                        })
                                        .width(
                                            if (colWeightArray.size == 0) {
                                               25.percent
                                            } else {
                                                colWeightArray[4].percent
                                            }
                                        )
                                    }
                                    .layoutWeight(
                                        if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(
                                    if (onePlusNInfo.layoutHeight == 0.0) {
                                       0
                                    } else {
                                        1
                                    }
                                )
                            }
                            .layoutWeight(
                                if (onePlusNInfo.layoutHeight == 0.0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[1])
                                }
                            )
                        }.alignItems(HorizontalAlign.Start)
                    }else if (!vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[0])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, height = ${itemHeight}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[0].percent
                                    }
                                )

                                Column() {
                                    Row() {
                                        vLayoutContent(vLayoutData[1])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight1 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[1].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )

                                    Row() {
                                        Column() {
                                            vLayoutContent(vLayoutData[2])
                                        }
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight2 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                            computedSize()
                                        })
                                        .width(
                                            if (colWeightArray.size == 0) {
                                               25.percent
                                            } else {
                                                colWeightArray[2].percent
                                            }
                                        )

                                        Column() {
                                            vLayoutContent(vLayoutData[3])
                                        }
                                        .onAreaChange({oldValue, newValue =>
                                            itemWidth = px2vp(newValue.width.px)().value
                                            itemHeight3 = px2vp(newValue.height.px)().value
                                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                            computedSize()
                                        })
                                        .width(
                                            if (colWeightArray.size == 0) {
                                               25.percent
                                            } else {
                                                colWeightArray[3].percent
                                            }
                                        )
                                    }
                                    .layoutWeight(
                                         if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(
                                    if (onePlusNInfo.layoutHeight == 0.0) {
                                       0
                                    } else {
                                        1
                                    }
                                )
                            }
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[4])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[4].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[1])
                                }
                            )
                        }.alignItems(HorizontalAlign.Start)
                    } else if (vLayoutAttribute.hasHeader && vLayoutAttribute.hasFooter) {
                        Column() {
                            Row() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }

                            )

                            Row() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .width(
                                    if (colWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }
                                )

                                Column() {
                                    Row() {
                                        vLayoutContent(vLayoutData[2])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[2].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )

                                    Row() {
                                        vLayoutContent(vLayoutData[3])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight3 = ${itemHeight3}')
                                        computedSize()
                                    })
                                    .width(
                                        if (colWeightArray.size == 0) {
                                           50.percent
                                        } else {
                                            colWeightArray[3].percent
                                        }

                                    )
                                    .layoutWeight(
                                        if (onePlusNInfo.layoutHeight == 0.0) {
                                           0
                                        } else {
                                            1
                                        }
                                    )
                                }
                                .alignItems(HorizontalAlign.Start)
                                .layoutWeight(
                                    if (onePlusNInfo.layoutHeight == 0.0) {
                                       0
                                    } else {
                                        1
                                    }

                                )
                            }
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[1])
                                }
                            )

                            Row() {
                                vLayoutContent(vLayoutData[4])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                computedSize()
                            })
                            .width(
                                if (colWeightArray.size == 0) {
                                   100.percent
                                } else {
                                    colWeightArray[4].percent
                                }
                            )
                            .layoutWeight(
                                if (rowWeightArray.size == 0) {
                                   1
                                } else {
                                    Int32(rowWeightArray[0])
                                }

                            )
                        }.alignItems(HorizontalAlign.Start)
                    }else {
                        Row() {
                            Column() {
                                vLayoutContent(vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(
                                if (rowWeightArray.size == 0) {
                                   50.percent
                                } else {
                                    colWeightArray[0].percent
                                }
                            )

                            Column() {
                                Column() {
                                    vLayoutContent(vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight1 = ${itemHeight1}')
                                    computedSize()
                                })
                                .alignItems(HorizontalAlign.Start)
                                .width(
                                    if (rowWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        colWeightArray[1].percent
                                    }

                                )
                                .layoutWeight(
                                    if (rowWeightArray.size == 0) {
                                       1
                                    } else {
                                        Int32(rowWeightArray[0])
                                    }
                                )

                                Row() {
                                    Column() {
                                        vLayoutContent(vLayoutData[2])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight2 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight2 = ${itemHeight2}')
                                        computedSize()
                                    })
                                    .width(
                                        if (rowWeightArray.size == 0) {
                                           33.percent
                                        } else {
                                            colWeightArray[2].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (rowWeightArray.size == 0) {
                                           1
                                        } else {
                                            0
                                        }
                                    )

                                    Column() {
                                        vLayoutContent(vLayoutData[3])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight3 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                        computedSize()
                                    })
                                    .width(
                                        if (rowWeightArray.size == 0) {
                                           33.percent
                                        } else {
                                            colWeightArray[3].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (rowWeightArray.size == 0) {
                                           1
                                        } else {
                                            0
                                        }
                                    )

                                    Column() {
                                        vLayoutContent(vLayoutData[4])
                                    }
                                    .onAreaChange({oldValue, newValue =>
                                        itemWidth = px2vp(newValue.width.px)().value
                                        itemHeight4 = px2vp(newValue.height.px)().value
                                        Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight4 = ${itemHeight4}')
                                        computedSize()
                                    })
                                    .width(
                                        if (rowWeightArray.size == 0) {
                                           33.percent
                                        } else {
                                            colWeightArray[4].percent
                                        }
                                    )
                                    .layoutWeight(
                                        if (rowWeightArray.size == 0) {
                                           1
                                        } else {
                                            0
                                        }
                                    )

                                }
                                .width(
                                    if (rowWeightArray.size == 0) {
                                       50.percent
                                    } else {
                                        100.percent
                                    }
                                )
                                .layoutWeight(
                                    if (rowWeightArray.size == 0) {
                                       1
                                    } else {
                                        Int32(rowWeightArray[1])
                                    }
                                )
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                    }
                }
                else {
                    Text('please less than 1+5')
                    .width(100.percent)
                    .height(100.percent)
                    .backgroundColor(0xEEEEEE)
                    .border( width: 1.vp, color: Color.BLACK, radius: 0.vp, style: BorderStyle.Solid )
                    .fontSize(25)
                    .fontColor(0x999999)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                    .textOverflow( TextOverflow.Ellipsis )
                    }

            }
            .width(layoutWidth)
            .height(if(onePlusNInfo.layoutHeight == 0.0) { layoutHeight } else { onePlusNInfo.layoutHeight })
            .aspectRatio(aspectRatio)
            .padding(
                top: onePlusNInfo.topPadding,
                right: onePlusNInfo.rightPadding,
                bottom: onePlusNInfo.bottomPadding,
                left: onePlusNInfo.leftPadding
            )
        }
        .backgroundColor(onePlusNInfo.bgColor)
        .zIndex(onePlusNInfo.zIndex)
        .margin(
          top: onePlusNInfo.topMargin,
          right: onePlusNInfo.rightMargin,
          bottom: onePlusNInfo.bottomMargin,
          left: onePlusNInfo.leftMargin
        )
    }
}
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

    @State var vLayoutAttribute: AbstractFullFillAttributes = AbstractFullFillAttributes() //属性

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
        computedRange()
        computedColWeights()
        computedRowWeights()
        computedSize()
    }

    func computedRange() {
        //可显示的条目range数组长度为2并且数组元素内第一项大于等于0并且第二项大于第一项
        let range = if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range }
        if (range.size == 2 && range[0] >= 0 && range[1] > range[0]) {
            vLayoutData = vLayoutData.slice(range[0], range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func computedColWeights() {
        if (vLayoutAttribute.colWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>(vLayoutData.size)
            weightArray.appendAll(vLayoutAttribute.colWeights)

            if (vLayoutData.size > vLayoutAttribute.colWeights.size) { //数据源数组长度大于列权重数组长度时
                match (vLayoutAttribute.colWeights.size) {
                	case 1 =>
                        var sum: Float64 = 0.0
                        for (i in 0..vLayoutAttribute.colWeights.size) {
                            let element: Float64 = vLayoutAttribute.colWeights[i];
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
                                    this.mWeight = 1
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
                    case 2 =>
                        if (vLayoutData.size == 5) {
                            weightArray.append(100.0 - weightArray[0] - weightArray[1])
                            for (j in 0..2) {
                              weightArray.append((100.0 - weightArray[0]) / 2.0)
                            }
                        }
                        if (vLayoutData.size == 6) {
                            weightArray.append(100.0 - weightArray[0])
                            this.mWeight = 1
                        }
                        if (vLayoutData.size == 7) {
                            weightArray.append(100.0 - weightArray[0] - weightArray[1])
                            for (j in 0..4) {
                                weightArray.append((100.0 - weightArray[0]) / 2.0)
                            }
                        }
                    case 3 =>
                        if (vLayoutData.size == 5) {
                            for (j in 0..2) {
                                weightArray.append((100.0 - weightArray[0] - weightArray[2]) / 2.0)
                            }
                        }
                        if (vLayoutData.size == 6) {
                            this.mWeight = 1
                        }
                        if (vLayoutData.size == 7) {
                            for (j in 0..4) {
                                weightArray.append((100.0 - weightArray[0]) / 2.0)
                            }
                        }
                    case 4 =>
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
                    case 5 =>
                        if (vLayoutData.size == 6) {
                            weightArray.append((100.0 - weightArray[3]- weightArray[4]))
                        }
                        if (vLayoutData.size == 7) {
                            weightArray.append((100.0 - weightArray[0]) / 2.0)
                        }
                    case 6 =>
                        if (vLayoutData.size == 7) {
                            weightArray.append((100.0 - weightArray[0]- weightArray[5]))
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
        if (vLayoutAttribute.rowWeights.size != 0) {
            var weightArray: ArrayList<Float64> = ArrayList<Float64>()
            weightArray.appendAll(vLayoutAttribute.rowWeights)

            if (vLayoutAttribute.rowWeights.size == 1) {
                if (vLayoutData.size == 5 || vLayoutData.size == 6) {
                    weightArray.append(vLayoutAttribute.rowWeights[0])
                }
                if (vLayoutData.size == 7) {
                    for (j in 0..2) {
                        weightArray.append(weightArray[0])
                    }
                    weightArray.append(vLayoutAttribute.rowWeights[0])
                }
            } else if(vLayoutAttribute.rowWeights.size == 2) {
                if (vLayoutData.size == 7) {
                    weightArray.append(vLayoutAttribute.rowWeights[0])
                }
            } else {
                Hilog.error(0x000000, "computedRowWeights", '${TAG}computedRowWeights else')
            }
            rowWeightArray = weightArray.toArray()
            Hilog.info(0x000000, "computedRowWeights", '${TAG}rowWeightArray = ${rowWeightArray}')
        }
    }

    func computedSize() {
        layoutHeight = vLayoutAttribute.layoutHeight.value
        computedLayoutHeight()
    }

    func computedLayoutHeight() {
        match (vLayoutData.size) {
        	case 5 =>
                if (max(this.itemHeight1 + this.itemHeight3, this.itemHeight2 + this.itemHeight4) >= this.itemHeight) {
                    this.layoutHeight = max(this.itemHeight1 + this.itemHeight3, this.itemHeight2 + this.itemHeight4)
                } else {
                    this.layoutHeight = this.itemHeight
                }
        	case 6 =>
                if (this.itemHeight1 + this.itemHeight2 >= this.itemHeight) {
                    this.layoutHeight = max(max(this.itemHeight3, this.itemHeight4), this.itemHeight5) + this.itemHeight1 + this.itemHeight2
                } else {
                    this.layoutHeight = max(max(this.itemHeight3, this.itemHeight4), this.itemHeight5) + this.itemHeight
                }
        	case 7 =>
                if (max(this.itemHeight1 + this.itemHeight3 + this.itemHeight5, this.itemHeight2 + this.itemHeight4 + this.itemHeight6) >= this.itemHeight) {
                    this.layoutHeight = max(this.itemHeight1 + this.itemHeight3 + this.itemHeight5, this.itemHeight2 + this.itemHeight4 + this.itemHeight6)
                } else {
                    this.layoutHeight = this.itemHeight
                }
        	case _ => Hilog.error(0x000000, "computedLayoutHeight", '${TAG}computedLayoutHeight error')
        }

        computedExtraHeight()
    }

    func computedExtraHeight() {
        layoutHeight = layoutHeight + vLayoutAttribute.topPadding
        layoutHeight = layoutHeight + vLayoutAttribute.bottomPadding
    }

    func build() {
        Column() {
            Row(){
                if(vLayoutData.size == 5) {
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
                                34.percent

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

                        Column() {
                            Row() {
                                Row() {
                                    this.vLayoutContent(this.vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight1}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                     50.percent
                                }else {
                                     this.colWeightArray[1].percent
                                })

                                Row() {
                                    this.vLayoutContent(this.vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                     50.percent
                                }else {
                                    this.colWeightArray[2].percent
                                })
                            }
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                 1
                            } else {
                                Int32(this.rowWeightArray[0])
                            })

                            Row() {
                                Row() {
                                    this.vLayoutContent(this.vLayoutData[3])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight3 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    this.computedSize()
                                })
                                .width( if(this.colWeightArray.size == 0) {
                                    50.percent
                                }else {
                                    this.colWeightArray[3].percent
                                })

                                Row() {
                                    this.vLayoutContent(this.vLayoutData[4])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight4 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                     50.percent
                                }else {
                                     this.colWeightArray[4].percent
                                })
                            }
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                 1
                            } else {
                                Int32(this.rowWeightArray[1])
                            })
                        }
                        .alignItems(HorizontalAlign.Start)
                        .width( if(this.colWeightArray.size == 0) {
                             66.percent
                        } else {
                            100.percent
                        })
                    }
                }
                else if(vLayoutData.size == 6) {
                    Column() {
                        Row() {
                            Column() {
                                this.vLayoutContent(this.vLayoutData[0])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                this.computedSize()
                            })
                            .alignItems(HorizontalAlign.Start)
                            .width(if(this.colWeightArray.size == 0) {
                                 50.percent
                            }else {
                                 this.colWeightArray[0].percent
                            })

                            Column() {
                                Row() {
                                    this.vLayoutContent(this.vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                    50.percent
                                } else {
                                    this.colWeightArray[1].percent
                                })
                                .layoutWeight(1)

                                Row() {
                                    this.vLayoutContent(this.vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                     50.percent
                                } else {
                                     this.colWeightArray[2].percent
                                })
                                .layoutWeight(1)
                            }
                            .alignItems(HorizontalAlign.Start)
                        }
                        .layoutWeight(if(this.rowWeightArray.size == 0) {
                             1
                        } else {
                            Int32(this.rowWeightArray[0])
                        })

                        Row() {
                            Column() {
                                this.vLayoutContent(this.vLayoutData[3])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight3 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight3}')
                                this.computedSize()
                            })
                            .width(if(this.colWeightArray.size == 0) {
                                 33.percent
                            } else {
                                 this.colWeightArray[3].percent
                            })
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                 1
                            } else {
                                this.mWeight
                            })

                            Column() {
                                this.vLayoutContent(this.vLayoutData[4])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight4 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                this.computedSize()
                            })
                            .width(if(this.colWeightArray.size == 0) {
                                 33.percent
                            } else {
                                 this.colWeightArray[4].percent
                            })
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                 1
                            } else {
                                this.mWeight
                            })

                            Column() {
                                this.vLayoutContent(this.vLayoutData[5])
                            }
                            .onAreaChange({oldValue, newValue =>
                                itemWidth = px2vp(newValue.width.px)().value
                                itemHeight5 = px2vp(newValue.height.px)().value
                                Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight5}')
                                this.computedSize()
                            })
                            .width(if(this.colWeightArray.size == 0) {
                                 33.percent
                            } else {
                                 this.colWeightArray[5].percent
                            })
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                 1
                            } else {
                                this.mWeight
                            })
                        }
                        .layoutWeight(if(this.rowWeightArray.size == 0) {
                             1
                        } else {
                            Int32(this.rowWeightArray[1])
                        })

                    }.alignItems(HorizontalAlign.Start)
                }
                else if(vLayoutData.size == 7) {
                    Row() {
                        Column() {
                            this.vLayoutContent(this.vLayoutData[0])
                        }
                        .onAreaChange({oldValue, newValue =>
                            itemWidth = px2vp(newValue.width.px)().value
                            itemHeight = px2vp(newValue.height.px)().value
                            Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight}')
                            this.computedSize()
                        })
                        .alignItems(HorizontalAlign.Start)
                        .width(if(this.colWeightArray.size == 0) {
                              34.percent
                        } else {
                              this.colWeightArray[0].percent
                        })

                        Column() {
                            Row() {
                                Column() {
                                    this.vLayoutContent(this.vLayoutData[1])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight1 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight1}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                          50.percent
                                } else {
                                      this.colWeightArray[1].percent
                                })

                                Column() {
                                    this.vLayoutContent(this.vLayoutData[2])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight2 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight2}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                          50.percent
                                } else {
                                      this.colWeightArray[2].percent
                                })
                            }
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                1
                            } else {
                                Int32(this.rowWeightArray[0])
                            })

                            Row() {
                                Column() {
                                    this.vLayoutContent(this.vLayoutData[3])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight3 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight3}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                      50.percent
                                } else {
                                      this.colWeightArray[3].percent
                                })

                                Column() {
                                    this.vLayoutContent(this.vLayoutData[4])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight4 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight4}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                      50.percent
                                } else {
                                      this.colWeightArray[4].percent
                                })
                            }
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                1
                            } else {
                                Int32(this.rowWeightArray[1])
                            })

                            Row() {
                                Column() {
                                    this.vLayoutContent(this.vLayoutData[5])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight5 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight5}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                      50.percent
                                } else {
                                      this.colWeightArray[5].percent
                                })

                                Column() {
                                    this.vLayoutContent(this.vLayoutData[6])
                                }
                                .onAreaChange({oldValue, newValue =>
                                    itemWidth = px2vp(newValue.width.px)().value
                                    itemHeight6 = px2vp(newValue.height.px)().value
                                    Hilog.info(0x000000, "item", '${TAG} itemWidth = ${itemWidth}, itemHeight = ${itemHeight6}')
                                    this.computedSize()
                                })
                                .width(if(this.colWeightArray.size == 0) {
                                      50.percent
                                } else {
                                      this.colWeightArray[6].percent
                                })
                            }
                            .layoutWeight(if(this.rowWeightArray.size == 0) {
                                1
                            } else {
                                Int32(this.rowWeightArray[2])
                            })
                        }
                        .alignItems(HorizontalAlign.Start)
                        .width(if(this.colWeightArray.size == 0) {
                              66.percent
                        }else {
                              100.percent
                        })
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
            .width(vLayoutAttribute.layoutWidth)
            .height(if(vLayoutAttribute.layoutHeight.value == 0.0) { layoutHeight.vp } else { vLayoutAttribute.layoutHeight })
            .padding(
                top: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[0]
                } else {
                    vLayoutAttribute.topPadding
                },
                right: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[1]
                } else {
                    vLayoutAttribute.rightPadding
                },
                bottom: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[2]
                } else {
                    vLayoutAttribute.bottomPadding
                },
                left: if(vLayoutAttribute.padding.size == 4) {
                    vLayoutAttribute.padding[3]
                } else {
                    vLayoutAttribute.leftPadding
                }
            )
        }
        .backgroundColor(vLayoutAttribute.bgColor)
        .zIndex(vLayoutAttribute.zIndex)
        .margin(
            top: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[0]
            } else {
                this.vLayoutAttribute.topMargin
            },
            right:  if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[1]
            } else {
                this.vLayoutAttribute.rightMargin
            },
            bottom: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[2]
            } else {
                this.vLayoutAttribute.bottomMargin
            },
            left: if(this.vLayoutAttribute.margin.size == 4) {
                this.vLayoutAttribute.margin[3]
            } else {
                this.vLayoutAttribute.leftMargin
            }
        )
    }
}
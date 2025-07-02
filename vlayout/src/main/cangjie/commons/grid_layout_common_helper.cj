/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj.commons

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Link

@Component
public class GridLayoutCommon {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    @State var gridLayoutAttribute: GridAttributes = GridAttributes() //属性
    var vLayoutData: Array<layoutDataType> = [] //数据源
    var layoutType: String = ""
    var TAG: String = ""

    private var columnsTemplate: String = '' //列
    private var rowsTemplate: String = '' //行
    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //grid高度
    @State var rightPadding: Float64 = 0.0 //右内边距
    private var gridWidth: Float64 = 0.0 //获取的grid宽度
    private var gridHeight: Float64 = 0.0 //获取的grid高度
    private var gridItemWidth: Float64 = 0.0 //获取的gridItem宽度
    private var gridItemHeight: Float64 = 0.0 //获取的gridItem高度
    private var spanCount: Int64 = 0
    private var weights: Array<Float64> = []

    private var displayClass: Display = getDefaultDisplaySync()
    private var screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    private var screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value


    protected override func aboutToAppear() {
        spanCount = CommonFunc.spanCountAndWeight(gridLayoutAttribute.spanCount, gridLayoutAttribute.weights)[0]
        weights = CommonFunc.spanCountAndWeight(gridLayoutAttribute.spanCount, gridLayoutAttribute.weights)[1]
        vLayoutData = CommonFunc.computedRange(gridLayoutAttribute.range, vLayoutData)
        if (this.gridLayoutAttribute.gap > 0) {
            this.gridLayoutAttribute.vGap = this.gridLayoutAttribute.gap
            this.gridLayoutAttribute.hGap = this.gridLayoutAttribute.gap
        }
        computedColumnsTemplate()
        if(layoutType == "grid") {
            computedRowsTemplateGrid()
        } else {
            computedRowsTemplateRangeGrid()
        }

        computedHeight()
    }

    func computedColumnsTemplate() {
        var element: Float64 = 0.0
        if (weights.size != 0 && spanCount != 0) { //当weights定义了，autoExpand失效
            var cols: Array<String> = Array<String>(weights.size, repeat: "")
            if (weights.size == spanCount) { //当weights数组长度等于列数时，若数组内元素之和小于100，右侧则空出剩余部分，否则不进行空出
                computedColumnsTemplateWeightEqualSpanCount()
            } else if (weights.size < spanCount) { //当weights数组长度小于列数时，若数组内元素之和小于100，则自动填充剩余占比
                computedColumnsTemplateWeightLessSpanCount()
            } else { //当weights数组长度大于列数时，若数组内前三项元素之和小于100，则进行空出
                computedColumnsTemplateWeightElseSpanCount()
            }
        } else { //当weight未定义时，autoExpand才有效
            if (spanCount != 0) {
                let cols: Array<String> = Array<String>(spanCount, repeat: "")
                for (i in 0..spanCount) {
                    element = 100.0 / Float64(spanCount)
                    cols[i] = round(Float64(element)).toString() + 'fr'
                }
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
                //autoExpand为true时，余子项宽度自适配
                computedColumnsTemplateAutoExpand(cols)
            }
        }
    }

    func computedColumnsTemplateWeightEqualSpanCount(){
        var element: Float64 = 0.0
        var cols: Array<String> = Array<String>(weights.size, repeat: "")
        for (i in 0..weights.size) {
            cols[i] = round(Float64(weights[i])).toString() + 'fr'
            element += weights[i]
        }
        if (element < 100.0) {
            rightPadding = (100.0 - element) * 0.01 * gridWidth //右边空出剩余部分
        } else {
            rightPadding = 0.0
        }
        computedRightPadding(rightPadding)
        columnsTemplate = String.join(cols, delimiter: ' ')
    }

    func computedColumnsTemplateWeightLessSpanCount(){
        var element: Float64 = 0.0
        var cols: Array<String> = Array<String>(spanCount, repeat: "")
        for (i in 0..weights.size) {
            cols[i] = round(Float64(weights[i])).toString() + 'fr'
            element += weights[i]
        }
        if (element < 100.0) {
            for(j in weights.size..spanCount) {
                cols[j] = (round((100.0 - element)) / Float64(spanCount - weights.size)).toString() + 'fr' //自动填充剩余占比
            }
            computedRightPadding(rightPadding)
            columnsTemplate = String.join(cols, delimiter: ' ')
        } else {
            computedRightPadding(rightPadding)
            columnsTemplate = String.join(cols, delimiter: ' ')
        }
    }

    func computedColumnsTemplateWeightElseSpanCount() {
        var element: Float64 = 0.0
        var cols: Array<String> = Array<String>(weights.size, repeat: "")
        for (i in 0..spanCount) {
            cols[i] = (round(Float64(weights[i])).toString() + 'fr')
            element += weights[i]
        }
        if (element < 100.0) {
            rightPadding = (100.0 - element) * 0.01 * gridWidth //右边空出剩余部分
        } else {
            rightPadding = 0.0
        }
        computedRightPadding(rightPadding)
        columnsTemplate = String.join(cols, delimiter: ' ')
    }

    func computedColumnsTemplateAutoExpand(cols: Array<String>) {
        if (gridLayoutAttribute.autoExpand) {
            let mod = vLayoutData.size % cols.size //余子项数
            if (mod == 0) {
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
            } else {
                let temp: Int64 = spanCount * mod //列数和余子项数的公倍数
                let newCols: Array<String> = Array<String>(temp, repeat: '')
                for (i in 0..temp) {
                    newCols[i] = trunc(Float64(100 / temp)).toString() + 'fr'
                }
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
            }
            let count: Int64 = Int64(ceil(Float64(vLayoutData.size / spanCount)))
            let rows: Array<String> = Array<String>(count, repeat: '1fr ')
            rowsTemplate = String.join(rows, delimiter: ' ')
        } else {
            Hilog.error(0x000000, "computedColumnsTemplate", '${TAG} autoExpand false')
        }
    }

    func computedRightPadding(rightPad: Float64) {
        rightPadding = gridLayoutAttribute.rightPadding + rightPad
    }

    func computedRowsTemplateGrid() {
        var sum: Int64 = 0
        var temp: Int64 = 0
        if (spanCount != 0) {
            for (i in 0..vLayoutData.size) {
                var afda: Int64 = vLayoutData[i].colsSpan
                if (afda != 0) {
                    if (afda > spanCount) { //如果合并列大于列数，合并项等于列数
                        afda = spanCount
                    } else if (afda < 1) { //如果合并列小于1，合并项等于1
                        vLayoutData[i].colsSpan = 1
                    } else {
                        Hilog.error(0x000000, "computedRowsTemplate", '${TAG} colsSpan = ${vLayoutData[i].colsSpan}')
                    }
                    var colsSpan: Int64 = 0
                    if (vLayoutData[i].colsSpan == 0) {
                        colsSpan = 1
                    } else {
                        colsSpan = vLayoutData[i].colsSpan
                    }
                    sum = sum + colsSpan
                    if (temp + colsSpan > spanCount) {
                        sum = sum + spanCount - temp
                        temp = colsSpan
                    } else {
                        temp = temp + colsSpan
                    }
                } else {
                    sum = spanCount
                }

            }
            if(sum != 0) {
                let count: Int64 = Int64(ceil(Float64(sum / spanCount))) //获得实际行数
                let rows: Array<String> = Array<String>(count, repeat: '1fr ')
                rowsTemplate = String.join(rows, delimiter: ' ') //行数为1:1
            }
        }
    }

    func computedRowsTemplateRangeGrid() {
        var line: Array<Int64> = [0]
        var lines: ArrayList<Int64> = ArrayList<Int64>(line)
        if (spanCount != 0) {
            let columnCount: Int64 = spanCount
            for (item in vLayoutData) {
                let colsSpan: Int64 = min(max(item.colsSpan, 1), columnCount)
                item.colsSpan = colsSpan
                if (line[line.size -1] + colsSpan > columnCount) {
                    lines.add(colsSpan)
                } else {
                    lines[lines.size-1] += colsSpan
                }
                line = lines.toArray()
            }
        }

        let rows: Array<String> = Array<String>(line.size, repeat: '1fr ')
        rowsTemplate = String.join(rows, delimiter: ' ') //行数为1:1
    }

    func computedHeight() {
        let rowCount: Int64 = rowsTemplate.size / 4
        if (gridLayoutAttribute.layoutHeight == 0.0 && gridLayoutAttribute.aspectRatio == 0.0) {
            oneRowHeight = screenHeight
            layoutHeight = oneRowHeight * Float64(rowCount)
            computedExtraHeight(rowCount)

        } else if (gridLayoutAttribute.layoutHeight == 0.0 && gridLayoutAttribute.aspectRatio > 0.0) {
            gridWidth = screenWidth
            oneRowHeight = gridWidth / gridLayoutAttribute.aspectRatio
            layoutHeight = oneRowHeight * Float64(rowCount)
            computedExtraHeight(rowCount)
        } else if (gridLayoutAttribute.layoutHeight != 0.0 && gridLayoutAttribute.aspectRatio > 0.0) {
            gridWidth = screenWidth
            oneRowHeight = gridWidth / gridLayoutAttribute.aspectRatio
        } else if (gridLayoutAttribute.layoutHeight != 0.0 && gridLayoutAttribute.aspectRatio == 0.0) {
            oneRowHeight = gridLayoutAttribute.layoutHeight
            layoutHeight = gridLayoutAttribute.layoutHeight
        } else {
            Hilog.error(0x000000, "computedHeight", '${TAG} something else computedHeight')
        }
    }

    func computedExtraHeight(rowCount: Int64) {
        if (gridLayoutAttribute.vGap >= 0) {
            let height = layoutHeight
            layoutHeight = height + Float64(gridLayoutAttribute.vGap * rowCount)
        }

        if (gridLayoutAttribute.topPadding >= 0.0) {
            layoutHeight = layoutHeight + gridLayoutAttribute.topPadding
        }

        if (gridLayoutAttribute.bottomPadding >= 0.0) {
            layoutHeight = layoutHeight + gridLayoutAttribute.bottomPadding
        }

    }

    func build() {
            Grid() {
                ForEach(vLayoutData, itemGeneratorFunc: {item: layoutDataType, position: Int64 =>
                    GridItem() {
                        vLayoutContent(item, position, oneRowHeight)
                    }
                    .onAreaChange({oldValue, newValue =>
                        gridItemWidth = px2vp(newValue.width.px)().value
                        gridItemHeight = px2vp(newValue.height.px)().value
                        computedHeight()
                        Hilog.info(0x000000, "gridItem", TAG + 'GridItem gridItemWidth = ${gridItemWidth}, gridItemHeight = ${gridItemHeight}')
                    })
                    .height(oneRowHeight)
                    .columnStart(1)
                })
            }
            .onAreaChange({oldValue, newValue =>
                gridWidth = px2vp(newValue.width.px)().value
                gridHeight = px2vp(newValue.height.px)().value
                computedColumnsTemplate()
                Hilog.info(0x000000, "grid", TAG + 'Grid gridWidth = ${gridWidth}, gridHeight = ${gridHeight}')
            })
            .height(if(gridLayoutAttribute.layoutHeight == 0.0){ layoutHeight } else { gridLayoutAttribute.layoutHeight } )
            .columnsTemplate(columnsTemplate)
            .columnsGap(gridLayoutAttribute.hGap)
            .rowsGap(gridLayoutAttribute.vGap)
            .padding(
                top: if(gridLayoutAttribute.padding.size == 4) {
                    gridLayoutAttribute.padding[0]
                } else {
                    gridLayoutAttribute.topPadding
                },
                right: if(gridLayoutAttribute.padding.size == 4) {
                    gridLayoutAttribute.padding[1]
                } else {
                    gridLayoutAttribute.rightPadding
                },
                bottom: if(gridLayoutAttribute.padding.size == 4) {
                    gridLayoutAttribute.padding[2]
                } else {
                    gridLayoutAttribute.bottomPadding
                },
                left: if(gridLayoutAttribute.padding.size == 4) {
                    gridLayoutAttribute.padding[3]
                } else {
                    gridLayoutAttribute.leftPadding
                }
            )
            .backgroundColor(gridLayoutAttribute.bgColor)
            .opacity(gridLayoutAttribute.bgOpacity)
            .zIndex(gridLayoutAttribute.zIndex)
            .margin(
                top: if(this.gridLayoutAttribute.margin.size == 4) {
                    this.gridLayoutAttribute.margin[0]
                } else {
                    this.gridLayoutAttribute.topMargin
                },
                right: if(this.gridLayoutAttribute.margin.size == 4) {
                    this.gridLayoutAttribute.margin[1]
                } else {
                    this.gridLayoutAttribute.rightMargin
                },
                bottom: if(this.gridLayoutAttribute.margin.size == 4) {
                    this.gridLayoutAttribute.margin[2]
                } else {
                    this.gridLayoutAttribute.bottomMargin
                },
                left: if(this.gridLayoutAttribute.margin.size == 4) {
                    this.gridLayoutAttribute.margin[3]
                } else {
                    this.gridLayoutAttribute.leftMargin
                }
            )

    }
}

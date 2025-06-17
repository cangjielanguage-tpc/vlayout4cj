/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package vlayout4cj

import ohos.state_macro_manage.Component
import ohos.state_macro_manage.BuilderParam
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import std.collection.ArrayList

private const TAG = 'vlayout GRID_LAYOUT '

@Component
public class GridLayout {
    @BuilderParam var vLayoutContent: (layoutDataType, Int64, Float64) -> Unit //布局
    var vLayoutData: Array<layoutDataType> = [] //数据源

    @State @Watch[defaultValueInit] var vLayoutAttribute: GridAttributes = GridAttributes() //属性
    @State var gridInfo: GridAttributes = GridAttributes() //属性

    private var columnsTemplate: String = '' //列
    private var rowsTemplate: String = '' //行
    @State var oneRowHeight: Float64 = 0.0 //单行高度
    @State var layoutHeight: Float64 = 0.0 //grid高度
    @State var rightPadding: Float64 = 0.0 //右内边距
    private var gridWidth: Float64 = 0.0 //获取的grid宽度
    private var gridHeight: Float64 = 0.0 //获取的grid高度
    private var gridItemWidth: Float64 = 0.0 //获取的gridItem宽度
    private var gridItemHeight: Float64 = 0.0 //获取的gridItem高度

    let displayClass: Display = getDefaultDisplaySync()
    let screenWidth: Float64 = px2vp(Float64(displayClass.width).px)().value
    let screenHeight: Float64 = px2vp(Float64(displayClass.height).px)().value

    protected override func aboutToAppear() {
        defaultValueInit()
        computedRange()
        computedColumnsTemplate()
        computedRowsTemplate()
        computedHeight()
    }

    func defaultValueInit() {
        gridInfo = GridAttributes(
            range: if(vLayoutAttribute.range == [0, 0] || vLayoutAttribute.range[1] > vLayoutData.size) {[0, vLayoutData.size] } else {vLayoutAttribute.range } ,
            spanCount: if (vLayoutAttribute.spanCount == 0 && vLayoutAttribute.weights.size == 0) {
                4
            } else if(vLayoutAttribute.spanCount == 0 && vLayoutAttribute.weights.size != 0){
                vLayoutAttribute.weights.size
            } else {
                vLayoutAttribute.spanCount
            },
            weights: if (vLayoutAttribute.spanCount == 0 && vLayoutAttribute.weights.size == 0) {
                [25.0, 25.0, 25.0, 25.0]
            } else {
                vLayoutAttribute.weights
            },
            autoExpand: vLayoutAttribute.autoExpand,
            aspectRatio: vLayoutAttribute.aspectRatio,
            layoutHeight: vLayoutAttribute.layoutHeight,
            bgColor: vLayoutAttribute.bgColor,
            zIndex: vLayoutAttribute.zIndex,
            gap: vLayoutAttribute.gap,
            vGap: vLayoutAttribute.vGap,
            hGap: vLayoutAttribute.hGap,
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
        if (gridInfo.range.size == 2 && gridInfo.range[0] >= 0 && gridInfo.range[1] > gridInfo.range[0]) {
            vLayoutData = vLayoutData.slice(gridInfo.range[0], gridInfo.range[1])
        } else {
            vLayoutData = vLayoutData
        }
    }

    func computedColumnsTemplate() {
        var rightPadding: Float64 = 0.0
        var element: Float64 = 0.0
        if (gridInfo.weights.size != 0 && gridInfo.spanCount != 0) { //当weights定义了，autoExpand失效
            var cols: Array<String> = Array<String>(gridInfo.weights.size, item: "")
            if (gridInfo.weights.size == gridInfo.spanCount) { //当weights数组长度等于列数时，若数组内元素之和小于100，右侧则空出剩余部分，否则不进行空出
                for (i in 0..gridInfo.weights.size) {
                    cols[i] = round(Float64(gridInfo.weights[i])).toString() + 'fr'
                    element += gridInfo.weights[i]
                }
                if (element < 100.0) {
                    rightPadding = (100.0 - element) * 0.01 * gridWidth //右边空出剩余部分
                } else {
                    rightPadding = 0.0
                }
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
            } else if (gridInfo.weights.size < gridInfo.spanCount) { //当weights数组长度小于列数时，若数组内元素之和小于100，则自动填充剩余占比
                cols = Array<String>(gridInfo.spanCount, item: "")
                for (i in 0..gridInfo.weights.size) {
                    cols[i] = round(Float64(gridInfo.weights[i])).toString() + 'fr'
                    element += gridInfo.weights[i]
                }
                if (element < 100.0) {
                    for(j in gridInfo.weights.size..gridInfo.spanCount) {
                        cols[j] = (round((100.0 - element)) / Float64(gridInfo.spanCount - gridInfo.weights.size)).toString() + 'fr' //自动填充剩余占比
                    }
                    computedRightPadding(rightPadding)
                    columnsTemplate = String.join(cols, delimiter: ' ')
                } else {
                    computedRightPadding(rightPadding)
                    columnsTemplate = String.join(cols, delimiter: ' ')
                }
            } else { //当weights数组长度大于列数时，若数组内前三项元素之和小于100，则进行空出
                for (i in 0..gridInfo.spanCount) {
                    cols[i] = (round(Float64(gridInfo.weights[i])).toString() + 'fr')
                    element += gridInfo.weights[i]
                }
                if (element < 100.0) {
                    rightPadding = (100.0 - element) * 0.01 * gridWidth //右边空出剩余部分
                } else {
                    rightPadding = 0.0
                }
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
            }
        } else { //当weight未定义时，autoExpand才有效
            if (gridInfo.spanCount != 0) {
                let cols: Array<String> = Array<String>(gridInfo.spanCount, item: "")
                for (i in 0..gridInfo.spanCount) {
                    element = 100.0 / Float64(gridInfo.spanCount)
                    cols[i] = round(Float64(element)).toString() + 'fr'
                }
                computedRightPadding(rightPadding)
                columnsTemplate = String.join(cols, delimiter: ' ')
                //autoExpand为true时，余子项宽度自适配
                if (gridInfo.autoExpand) {
                    let mod = vLayoutData.size % cols.size //余子项数
                    if (mod == 0) {
                        computedRightPadding(rightPadding)
                        columnsTemplate = String.join(cols, delimiter: ' ')
                    } else {
                        let temp: Int64 = gridInfo.spanCount * mod //列数和余子项数的公倍数
                        let newCols: Array<String> = Array<String>(temp, item: '')
                        for (i in 0..temp) {
                            newCols[i] = trunc(Float64(100 / temp)).toString() + 'fr'
                        }
                        computedRightPadding(rightPadding)
                        columnsTemplate = String.join(cols, delimiter: ' ')
                    }
                    let count: Int64 = Int64(ceil(Float64(vLayoutData.size / gridInfo.spanCount)))
                    let rows: Array<String> = Array<String>(count, item: '1fr ')
                    rowsTemplate = String.join(rows, delimiter: ' ')
                } else {
                    Hilog.error(0x000000, "computedColumnsTemplate", '${TAG} autoExpand false')
                }
            }
        }
    }

    func computedRightPadding(rightPad: Float64) {
        rightPadding = gridInfo.rightPadding + rightPad
    }

    func computedRowsTemplate() {
        var sum: Int64 = 0
        var temp: Int64 = 0
        if (gridInfo.spanCount != 0) {
            for (i in 0..vLayoutData.size) {
                var afda: Int64 = vLayoutData[i].colsSpan
                if (afda != 0) {
                    if (afda > gridInfo.spanCount) { //如果合并列大于列数，合并项等于列数
                        afda = gridInfo.spanCount
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
                    if (temp + colsSpan > gridInfo.spanCount) {
                        sum = sum + gridInfo.spanCount - temp
                        temp = colsSpan
                    } else {
                        temp = temp + colsSpan
                    }
                }

            }
            if(sum != 0) {
                let count: Int64 = Int64(ceil(Float64(sum / gridInfo.spanCount))) //获得实际行数
                let rows: Array<String> = Array<String>(count, item: '1fr ')
                rowsTemplate = String.join(rows, delimiter: ' ') //行数为1:1
            }
        }
    }

    /*
   * 1.当layoutHeight未定义并且aspectRatio等于0或未定义时，宫格不进行内部滑动，高度自适应，即grid总高度等于使用者给定的组件高度*行数，其中使用者给不给定提供的组件高度都行，额外影响因素有vGap、topPadding、bottomPadding；
   * 2.当layoutHeight未定义并且aspectRatio大于0时，请不要再提供组件高度，vlayout建议使用者在提供的组件的高度处使用GRID_LAYOUT传递回来的高度，额外影响因素有vGap、topPadding、bottomPadding；
   * 3.当layoutHeight定义了并且aspectRatio大于0时，请不要再提供组件高度，vlayout建议使用者在提供的组件的高度处使用GRID_LAYOUT传递回来的高度，grid总高度等于给定的高度，若需要宫格可以进行内部滑动，那么使用者提供的组件高度的总和必须大于layoutHeight；
   * 4.当layoutHeight定义了并且aspectRatio等于0时，grid总高度等于给定的高度，若需要宫格可以进行内部滑动，那么使用者提供的组件高度的总和必须大于layoutHeight；
   * vlayout原库：当单行纵横比>0时，使用者传递的组件的高度无效；
   * 异常情况：同时提供aspectRatio以及使用者提供的组件高度的情况下，会出现布局异常；
   * 滑动冲突问题：grid无rowsTemplate属性时表示grid可以进行内部滑动，但嵌套在list里时，一旦list能开始滑动之后grid的内部滑动就失效了；
   */
    func computedHeight() {
        let rowCount: Int64 = rowsTemplate.size / 4
        if (gridInfo.layoutHeight == 0.0 && gridInfo.aspectRatio == 0.0) {
            oneRowHeight = screenHeight
            layoutHeight = oneRowHeight * Float64(rowCount)
            computedExtraHeight(rowCount)

        } else if (gridInfo.layoutHeight == 0.0 && gridInfo.aspectRatio > 0.0) {
            gridWidth = screenWidth
            oneRowHeight = gridWidth / gridInfo.aspectRatio
            layoutHeight = oneRowHeight * Float64(rowCount)
            computedExtraHeight(rowCount)
        } else if (gridInfo.layoutHeight != 0.0 && gridInfo.aspectRatio > 0.0) {
            gridWidth = screenWidth
            oneRowHeight = gridWidth / gridInfo.aspectRatio
        } else if (gridInfo.layoutHeight != 0.0 && gridInfo.aspectRatio == 0.0) {
            oneRowHeight = gridInfo.layoutHeight
            layoutHeight = gridInfo.layoutHeight
        } else {
            Hilog.error(0x000000, "computedHeight", '${TAG} something else computedHeight')
        }
        Hilog.error(0x000000, "computedHeight", '${TAG}-------- ${oneRowHeight}')
    }

    func computedExtraHeight(rowCount: Int64) {
        if (gridInfo.vGap >= 0) {
            let height = layoutHeight
            layoutHeight = height + Float64(gridInfo.vGap * rowCount)
        }

        if (gridInfo.topPadding >= 0.0) {
            layoutHeight = layoutHeight + gridInfo.topPadding
        }

        if (gridInfo.bottomPadding >= 0.0) {
            layoutHeight = layoutHeight + gridInfo.bottomPadding
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
            .height(if(gridInfo.layoutHeight == 0.0){ layoutHeight } else { gridInfo.layoutHeight } )
            .columnsTemplate(columnsTemplate)
            .columnsGap(gridInfo.hGap)
            .rowsGap(gridInfo.vGap)
            .padding(
                top: gridInfo.topPadding,
                right: rightPadding,
                bottom: gridInfo.bottomPadding,
                left: gridInfo.leftPadding
            )
            .backgroundColor(gridInfo.bgColor)
            .zIndex(gridInfo.zIndex)
            .margin(
                top: gridInfo.topMargin,
                right: gridInfo.rightMargin,
                bottom: gridInfo.bottomMargin,
                left: gridInfo.leftMargin
            )

    }
}

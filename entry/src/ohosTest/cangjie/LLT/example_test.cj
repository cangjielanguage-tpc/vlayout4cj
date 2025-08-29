/**
 * Created on 2025/8/26
 */
package ohos_app_cangjie_entry_test.LLT

import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.ui_test.*

import vlayout4cj.commons.*
import vlayout4cj.*


@Test
class TestExample {

    @TestCase
    func testLevel0(): Unit {
        let driver = Driver.create()
        driver.findComponent(On().id("Level0")).click()
        driver.delayMs(1500)

        for(item in arr_L01) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestColumnRangeIndex")).click()
        driver.delayMs(1500)


        for(item in arr_L02) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestFixRangeIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L03) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestScrollFixBgColorIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L04) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestFloatBgOpacityIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L05) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestStickyLayoutHeightIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L06) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestStickyIsSticky")).click()
        driver.delayMs(1500)

        driver.findComponent(On().onType("List")).scrollToBottom()
        driver.delayMs(3000)

        driver.findComponent(On().id("back")).click()
        driver.delayMs(1500)

        driver.findComponent(On().id("l0_back")).click()
        driver.delayMs(1500)

    }

    @TestCase
    func testLevel1(): Unit {
        let driver = Driver.create()
        driver.findComponent(On().id("Level1")).click()
        driver.delayMs(1500)

        for(item in arr_L11) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestRangeGridColumnZindexMarginPaddingIndex")).click()
        driver.delayMs(1500)


        for(item in arr_L12) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestOneExRangeIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L13) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestLinearZindexMarginPaddingIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L14) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestStaggeredGridLanesIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L15) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("l1_back")).click()
        driver.delayMs(1500)

    }

    @TestCase
    func testLevel2(): Unit {
        let driver = Driver.create()
        driver.findComponent(On().id("Level2")).click()
        driver.delayMs(1500)

        for(item in arr_L21) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

        driver.findComponent(On().id("TestLinearLayoutHeightIssueIndex")).click()
        driver.delayMs(1500)

        for(item in arr_L22) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.findComponent(On().id("back")).click()
            driver.delayMs(1500)
        }

//        driver.findComponent(On().id("TestFloatLayoutWidthIssue")).click()
//        driver.delayMs(1500)
//
//        let text: UIComponent = driver.findComponent(On().onType("Text"))
//        let float = driver.findComponent(On().id("FLOAT"))
//
//        float.dragTo(text)
//
//        driver.delayMs(3000)

        driver.findComponent(On().id("l2_back")).click()
        driver.delayMs(1500)

    }
}
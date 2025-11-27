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
    func test(): Unit {
        let driver = Driver.create()
        for(item in arr_L01) {
            driver.findComponent(On().id("${item}")).click()
            driver.delayMs(1500)

            driver.pressBack()
            driver.delayMs(1500)
        }
    }
}
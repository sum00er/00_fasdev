## guide 使用說明
1. `/fashion_dev` 開啟選單
2. 輸入模型檔案名稱，選定附著的部位
3. 選單選項 `enter` 調整，`←``→`選擇調整方向
4. 設定改變幅度： 設定調整的幅度，預設為 pos 0.01, rot 10.0
5. 手動輸入參數： 直接輸入已有數據，用來調整現有數據
6. 完成： 數據將複製到剪貼簿，可以直接貼到時裝插件config
   ```lua
   {
    itemname = "sum_heartglasses", 
    Model = "sum_heartglasses", 
    Bone = 31086,
    xPos = 0.045,
    yPos = 0.07,
    zPos = 0.0,
    xRot = -190.0,
    yRot = -90.0,
    zRot = 0.0		        },
   ```
   或用這些數據套用到 `AttachEntityToEntity` 的參數裡

## preview 演示
  https://streamable.com/myq3rk

## installation 安裝
下載 source code, 解壓縮到resource 資料夾，console 輸入 `ensure 00_fasdev` 開啟插件

## dependency
* ox_lib

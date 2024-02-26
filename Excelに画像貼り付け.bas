Attribute VB_Name = "Module1"

Sub InsertImages(folderPath As String)
    Dim dirPath As String
    Dim filename As String
    Dim img As Picture
    Dim imgWidth As Double
    Dim imgHeight As Double
    Dim sht As Worksheet
    Dim currentTop As Double
    
    ' フォルダパスを指定
    
    ' シートを選択
    Set sht = ActiveSheet
    
    ' 初期位置設定
    currentTop = 2
     
    ' フォルダ内の各PNGファイルについて処理
    dirPath = dir(folderPath & "*.png")
    Do While dirPath <> ""
        ' 画像を挿入
        sht.Cells(currentTop, 1).Select
        Set img = sht.Pictures.Insert(folderPath & dirPath)
        
         '元画像のサイズにする
        Call img.ShapeRange.ScaleHeight(1, msoTrue, msoScaleFromTopLeft)
        Call img.ShapeRange.ScaleWidth(1, msoTrue, msoScaleFromTopLeft)

        'サイズを取得
        originalHeight = img.ShapeRange.Height
        
        ' 画像をシートに貼り付け
        img.Left = 55 ' 位置を調整

        With img.ShapeRange.Line
            .Visible = msoTrue
            .ForeColor.RGB = RGB(0, 0, 0)
            .Transparency = 0
        End With

        ' 次の画像の位置を設定
        currentTop = currentTop + Round(originalHeight / 18.75, 0) + 2 ' 適切な間隔を設定（例：10ポイント）
        
        ' 次のファイルを取得
        dirPath = dir()
    Loop
    
    ' 最後の位置を調整
    sht.Cells(1, 1).Select ' シートの一番上にスクロール
End Sub


Sub Macro2()
Attribute Macro2.VB_ProcData.VB_Invoke_Func = " \n14"
    Call InsertImages("C:\Users\steve\Desktop\jpg\")
End Sub

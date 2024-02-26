Attribute VB_Name = "Module1"

Sub InsertImages(folderPath As String)
    Dim dirPath As String
    Dim filename As String
    Dim img As Picture
    Dim imgWidth As Double
    Dim imgHeight As Double
    Dim sht As Worksheet
    Dim currentTop As Double
    
    ' �t�H���_�p�X���w��
    
    ' �V�[�g��I��
    Set sht = ActiveSheet
    
    ' �����ʒu�ݒ�
    currentTop = 2
     
    ' �t�H���_���̊ePNG�t�@�C���ɂ��ď���
    dirPath = dir(folderPath & "*.png")
    Do While dirPath <> ""
        ' �摜��}��
        sht.Cells(currentTop, 1).Select
        Set img = sht.Pictures.Insert(folderPath & dirPath)
        
         '���摜�̃T�C�Y�ɂ���
        Call img.ShapeRange.ScaleHeight(1, msoTrue, msoScaleFromTopLeft)
        Call img.ShapeRange.ScaleWidth(1, msoTrue, msoScaleFromTopLeft)

        '�T�C�Y���擾
        originalHeight = img.ShapeRange.Height
        
        ' �摜���V�[�g�ɓ\��t��
        img.Left = 55 ' �ʒu�𒲐�

        With img.ShapeRange.Line
            .Visible = msoTrue
            .ForeColor.RGB = RGB(0, 0, 0)
            .Transparency = 0
        End With

        ' ���̉摜�̈ʒu��ݒ�
        currentTop = currentTop + Round(originalHeight / 18.75, 0) + 2 ' �K�؂ȊԊu��ݒ�i��F10�|�C���g�j
        
        ' ���̃t�@�C�����擾
        dirPath = dir()
    Loop
    
    ' �Ō�̈ʒu�𒲐�
    sht.Cells(1, 1).Select ' �V�[�g�̈�ԏ�ɃX�N���[��
End Sub


Sub Macro2()
Attribute Macro2.VB_ProcData.VB_Invoke_Func = " \n14"
    Call InsertImages("C:\Users\steve\Desktop\jpg\")
End Sub

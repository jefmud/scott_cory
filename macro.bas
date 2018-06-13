' Add on Module for Scott Cory Project using ECH2O System
' June 2018
' J Muday WFU Biology Dept
'
' The DecimalIn argument is limited to 79228162514264337593543950245
' (approximately 96-bits) - large numerical values must be entered
' as a String value to prevent conversion to scientific notation. Then
' optional NumberOfBits allows you to zero-fill the front of smaller
' values in order to return values up to a desired bit level.
' CREDIT JUSTIN DAVIES - stackoverflow
Function DecToBin(ByVal DecimalIn As Variant, Optional NumberOfBits As Variant) As String
  DecToBin = ""
  DecimalIn = CDec(DecimalIn)
  Do While DecimalIn <> 0
    DecToBin = Trim$(Str$(DecimalIn - 2 * Int(DecimalIn / 2))) & DecToBin
    DecimalIn = Int(DecimalIn / 2)
  Loop
  If Not IsMissing(NumberOfBits) Then
    If Len(DecToBin) > NumberOfBits Then
      DecToBin = "Error - Number too large for bit size"
    Else
      DecToBin = Right$(String$(NumberOfBits, "0") & _
      DecToBin, NumberOfBits)
    End If
  End If
End Function

' simple binary to decimal conversion
Function BinToDec(ByVal sBinary As String) As Long
    Dim i As Long
    Dim lReturn As Long
    Dim pow As Long
    
    pow = 0
    For i = Len(sBinary) To 1 Step -1
        lBit = Val(Mid$(sBinary, i, 1))
        lReturn = lReturn + lBit * (2 ^ pow)
        pow = pow + 1
    Next i
    
    BinToDec = lReturn
    
End Function

' compute water potential
' from ECH2O System Specifications and Conversion Equations
Function WaterPotential(ByVal DecimalIn As Variant) As Double
    binary_string = DecToBin(DecimalIn, 32)
    bs = Right$(binary_string, 16)
    Rw = BinToDec(bs)
    WaterPotential = 10 ^ (0.0001 * Rw) / -10.20408
End Function

' from ECH2O System Specifications and Conversion Equations
Function Temperature(ByVal DecimalIn As Variant, Optional NumberOfBits As Variant) As Double
    binary_string = DecToBin(DecimalIn, 32)
    bs = Mid$(binary_string, 7, 10)
    Rt = BinToDec(bs)
    If Rt <= 900 Then
        Temperature = (Rt - 400) / 10
    Else
        Temperature = ((900 + 5 * (Rt - 900)) - 400) / 10
    End If
        
End Function

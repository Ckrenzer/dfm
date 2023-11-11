$file_to_update = $args[0]

# Open the workbook and refresh it.
# Sleep calls are included for two reasons:
#   To allow background updates, which vary
#       in complexity, to run their course.
#   To allow the program to ensure the files
#       had enough time to finish processes
#       before moving to the next step.
$excel_comobject = New-Object -ComObject "Excel.Application"
$excel_comobject.Visible = $false
$wb = $excel_comobject.workbooks.Open("$PWD\$file_to_update")
Start-Sleep 5
$wb.refreshall()
Start-Sleep 10
$wb.SaveAs("$PWD\$file_to_update")
Start-Sleep 5
$wb.Close()
$excel_comobject.Quit()
Remove-Variable wb,excel_comobject

# Usage:
# powershell -noprofile -command ". excel_refresh_all.ps1 file.xlsx"


//
//  Программа отображения диалога _Dlg_
//

(defun  start ()

      (try (dlgDestroy '_Dlg_) except Nil)

      (dlgCreate '_Dlg_ 549 294 "Генератор рекуррентных соотношений" &H8000000F)

      (dlgAddControl '_Dlg_ '_LBL_1 _LABEL 19 17 198 24 '("Tahoma" 11,25 1 0 0) "Порождающая функция:" 0 &H80000012 &H8000000F)

      (dlgAddControl '_Dlg_ '_TXT_1 _TEXT 231 11 292 30 '("Tahoma" 11 1 0 0) "" 0 &H80000008 &H80000005)

      (dlgAddControl '_Dlg_ '_LBL_2 _LABEL 17 49 210 30 '("Tahoma" 11,25 1 0 0) "Исходные значения:" 0 &H80000012 &H8000000F)

      (dlgAddControl '_Dlg_ '_TXT_2 _TEXT 231 48 292 28 '("Tahoma" 11 1 0 0) "" 0 &H80000008 &H80000005)

      (dlgAddControl '_Dlg_ '_LBL_3 _LABEL 17 84 199 36 '("Tahoma" 11,25 1 0 0) "Размер вывода:" 0 &H80000012 &H8000000F)

      (dlgAddControl '_Dlg_ '_TXT_3 _TEXT 231 84 61 29 '("Tahoma" 11 1 0 0) "10" 0 &H80000008 &H80000005)

      (dlgAddControl '_Dlg_ '_TXT_4 _TEXT 17 122 507 71 '("Tahoma" 8 1 0 0) "" 0 &H80000008 &H80000005)

      (dlgAddControl '_Dlg_ '_BUT_1 _BUTTON 18 203 110 42 '("Tahoma" 8,25 1 0 0) "Вычислить")
      (dlgPutPicture '_BUT_1 7)

      (dlgAddControl '_Dlg_ '_BUT_2 _BUTTON 137 204 104 41 '("Tahoma" 8,25 1 0 0) "Закрыть")
      (dlgPutPicture '_BUT_2 36)

      //
      // Пролог загрузки диалога _Dlg_
      //

      (Prog () 

      )

      //
      // Обработчик события CLICK для кнопки _BUT_2
      //

      (defun _BUT_2_Click  Nil 

        (dlgHide '_DLG_)
        (dlgDestroy '_DLG_) 

      )

      //
      //   Назначение процедуры-события _BUT_2_Click  контролу _BUT_2
      //

      (dlgSetEvent '_BUT_2 '_BUT_2_Click )

      //
      // Обработчик события CLICK для кнопки _BUT_1
      //

      (defun _BUT_1_Click  Nil 

        (let ((f    (input (dlgGetText '_TXT_1)))
              (args (input (strCat "(" (dlgGetText '_TXT_2) ")")))
              (n    (str2fix (dlgGetText '_TXT_3))))

              (dlgPutText '_TXT_4 (output (take! n (apply 'uni-rec! (cons f args)))))))

      //
      //   Назначение процедуры-события _BUT_1_Click  контролу _BUT_1
      //

      (dlgSetEvent '_BUT_1 '_BUT_1_Click )


      //
      //   Отображение диалога _Dlg_
      //

      (dlgShow '_Dlg_)
)


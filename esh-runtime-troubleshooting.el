(defun recalculate-all ()
  "Recalculate all formulas"
  (interactive)
  (let ((wid (/ (line-length) 6))
	(hei (/ (point-max) (line-length))))
    (let ((y 0))
      (while (< y hei)
	(let ((x 0))
	  (while (< x wid)
	    (refresh-cell x y)
	    (setq x (+ x 1))))
	(setq y (+ y 1))))))


(defun restore-edit-line () "set up the windows to the initial esheet configuration"
  (interactive)
  (delete-other-windows)
  (re-activate-esheet-toolbar)
  (let ((new-win (split-window)))
    (enlarge-window (- (window-height new-win) 4) nil new-win)
    (switch-to-buffer (get-buffer-create "*edit line*"))
    (esheet-edit-line-mode)
    (select-window new-win)
    )
  )

(defun restore-cursor-function () "fix gaps in line lengths that confuse esheet"
  (interactive)
  (let ((l (line-length)))
    (if (not (zerop (mod l 6)))
	(setq l (+ l 6 (- (mod l 6)))))
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))
	(forward-char)
	(end-of-line)
	(if (< (current-column) l) 
	    (insert (concat (make-vector (- l (current-column)) ?\ ))))
	(if (> (current-column) l)
	    (delete-char (- l (current-column))))
	)
      )
    )
  )

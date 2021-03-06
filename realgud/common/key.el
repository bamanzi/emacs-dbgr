;;; Copyright (C) 2010, 2011 Rocky Bernstein <rocky@gnu.org>
(require 'load-relative)

(defcustom realgud-populate-common-fn-keys-function
  'realgud-populate-common-fn-keys-standard
  "The function to call to populate key bindings common to all dbgr windows.
This includes the secondary windows, the debugger shell, and all
Ruby source buffers when the debugger is active.

This variable can be bound to the following:

* nil -- Don't bind any keys.

* `realgud-populate-common-fn-keys-standard' -- Bind the function
  keys according to a widely used debugger convention:

\\{realgud-example-map-standard}

* `realgud-populate-common-fn-keys-eclipse' -- Bind according to Eclipse.

\\{realgud-example-map-eclipse}

* `realgud-populate-common-fn-keys-netbeans' -- Bind according to NetBeans.

\\{realgud-example-map-netbeans}

* Any other value is expected to be a callable function that takes one
  argument, the keymap, and populates it with suitable keys."
  :type 'function
  :group 'realgud)

;; -------------------------------------------------------------------
;; Key bindings
;;

(defun realgud-populate-common-fn-keys-standard (&optional map)
  "Bind the debugger function key layout used by many debuggers.

\\{realgud-example-map-standard}"
  (define-key map [f9]    'realgud-continue)
  ;;(define-key map [S-f5]  'realgud-cmd-quit)
  ;; (define-key map [f9]    'realgud-toggle-source-breakpoint)
  (define-key map [C-f9]    'realgud-cmd-break)
  ;; (define-key map [C-f9]  'realgud-toggle-source-breakpoint-enabled)
  (define-key map [f7]   'realgud-cmd-next)
  (define-key map [f8]   'realgud-cmd-step)
  ;;(define-key map [S-f11] 'realgud-cmd-finish)

  (define-key map [M-down]    'realgud-track-hist-newer)
  (define-key map [M-kp-2]    'realgud-track-hist-newer)
  (define-key map [M-up]      'realgud-track-hist-older)
  (define-key map [M-kp-8]    'realgud-track-hist-older)
  (define-key map [M-kp-up]   'realgud-track-hist-older)
  (define-key map [M-kp-down] 'realgud-track-hist-newer)
  (define-key map [M-print]   'realgud-track-hist-older)
  (define-key map [M-S-down]  'realgud-track-hist-newest)
  (define-key map [M-S-up]    'realgud-track-hist-oldest)
  (define-key map "\C-c " 'realgud-cmd-break)
  )

;; TODO: add eclipse, and netbeans

(defun realgud-populate-common-keys (map)
  "Define the keys that are used by all debugger buffers, including
source-code buffers

The variable `realgud-populate-common-fn-keys-function' controls the layout."
  (define-key map "\C-x\C-a\C-q" 'realgud-short-key-mode)
  (if realgud-populate-common-fn-keys-function
      (funcall realgud-populate-common-fn-keys-function map))
  (realgud-populate-common-fn-keys-standard map)
)

(defun realgud-populate-src-buffer-map-plain (map)
  "Bind ordinary text characters used in debugger source-code buffers.

This does not touch change menus; for that see `realgud-populate-debugger-menu'.
Nor does it touch prefix keys; for that see `realgud-populate-keys-standard'"
  ;; Keys to view other buffers.
  (let ((prefix-map (make-sparse-keymap)))
    (define-key map "b" 'realgud-cmd-break)
    (define-key map " " 'realgud-cmd-step)
    (define-key map "f" 'realgud-cmd-finish)
    (define-key map "n" 'realgud-cmd-next)
    (define-key map "q" 'realgud-cmd-quit)
    (define-key map "r" 'realgud-cmd-restart)
    (define-key map "R" 'realgud-cmd-restart)
    (define-key map "s" 'realgud-cmd-step)
    (define-key map "!" 'realgud-cmd-shell)

    ;; FIXME: these can go to a common routine. See also shortkey.el
    ;; and backtrace-mode.el
    (define-key map "<" 'realgud-cmd-newer-frame)
    (define-key map ">" 'realgud-cmd-older-frame)
    (define-key map "d" 'realgud-cmd-newer-frame)
    (define-key map "u" 'realgud-cmd-older-frame)
    (define-key map "C" 'realgud-window-cmd-undisturb-src)
    (define-key map "F" 'realgud-window-bt)
    (define-key map "Q" 'realgud-cmd-terminate)
    (define-key map "S" 'realgud-window-src-undisturb-cmd)

    (define-key map [M-down]    'realgud-track-hist-newer)
    (define-key map [M-kp-2]    'realgud-track-hist-newer)
    (define-key map [M-up]      'realgud-track-hist-older)
    (define-key map [M-kp-8]    'realgud-track-hist-older)
    (define-key map [M-kp-up]   'realgud-track-hist-older)
    (define-key map [M-kp-down] 'realgud-track-hist-newer)
    (define-key map [M-print]   'realgud-track-hist-older)
    (define-key map [M-S-down]  'realgud-track-hist-newest)
    (define-key map [M-S-up]    'realgud-track-hist-oldest)
    ))

(provide-me "realgud-")

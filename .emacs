(setq inhibit-splash-screen t) ;; hide splash screen

;; Added by Package.el.
;; This must come before configurations of installed packages.
(package-initialize)

;; Add Melpa packages
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
          Your version of Emacs does not support SSL connections,
          which is unsafe because it allows man-in-the-middle attacks.
          There are two things you can do about this warning:
            1. Install an Emacs version that does support SSL and be safe.
            2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(setq evil-want-C-u-scroll t) ;; enable upwards scrolling with C-u
;; the line above should be before requiring evil
(require 'evil)
(evil-mode 1) ;; Evil mode... ON!

(require 'ido) ;; interactivly do thing! suggest files when C-x C-f is done
(ido-mode t)

(require 'smex) ;;ido for M-x
(global-set-key (kbd "M-x") 'smex)

(menu-bar-mode 0) ;; hide top bar
(tool-bar-mode 0) ;; hide save/open file etc bar
(global-linum-mode 1) ;; show line numbers

;; emacs initializes packages after .emacs is read
;; the code below will call all functions after initialization.
;;(add-hook 'after-init-hook (lambda () ))

(add-hook `haskell-mode-hook #'haskell-indent-mode)
(add-hook `haskell-mode-hook #'interactive-haskell-mode)
(add-hook `haskell-mode-hook #'hindent-mode)
;; ===========================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (gruber-darker)))
 '(custom-safe-themes
   (quote
    ("47ec21abaa6642fefec1b7ace282221574c2dd7ef7715c099af5629926eb4fd7" default)))
 '(package-selected-packages
   (quote
    (hindent dante haskell-mode gruber-darker-theme evil smex)))
 '(hindent-reformat-buffer-on-save t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

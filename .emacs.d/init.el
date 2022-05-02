;; relative number lines
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(setq make-backup-files nil)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;;No menu bar
(menu-bar-mode -1)
;(tool-bar-mode -1)

(show-paren-mode t)
(electric-pair-mode 1)

(require 'base)
(require 'evilc)
(require 'theme)
(require 'c-cpp)
(require 'gopls)
(require 'python)
;(require 'jtxs)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(use-package evil lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

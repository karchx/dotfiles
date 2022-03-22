(global-linum-mode t)
(setq make-backup-files nil)

(add-to-list 'load-path (concat user-emacs-directory "elisp"))

;;No menu bar
(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'base)
(require 'evilc)
(require 'theme)
(require 'c-cpp)

(custom-set-variables

 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages '(use-package evil lsp-mode yasnippet lsp-treemacs helm-lsp projectile hydra flycheck company avy which-key helm-xref dap-mode)))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))


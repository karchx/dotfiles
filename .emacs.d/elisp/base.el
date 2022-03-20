(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(provide 'base)

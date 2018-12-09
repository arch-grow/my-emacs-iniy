(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t))

;; System-type definition
(defun system-is-linux()
  (string-equal system-type "gnu/linux"))
(defun system-is-windows()
  (string-equal system-type "windows-nt"))

;; Start Emacs as a server
(when (system-is-linux)
  (require 'server)
  (unless (server-running-p)
    (server-start))) ;; Запустить Emacs как сервер, если OS - GNU/Linux

;; MS Windows path-variable
(when (system-is-windows)
  (setq win-sbcl-exe          "C:/sbcl/sbcl.exe")
  (setq win-init-path         "C:/.emcs.d")
  (setq win-init-ct-path      "C:/.emacs.d/plugins/color-theme")
  (setq win-init-ac-path      "C:/.emacs.d/plugins/autocomplete")
  (setq win-init-slime-path   "C:/slime")
  (setq win-init-ac-dict-path "C:/.emacs.d/plugins/auto-complete/dict"))

;; Unix path-variable
(when (system-is-linux)
  (setq unix-sbcl-bin          "/usr/bin/sbcl")
  (setq unix-init-path         "~/.emacs.d/lisp")
  (setq unix-init-ct-path      "~/.emacs.d/plugins/color-theme")
  (setq unix-init-ac-path      "~/.emacs.d/plugins/auto-complete")
  (setq unix-init-slime-path   "/usr/share/common-lisp/source/slime/")
  (setq unix-init-ac-dict-path "~/.emacs.d/plugins/auto-complete/dict"))

;; My name and e-email adress
(setq user-full-name   "%user-name%")
(setq user-mail-adress "%user-mail%")

;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top) ;; чтобы можно было не пустые директории удалять...

;; Imenu
(require 'imenu)
(setq imenu-auto-rescan      t) ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil) ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f6>") 'imenu) ;; вызов Imenu на F6

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Load path for plugins
(if (system-is-windows)
    (add-to-list 'load-path win-init-path)
  (add-to-list 'load-path unix-init-path))

;; Org-mode settings
(require 'org) ;; Вызвать org-mode
(global-set-key "\C-ca" 'org-agenda) ;; определение клавиатурных комбнаций для внутренних
(global-set-key "\C-cb" 'org-isswithb) ;; подрежимов org-mode
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; Ассоциируем *.org файлы с org-mode

;; Inhibit startup/splash screen
(setq inhibit-splash-screen   t)
(setq inhibit-startup-message t) ;; экран приветствия можно вызвать комбинацией C-h C-a

;; Show paren-mode settings
(show-paren-mode t) ;; включить выделение выражений между {},[],()
(setq show-paren-style 'expression) ;; Выделить цветом выражения между {},[],()

;; Electric-modes settings
(electric-pair-mode   1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок

;; Delete selection
(delete-selection-mode t)

;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1) ;; Отключаем графическое меню
(tool-bar-mode     -1) ;; Отключаем tool-bar
(scroll-bar-mode   -1) ;; Отключаем полусу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil) ;; Никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t) ;; Лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; Откючить звуковой сигнал

;; Disable backup/avtosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode    t) ;; показать номер строки в mode-line
(global-linum-mode   t) ;; показывать номера строк во всех буферах
(column-number-mode  t) ;; показать номер столбца в mode-line
(setq linum-format "%d") ;; задаём формат нумерации строк

;; Fringe settings
(fringe-mode '(8 . 0)) ;; ограничитель текста только слева
(setq-default indicate-emty-lines t) ;; отсутствие строки выделить гифами рядом с полосой с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; индикация только слева

;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла %-ах

;; Line wrapping
(setq word-wrap          t) ;; переносить по словам
(global-visual-line-mode t)

;; Start window size
(when (window-system)
  (set-frame-size (selected-frame) 100 50))

;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer) ;; отдельный список буферов при нажатии C-x C-b
(global-set-key (kbd "<f2>") 'bs-show) ;; запуск buffer selection кнопкой  F2


;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t) ;; включено с версии Emacs-22 так на всякий...
(setq font-lock-maximum-decoration t)

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
(setq x-select-enable-clipboard t)

;; End of file newlines
(setq require-final-newline    t) ;; добавить новую пустую строку в конец файла при сохранении
(setq next-line-add-newlines nil) ;; не добавлять новую строку в конец при смещении курсора стрелками

;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)

;; Delete trailing whitespace, format buffer and untabify when save buffer
(defun format-current-buffer()
    (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
    (if (not indent-tabs-mode)
        (untabify (point-min) (point-max)))
    nil)
(add-to-list 'write-file-functions 'format-current-buffer)
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)

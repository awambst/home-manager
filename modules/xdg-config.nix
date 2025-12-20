# Liste exhaustive des types MIME pour NixOS home-manager
# Avec variables pour faciliter la personnalisation

let
  # ========================================
  # DÉFINIR TES APPLICATIONS ICI
  # ========================================
  imageEditor = "gimp.desktop";
  vectorEditor = "inkscape.desktop";
  rawEditor = "rawtherapee.desktop";
  textEditor = "nvim.desktop";
  codeEditor = "nvim.desktop";
  pdfViewer = "okular.desktop";
  officeWriter = "writer.desktop";
  officeCalc = "calc.desktop";
  officePresentation = "impress.desktop";
  videoPlayer = "mpv.desktop";
  audioPlayer = "mpv.desktop";
  archiveManager = "ark.desktop";
  ebookReader = "calibre.desktop";
  torrentClient = "transmission-gtk.desktop";
  fontViewer = "org.gnome.font-viewer.desktop";
  fileManager = "dolphin.desktop";
  webBrowser = "firefox.desktop";
  emailClient = "thunderbird.desktop";
  modelViewer = "blender.desktop";
  databaseViewer = "sqlitebrowser.desktop";
  diskImageMounter = "brasero.desktop";
  imageViewer = "gwenview.desktop";  # pour feh, utilise "feh.desktop"
  
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      
      # ========================================
      # IMAGES - Raster
      # ========================================
      "image/png" = imageEditor;
      "image/jpeg" = imageEditor;
      "image/jpg" = imageEditor;
      "image/gif" = imageEditor;
      "image/bmp" = imageEditor;
      "image/tiff" = imageEditor;
      "image/webp" = imageEditor;
      "image/x-tga" = imageEditor;
      "image/x-ico" = imageEditor;
      "image/vnd.microsoft.icon" = imageEditor;
      "image/x-pcx" = imageEditor;
      "image/x-portable-pixmap" = imageEditor;
      "image/x-portable-bitmap" = imageEditor;
      "image/x-portable-graymap" = imageEditor;
      "image/x-xbitmap" = imageEditor;
      "image/x-xpixmap" = imageEditor;
      "image/heic" = imageEditor;
      "image/heif" = imageEditor;
      "image/avif" = imageEditor;
      "image/jxl" = imageEditor;
      
      # ========================================
      # IMAGES - Vectoriel
      # ========================================
      "image/svg+xml" = vectorEditor;
      "image/svg+xml-compressed" = vectorEditor;
      "application/illustrator" = vectorEditor;
      "image/x-eps" = vectorEditor;
      "application/postscript" = vectorEditor;
      
      # ========================================
      # IMAGES - RAW Photo
      # ========================================
      "image/x-canon-cr2" = rawEditor;
      "image/x-canon-crw" = rawEditor;
      "image/x-nikon-nef" = rawEditor;
      "image/x-sony-arw" = rawEditor;
      "image/x-adobe-dng" = rawEditor;
      "image/x-pentax-pef" = rawEditor;
      "image/x-olympus-orf" = rawEditor;
      "image/x-fuji-raf" = rawEditor;
      
      # ========================================
      # DOCUMENTS - Texte
      # ========================================
      "text/plain" = textEditor;
      "text/markdown" = textEditor;
      "text/x-markdown" = textEditor;
      "text/x-readme" = textEditor;
      "text/x-changelog" = textEditor;
      "text/x-log" = textEditor;
      "text/x-txt" = textEditor;
      "application/x-yaml" = textEditor;
      "text/yaml" = textEditor;
      "application/json" = textEditor;
      "application/x-json" = textEditor;
      "text/x-json" = textEditor;
      "application/xml" = textEditor;
      "text/xml" = textEditor;
      "text/x-ini" = textEditor;
      "application/toml" = textEditor;
      "text/x-toml" = textEditor;
      
      # ========================================
      # DOCUMENTS - Code source
      # ========================================
      "text/x-c" = codeEditor;
      "text/x-c++" = codeEditor;
      "text/x-chdr" = codeEditor;
      "text/x-csrc" = codeEditor;
      "text/x-c++src" = codeEditor;
      "text/x-java" = codeEditor;
      "text/x-python" = codeEditor;
      "application/x-python" = codeEditor;
      "text/x-ruby" = codeEditor;
      "text/x-rust" = codeEditor;
      "text/x-go" = codeEditor;
      "text/javascript" = codeEditor;
      "application/javascript" = codeEditor;
      "text/x-javascript" = codeEditor;
      "application/x-javascript" = codeEditor;
      "text/typescript" = codeEditor;
      "application/typescript" = codeEditor;
      "text/x-php" = codeEditor;
      "application/x-php" = codeEditor;
      "text/x-shellscript" = codeEditor;
      "application/x-shellscript" = codeEditor;
      "text/x-sh" = codeEditor;
      "application/x-sh" = codeEditor;
      "text/x-zsh" = codeEditor;
      "text/x-bash" = codeEditor;
      "text/html" = codeEditor;
      "text/x-html" = codeEditor;
      "application/xhtml+xml" = webBrowser;
      "text/css" = codeEditor;
      "text/x-css" = codeEditor;
      "text/x-scss" = codeEditor;
      "text/x-sass" = codeEditor;
      "text/x-less" = codeEditor;
      "application/x-sql" = codeEditor;
      "text/x-sql" = codeEditor;
      
      # ========================================
      # DOCUMENTS - Office
      # ========================================
      "application/pdf" = pdfViewer;
      "application/x-pdf" = pdfViewer;
      
      # LibreOffice Writer
      "application/vnd.oasis.opendocument.text" = officeWriter;
      "application/vnd.oasis.opendocument.text-template" = officeWriter;
      "application/msword" = officeWriter;
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = officeWriter;
      "application/rtf" = officeWriter;
      "text/rtf" = officeWriter;
      
      # LibreOffice Calc
      "application/vnd.oasis.opendocument.spreadsheet" = officeCalc;
      "application/vnd.oasis.opendocument.spreadsheet-template" = officeCalc;
      "application/vnd.ms-excel" = officeCalc;
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = officeCalc;
      "text/csv" = officeCalc;
      "text/x-csv" = officeCalc;
      "application/csv" = officeCalc;
      
      # LibreOffice Impress
      "application/vnd.oasis.opendocument.presentation" = officePresentation;
      "application/vnd.oasis.opendocument.presentation-template" = officePresentation;
      "application/vnd.ms-powerpoint" = officePresentation;
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = officePresentation;
      
      # ========================================
      # VIDÉOS
      # ========================================
      "video/mp4" = videoPlayer;
      "video/x-matroska" = videoPlayer;
      "video/x-msvideo" = videoPlayer;
      "video/mpeg" = videoPlayer;
      "video/quicktime" = videoPlayer;
      "video/webm" = videoPlayer;
      "video/x-flv" = videoPlayer;
      "video/x-m4v" = videoPlayer;
      "video/3gpp" = videoPlayer;
      "video/3gpp2" = videoPlayer;
      "video/ogg" = videoPlayer;
      "video/x-ogm+ogg" = videoPlayer;
      "video/x-theora+ogg" = videoPlayer;
      "video/mp2t" = videoPlayer;
      "video/vnd.avi" = videoPlayer;
      "video/divx" = videoPlayer;
      "video/x-ms-wmv" = videoPlayer;
      "video/x-ms-asf" = videoPlayer;
      
      # ========================================
      # AUDIO
      # ========================================
      "audio/mpeg" = audioPlayer;
      "audio/mp3" = audioPlayer;
      "audio/x-mp3" = audioPlayer;
      "audio/flac" = audioPlayer;
      "audio/x-flac" = audioPlayer;
      "audio/ogg" = audioPlayer;
      "audio/x-vorbis+ogg" = audioPlayer;
      "audio/x-opus+ogg" = audioPlayer;
      "audio/opus" = audioPlayer;
      "audio/wav" = audioPlayer;
      "audio/x-wav" = audioPlayer;
      "audio/aac" = audioPlayer;
      "audio/x-aac" = audioPlayer;
      "audio/m4a" = audioPlayer;
      "audio/x-m4a" = audioPlayer;
      "audio/mp4" = audioPlayer;
      "audio/x-ms-wma" = audioPlayer;
      "audio/webm" = audioPlayer;
      "audio/3gpp" = audioPlayer;
      "audio/amr" = audioPlayer;
      "audio/ape" = audioPlayer;
      "audio/x-ape" = audioPlayer;
      "audio/midi" = audioPlayer;
      "audio/x-midi" = audioPlayer;
      
      # ========================================
      # ARCHIVES
      # ========================================
      "application/zip" = archiveManager;
      "application/x-zip" = archiveManager;
      "application/x-zip-compressed" = archiveManager;
      "application/x-tar" = archiveManager;
      "application/x-compressed-tar" = archiveManager;
      "application/x-bzip-compressed-tar" = archiveManager;
      "application/x-xz-compressed-tar" = archiveManager;
      "application/gzip" = archiveManager;
      "application/x-gzip" = archiveManager;
      "application/x-bzip" = archiveManager;
      "application/x-bzip2" = archiveManager;
      "application/x-xz" = archiveManager;
      "application/x-7z-compressed" = archiveManager;
      "application/x-rar" = archiveManager;
      "application/x-rar-compressed" = archiveManager;
      "application/vnd.rar" = archiveManager;
      "application/x-lzma" = archiveManager;
      "application/x-lzip" = archiveManager;
      "application/zstd" = archiveManager;
      "application/x-archive" = archiveManager;
      "application/x-iso9660-image" = archiveManager;
      
      # ========================================
      # E-BOOKS
      # ========================================
      "application/epub+zip" = ebookReader;
      "application/x-mobipocket-ebook" = ebookReader;
      "application/x-fictionbook+xml" = ebookReader;
      "application/x-cbr" = ebookReader;
      "application/x-cbz" = ebookReader;
      "application/vnd.comicbook+zip" = ebookReader;
      "application/vnd.comicbook-rar" = ebookReader;
      
      # ========================================
      # TORRENTS
      # ========================================
      "application/x-bittorrent" = torrentClient;
      "application/x-torrent" = torrentClient;
      
      # ========================================
      # FONTS
      # ========================================
      "application/x-font-ttf" = fontViewer;
      "application/x-font-otf" = fontViewer;
      "application/x-font-woff" = fontViewer;
      "application/x-font-woff2" = fontViewer;
      "font/ttf" = fontViewer;
      "font/otf" = fontViewer;
      "font/woff" = fontViewer;
      "font/woff2" = fontViewer;
      
      # ========================================
      # DIVERS
      # ========================================
      "application/x-desktop" = textEditor;
      "application/x-executable" = textEditor;
      "inode/directory" = fileManager;
      "x-scheme-handler/http" = webBrowser;
      "x-scheme-handler/https" = webBrowser;
      "x-scheme-handler/ftp" = webBrowser;
      "x-scheme-handler/mailto" = emailClient;
      "x-scheme-handler/magnet" = torrentClient;
      
      # Fichiers 3D
      "model/stl" = modelViewer;
      "application/x-blender" = modelViewer;
      "model/obj" = modelViewer;
      "model/gltf+json" = modelViewer;
      "model/gltf-binary" = modelViewer;
      
      # Bases de données
      "application/x-sqlite3" = databaseViewer;
      "application/vnd.sqlite3" = databaseViewer;
      
      # Images disque
      "application/x-cd-image" = diskImageMounter;
      "application/x-raw-disk-image" = diskImageMounter;
    };
  };
}

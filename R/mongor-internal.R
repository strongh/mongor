.help.ESS <-
function (topic, package = NULL, lib.loc = NULL, verbose = getOption("verbose"), 
    try.all.packages = getOption("help.try.all.packages"), help_type = getOption("help_type"), 
    chmhelp = getOption("chmhelp"), htmlhelp = getOption("htmlhelp"), 
    offline = FALSE) 
{
    if (!missing(package)) 
        if (is.name(y <- substitute(package))) 
            package <- as.character(y)
    if (missing(topic)) {
        if (!missing(package)) 
            return(library(help = package, lib.loc = lib.loc, 
                character.only = TRUE))
        if (!missing(lib.loc)) 
            return(library(lib.loc = lib.loc))
        topic <- "help"
        package <- "utils"
        lib.loc <- .Library
    }
    ischar <- tryCatch(is.character(topic) && length(topic) == 
        1L, error = identity)
    if (inherits(ischar, "error")) 
        ischar <- FALSE
    if (!ischar) {
        reserved <- c("TRUE", "FALSE", "NULL", "Inf", "NaN", 
            "NA", "NA_integer_", "NA_real_", "NA_complex_", "NA_character_")
        stopic <- deparse(substitute(topic))
        if (!is.name(substitute(topic)) && !stopic %in% reserved) 
            stop("'topic' should be a name, length-one character vector or reserved word")
        topic <- stopic
    }
    help_type <- if (!length(help_type)) {
        if (offline) {
            warning("offline = TRUE is deprecated: use help_type =\"postscript\"")
            "ps"
        }
        else if (.Platform$OS.type == "windows" && is.logical(chmhelp) && 
            !is.na(chmhelp) && chmhelp) {
            warning("chmhelp = TRUE is no longer supported: using help_type =\"text\"")
            "text"
        }
        else if (is.logical(htmlhelp) && !is.na(htmlhelp) && 
            htmlhelp) {
            warning("htmhelp = TRUE is deprecated: use help_type =\"html\"")
            "html"
        }
        else "text"
    }
    else match.arg(tolower(help_type), c("text", "html", "postscript", 
        "ps", "pdf"))
    type <- switch(help_type, text = "help", postscript = , ps = , 
        pdf = "latex", help_type)
    paths <- sapply(.find.package(package, lib.loc, verbose = verbose), 
        function(p) index.search(topic, p, "AnIndex", type))
    paths <- paths[paths != ""]
    tried_all_packages <- FALSE
    if (!length(paths) && is.logical(try.all.packages) && !is.na(try.all.packages) && 
        try.all.packages && missing(package) && missing(lib.loc)) {
        lib.loc <- .libPaths()
        packages <- .packages(all.available = TRUE, lib.loc = lib.loc)
        packages <- packages[is.na(match(packages, .packages()))]
        for (lib in lib.loc) {
            for (pkg in packages) {
                dir <- system.file(package = pkg, lib.loc = lib)
                paths <- c(paths, index.search(topic, dir, "AnIndex", 
                  "help"))
            }
        }
        paths <- paths[paths != ""]
        tried_all_packages <- TRUE
    }
    paths <- unique(paths)
    attributes(paths) <- list(call = match.call(), topic = topic, 
        tried_all_packages = tried_all_packages, type = help_type)
    class(paths) <- "help_files_with_topic"
    paths
}

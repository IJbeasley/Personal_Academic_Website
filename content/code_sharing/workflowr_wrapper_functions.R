


################################################################################



################################################################################


# Functions which wrap around workflowr functions (build, publish)


# Adapted from https://github.com/jdblischak/workflowr/issues/95

# also from https://github.com/jdblischak/workflowr/blob/master/R/wflow_publish.R


# For using workflowr with non-analysis subfolder, to help keep .rmds in this folder

# separate from other .rmds in the analysis folder - since the number of analysis

# .rmds for different ml runs will likely get quite large 


###############################################################################



###############################################################################

# Function to: 

# produce temporary .rmd in analysis subfolder

#' Generate .Rmd file in analysis folder which sources child document from another folder 
#' (meant to be used within wflow_dir_build / wflow_dir_publish)
#' 
#' 
#' @param path The path of the child rmarkdown document (relative to the directory folder)
#' @param alias The name of the temporary markdown file in analysis (which sources)
#' @param dir The directory folder (not analysis!) where the child rmarkdown file is
#' 
#' @export
generate_rmd <- function(path, alias, dir) {
  
  
  path <- paste0(dir, '/', path)
  abs.path <- tools::file_path_as_absolute(paste0('./', path))
  #setwd("./analysis")
  cat(
    "---\n",
    yaml::as.yaml(rmarkdown::yaml_front_matter(abs.path)),
    "---\n\n",
    "**Source file\\:** ", path, "\n\n",
    "```{r child=here::here('", path, "')}\n```",
    sep="",
    file=alias
    
  )
}


##############################################################################


# wrapper around wflow_build

# which creates a temporary .rmd file in analysis

# builds using wflow_build 

# removes temporary .rmd file

#' workflowr::wflow_build but for files in directories other than analysis 
#' 
#' @description Wrapper function around \code{workflowr::wflow_build} which creates a temporary .rmd file in the
#' analysis subfolder, builds it using \code{workflowr::wflowr_build} and then removes the temporary .Rmd 
#' file from the analysis subfolder. 
#' 
#' @param files As per workflowr::wflow_build, the names of the .Rmd files to build
#' @param dir The directory where the .Rmd files to build are found (not analysis!)
#' @param ... Anything else to pass to workflowr::wflow_build
#' 
#' @export
wflow_dir_build <- function(files=NULL, dir=NULL, ...) {
  
  if(is.null(dir)){
    stop("You haven't specified a directory to find the file. Please set dir = directory of file")
  }
  
  # check whether files exist (particularly important to check that
  # in case of inappropriate directory choice
  if (is.null(files)) {
    files <- list.files(paste0('./', dir), recursive=T, 
                        include.dirs=T, pattern="./*.(r|R)md")
  }
  else {
    for (file in files) {
      path <- paste0(dir, "/", file)
      if (!file.exists(paste0('./', path)))
        stop(paste0("File doesn't exist: ./", path))
    }
  }
  
  # add .Rmd file to analysis folder (for each file), for which the original .Rmds are child documents
  # these .Rmd files within analysis enable use to apply workflowr::wflow_build
  file_aliases <- paste0("./analysis/", gsub("/", "__", files))
  mapply(generate_rmd, files, file_aliases, dir=dir)
  
  # build .Rmd files
  workflowr::wflow_build(files=file_aliases, ...)
  
  # remove temporary analysis copy files 
  invisible(file.remove(file_aliases))
}



################################################################################




#' workflowr::wflow_publish for .Rmd in directories other than analysis
#' 
#' @description Function which wraps around workflowr functions \code{workflowr::wflow_git_commit()} and 
#' \code{workflowr::wflow_git_build()} to commit the .Rmd document in the user provided dir subfolder of the
#' workflowr project, temporarily builds a .Rmd file in the analysis subfolder, 
#' publishes this, and then removes the analysis subfolder copy. Any undocumented function arguments are just the same as those for 
#' \code{workflowr::wflow_publish}. 
#' 
#' @param files As per workflowr::wflow_build, the names of the .Rmd files to build
#' @param dir The directory where the .Rmd files to build are found (not analysis!)
#' @param message Commit message for .Rmd files 
#' @param project Where to find the workflowr project. Default is the current wrorking directory. 
#' 
#' 
#' @export
wflow_dir_publish <- function(files=NULL, 
                              dir=NULL, # directory to search for .Rmd files
                              message, # commit message for .Rmd files
                              all = FALSE,
                              force = FALSE,
                              update = FALSE,
                              republish = FALSE,
                              combine = "or",
                              view = getOption("workflowr.view"),
                              delete_cache = FALSE,
                              seed = 12345,
                              verbose = FALSE,
                              dry_run = FALSE,
                              project = ".") { # wflow_build options
  
  # check directory is set
  if(is.null(dir)){
    stop("You haven't specified a directory to find the file (dir = NULL). Please set dir to be the name of this directory.")
  }
  
  # check files exist ---------------------------------------------------------
  if (is.null(files)) {
    files <- list.files(paste0('./', dir), recursive=T, 
                        include.dirs=T, pattern="./*.(r|R)md")
    wflow_files <- NULL # this is for checking whether to commit .Rmds
  }
  else {
    for (file in files) {
      path <- paste0(dir, "/", file)
      if (!file.exists(paste0('./', path)))
        stop(paste0("File doesn't exist: ./", path))
    }
    wflow_files <- files; 
  }
  
  if (is.null(message)) {
    message <- deparse(sys.call())
    message <- paste(message, collapse = "\n")
  } else if (is.character(message)) {
    message <-message
  } else {
    stop("message must be NULL or a character vector")
  }
  
  
  # assert_is_flag(all)
  # assert_is_flag(force)
  # assert_is_flag(update)
  # assert_is_flag(republish)
  # combine <- match.arg(combine, choices = c("or", "and"))
  # assert_is_flag(view)
  # assert_is_flag(delete_cache)
  
  if (!(is.numeric(seed) && length(seed) == 1))
    stop("seed must be a one element numeric vector")
  # 
  # assert_is_flag(verbose)
  # assert_is_flag(dry_run)
  # check_wd_exists()
  # assert_is_single_directory(project)
  # project <- absolute(project)
  
  #if (isTRUE(getOption("workflowr.autosave"))) autosave()
  
  
  # Assess project status ------------------------------------------------------
  
  s0 <- workflowr::wflow_status(project = project)
  r <- git2r::repository(path = s0$git)
  commit_current <- git2r::commits(r, n = 1)[[1]]
  
  # Step 0: Confirm there is something to do -----------------------------------
  
  if (is.null(wflow_files) && !all && !update && !republish && !dry_run)
    stop("You did not tell wflow_publish() what to publish.\n",
         "Unlike wflow_build(), it requires that you name the Rmd files you want to publish.\n")
  
  # Step 1: Commit analysis files ----------------------------------------------
  
  # Decide if wflow_git_commit should be run. At least one of the following
  # scenarios must be true:
  #
  # 1) Rmd files were specified and at least one is scratch (untracked) or has
  # unstaged/staged changes
  #
  # 2) `all == TRUE` and at least one tracked file has unstaged/staged changes
  #
  # 3) At least one non-Rmd file was specified
  scenario1 <- !is.null(wflow_files) &&
    any(unlist(s0$status[wflow_files, c("mod_unstaged", "mod_staged", "scratch")]),
        na.rm = TRUE)
  scenario2 <- all &&
    any(unlist(s0$status[s0$status$tracked, c("mod_unstaged", "mod_staged")]),
        na.rm = TRUE)
  scenario3 <- !is.null(wflow_files) &&
    any(!(files %in% rownames(s0$status)))
  
  if (scenario1 || scenario2 || scenario3) {
    # step1 <- wflow_git_commit_(files = files, message = message,
    #                            all = all, force = force,
    #                            dry_run = dry_run, project = project)
    
    workflowr::wflow_git_commit(files = paste0(dir, "/", files), 
                                all = all,
                                force = force,
                                project = project,
                                message = message)
    # If subsequent steps fail, undo this action by resetting the Git repo to
    # its initial state.
    on.exit(git2r::reset(commit_current, reset_type = "mixed"), add = TRUE)
    s1 <- wflow_status(project = project)
  } else {
    step1 <- NULL
    s1 <- s0
  }
  
  
  # commit .Rmds files - in their correct directory 
  #workflowr::wflow_git_commit(files = paste0(dir, "/", file), message = message)
  
  # add .Rmd file to analysis folder (for each file), for which the original .Rmds are child documents
  # these .Rmd files within analysis enable use to apply workflowr::wflow_build
  file_aliases <- paste0("./analysis/", gsub("/", "__", files))
  mapply(generate_rmd, files, file_aliases, dir=dir)
  
  # build .Rmd files
  workflowr::wflow_build(files=file_aliases,
                         republish = republish,
                         dry_run = dry_run,
                         project = project)
  
  # commit html files 
  workflowr::wflow_git_commit(files = "public/", 
                              message = "Build site")
  
  # remove temporary analysis copy files 
  invisible(file.remove(file_aliases))
}



###############################################################################

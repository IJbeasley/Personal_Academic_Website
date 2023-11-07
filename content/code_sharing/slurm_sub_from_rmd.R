
#' Submit a slurm job from a .Rmd file - and print the input and out information 
#' on this job in the .Rmd file in a nice way (markdowned, tabbed, and collapsed)
#'
#' @param slurm_file The .slurm file to submit using slurmR::sbatch 
#'
#' @return Markdown code to display slurm job information. For this function to
#' behave as expected - then you need to set results = 'asis' in the .Rmd r code chunk
#' 
#' @export
#'
#' @examples
slurm_submission = function(slurm_file) {
  
  message("Reading in the slurm input file \n")
  
  # Read the input .slurm file - to paste the exact settings used to 
  # produce the analysis
  
  input = suppressWarnings(
    paste(
      readLines(
        here::here(slurm_file)
      ), 
      sep = "\n")
  )
  
  
  # submit the job
  # in this case sbatch returns the job id
  jobID = suppressWarnings(
                           slurmR::sbatch(slurm_file)
                          )
  
  # wait for the slurm job to be completed / or failed
  slurmR::wait_slurm(jobID)
  
  if (slurmR::status(jobID) == 0){
    
    message("\n ... Job completed successfully!")
    
  } else {
    
    stop("\n Job didn't complete successfully.")
    
  } 
  
  # print out job statistics for this slurm job
  message("\n Job statistics: ")
  
  print(
  slurmR::sacct(x = jobID, 
                brief =T,
                parsable = T, 
                allocations = T,
                format ="User,JobID,Jobname,partition,state,elapsed,MaxRss,ncpus,TotalCPU")
  )
  
  message("\n Now collecting results from the .out file!")
  
  # collect the .out file results
  
  # find the name of the output file
  output  = gsub(
    paste0("../", basename(slurm_file)),
    paste0("slurm-",jobID,".out"),
    tools::file_path_as_absolute(slurm_file)
  )
  
  # read this output file
  output = suppressWarnings(
    paste(
      readLines(output),
      sep = "\n")
  )
  
  # Write the tabbed section showing the slurm job information 
  cat(
    '<div class="toggle">',
    "\n\n",
    "<details><summary> Slurm Job Information </summary>",
    "## Slurm Job Information  {.tabset}",
    "### Input file information",
    "This shows the exact input file / settings used to produce the results",
    "```{r}", gluedown::md_text(input), "```",
    "### Output file information", 
    "This shows the .out file produced during the submission of this slurm script",
    "```{r}", gluedown::md_text(output), "```",
    "</details>",
    '</div>',
    sep="\n"
  )
  
  
}

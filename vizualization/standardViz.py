# this is using Visit Python so there is access to some extra environmental varaibles

args = Argv()
# First argument, filename, second argument is filepath to save output
# if no second element, then don't save just show 
# potential other arguments (start stop), and which physical parameters

# Vizualize temp, ice

OpenDatabase(args[0], 0)


# Save temperature video
AddPlot("Pseudocolor", "temp")
DrawPlots()

# Set the basic save options.
save_atts = SaveWindowAttributes()
save_atts.family = 0
save_atts.format = save_atts.PNG
save_atts.resConstraint = save_atts.NoConstraint
save_atts.width = 1200
save_atts.height = 1068

# Get the number of time steps.
n_time_steps = TimeSliderGetNStates()

# Loop over the time states saving an image for each state.
for time_step in range(0,n_time_steps):
    TimeSliderSetState(time_step)
    save_atts.fileName = f"{args[1]}_{time_step}.png"
    SetSaveWindowAttributes(save_atts)
    SaveWindow()

# My navigation function #######################################################
function nav

    # If a path is provided cd to it
    if count $argv > /dev/null
            cd $argv
    end

    # Print contents of the now current directory
    if test $status -eq 0
        ls -a1
    end

end
################################################################################

# Calculator function ##########################################################
function calc
    python -c "from math import *; print( $argv )"
end
    
################################################################################

# Play random sttuff ###########################################################
function i_feel_lucky
	xdg-open (random choice (ls)) &
end
################################################################################

# Bindings for backward/forward kill words #####################################
bind \cH backward-kill-word
bind \e\[3\;5~ kill-word
################################################################################

# Write wisdom when opening a console ##########################################
fortune | cowsay -f dragon | lolcat
################################################################################

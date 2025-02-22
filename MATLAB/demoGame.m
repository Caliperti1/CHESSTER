function dG = demoGame()

pieces =[" "     " "     " "     " "     " "     " "     " "     " " 
    " "     "R"     " "     "K"     " "     " "     " "     " " 
    "  "    "  "    "  "    "  "    "  "    "N"    "  "    "  "
    "  "    "  "    "P"    "  "    "  "    "  "    "  "    "P"
    "  "    "  "    "  "    "  "    "  "    "  "    "  "    "  "
    "P"    "  "    "  "    "P"    "  "    "K"    "  "    "  "
    "  "    "K"    "  "    "  "    "  "    "  "    "  "    "B"  
    "  "    "  "    "  "    "  "    "  "    "  "    "  "    "  " ];

colors  =[   " "     " "     " "     " "     " "     " "     " "     " " 
    " "     "B"     " "     "B"     " "     " "     " "     " " 
    "  "    "  "    "  "    "  "    "  "    "B"    "  "    "  "
    "  "    "  "    "B"    "  "    "  "    "  "    "  "    "B"
    "  "    "  "    "  "    "  "    "  "    "  "    "  "    "  "
    "B"    "  "    "  "    "W"    "  "    "W"    "  "    "  "
    "  "    "W"    "  "    "  "    "  "    "  "    "  "    "B"  
    "  "    "  "    "  "    "  "    "  "    "  "    "  "    "  " ];

    dG = strings(8,8,2);
    dG(:,:,1) = pieces;
    dG(:,:,2) = colors;

    end 
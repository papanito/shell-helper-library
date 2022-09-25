# @file colors.sh
# @description pre-defined colors and helper functions

# @description declare array `c` with pre-defined colors
# shamelessly copied from https://github.com/zpm-zsh/colors/blob/master/colors.plugin.zsh
# @noargs
defineColors() {
   if [[ -z "$NO_COLOR" && "$CLICOLOR" != 0 ]]; then
      export CLICOLOR=1
      typeset -Ag c
      if [ -n "$ZSH_VERSION" ]; then
         c=(
            reset '[0m'

            bold '[0m'
            dim '[2m'
            coursive '[3m'
            underline '[4m'
            blink '[5m'
            inverse '[7m'
            hidden '[8m'
            strike '[9m'
            double_underline '[4;21m'
            overline '[53m'

            reset_text '[22m'
            no_coursive '[23m'
            no_underline '[24m'
            no_blink '[25m'
            no_inverse '[27m'
            no_hidden '[28m'
            no_strike '[29m'

            default '[39m'
            base3 '[30m'
            black '[30m' # Do not use this. Just for compatibility
            red '[31m'
            green '[32m'
            yellow '[33m'
            blue '[34m'
            magenta '[35m'
            cyan '[36m'
            base0 '[37m'
            white '[37m' # Do not use this. Just for compatibility

            base2 '[30;90m'
            grey '[30;90m' # Do not use this. Just for compatibility
            light_red '[31;91m'
            light_green '[32;92m'
            light_yellow '[33;93m'
            light_blue '[34;94m'
            light_magenta '[35;95m'
            light_cyan '[36;96m'
            base1 '[37;97m'
            light_grey '[37;97m' # Do not use this. Just for compatibility

            bg_default '[49m'
            bg_base3 '[40m'
            bg_black '[40m'
            bg_red '[41m'
            bg_green '[42m'
            bg_yellow '[43m'
            bg_blue '[44m'
            bg_magenta '[45m'
            bg_cyan '[46m'
            bg_base0 '[47m'
            bg_white '[47m'

            bg_base2 '[40;100m'
            bg_grey '[40;100m'
            bg_light_red '[41;101m'
            bg_light_green '[42;102m'
            bg_light_yellow '[43;103m'
            bg_light_blue '[44;104m'
            bg_light_magenta '[45;105m'
            bg_light_cyan '[46;106m'
            bg_base1 '[47;107m'
            bg_light_grey '[47;107m'

            raw_reset '0'

            raw_bold '1'
            raw_dim '2'
            raw_coursive '3'
            raw_underline '4'
            raw_blink '5'
            raw_inverse '7'
            raw_hidden '8'
            raw_strike '9'
            raw_double_underline '4;21'
            raw_overline '53'

            raw_reset_text '22'
            raw_no_coursive '23'
            raw_no_underline '24'
            raw_no_blink '25'
            raw_no_inverse '27'
            raw_no_hidden '28'
            raw_no_strike '29'

            raw_default '39'
            raw_base3 '30'
            raw_black '30' # Do not use this. Just for compatibility
            raw_red '31'
            raw_green '32'
            raw_yellow '33'
            raw_blue '34'
            raw_magenta '35'
            raw_cyan '36'
            raw_base0 '37'
            raw_white '37' # Do not use this. Just for compatibility

            raw_base2 '30;90'
            raw_grey '30;90' # Do not use this. Just for compatibility
            raw_light_red '31;91'
            raw_light_green '32;92'
            raw_light_yellow '33;93'
            raw_light_blue '34;94'
            raw_light_magenta '35;95'
            raw_light_cyan '36;96'
            raw_base1 '37;97'
            raw_light_grey '37;97' # Do not use this. Just for compatibility

            raw_bg_default '49'
            raw_bg_base3 '40'
            raw_bg_black '40'
            raw_bg_red '41'
            raw_bg_green '42'
            raw_bg_yellow '43'
            raw_bg_blue '44'
            raw_bg_magenta '45'
            raw_bg_cyan '46'
            raw_bg_base0 '47'
            raw_bg_white '47'

            raw_bg_base2 '40;100'
            raw_bg_grey '40;100'
            raw_bg_light_red '41;101'
            raw_bg_light_green '42;102'
            raw_bg_light_yellow '43;103'
            raw_bg_light_blue '44;104'
            raw_bg_light_magenta '45;105'
            raw_bg_light_cyan '46;106'
            raw_bg_base1 '47;107'
            raw_bg_light_grey '47;107'
         )
      else
         c=(
            [reset]='[0m'

            [bold]='[0m'
            [dim]='[2m'
            [coursive]='[3m'
            [underline]='[4m'
            [blink]='[5m'
            [inverse]='[7m'
            [hidden]='[8m'
            [strike]='[9m'
            [double_underline]='[4;21m'
            [overline]='[53m'

            [reset_text]='[22m'
            [no_coursive]='[23m'
            [no_underline]='[24m'
            [no_blink]='[25m'
            [no_inverse]='[27m'
            [no_hidden]='[28m'
            [no_strike]='[29m'

            [default]='[39m'
            [base3]='[30m'
            [black]='[30m' # Do not use this. Just for compatibility
            [red]='[31m'
            [green]='[32m'
            [yellow]='[33m'
            [blue]='[34m'
            [magenta]='[35m'
            [cyan]='[36m'
            [base0]='[37m'
            [white]='[37m' # Do not use this. Just for compatibility

            [base2]='[30;90m'
            [grey]='[30;90m' # Do not use this. Just for compatibility
            [light_red]='[31;91m'
            [light_green]='[32;92m'
            [light_yellow]='[33;93m'
            [light_blue]='[34;94m'
            [light_magenta]='[35;95m'
            [light_cyan]='[36;96m'
            [base1]='[37;97m'
            [light_grey]='[37;97m' # Do not use this. Just for compatibility

            [bg_default]='[49m'
            [bg_base3]='[40m'
            [bg_black]='[40m'
            [bg_red]='[41m'
            [bg_green]='[42m'
            [bg_yellow]='[43m'
            [bg_blue]='[44m'
            [bg_magenta]='[45m'
            [bg_cyan]='[46m'
            [bg_base0]='[47m'
            [bg_white]='[47m'

            [bg_base2]='[40;100m'
            [bg_grey]='[40;100m'
            [bg_light_red]='[41;101m'
            [bg_light_green]='[42;102m'
            [bg_light_yellow]='[43;103m'
            [bg_light_blue]='[44;104m'
            [bg_light_magenta]='[45;105m'
            [bg_light_cyan]='[46;106m'
            [bg_base1]='[47;107m'
            [bg_light_grey]='[47;107m'

            [raw_reset]='0'

            [raw_bold]='1'
            [raw_dim]='2'
            [raw_coursive]='3'
            [raw_underline]='4'
            [raw_blink]='5'
            [raw_inverse]='7'
            [raw_hidden]='8'
            [raw_strike]='9'
            [raw_double_underline]='4;21'
            [raw_overline]='53'

            [raw_reset_text]='22'
            [raw_no_coursive]='23'
            [raw_no_underline]='24'
            [raw_no_blink]='25'
            [raw_no_inverse]='27'
            [raw_no_hidden]='28'
            [raw_no_strike]='29'

            [raw_default]='39'
            [raw_base3]='30'
            [raw_black]='30' # Do not use this. Just for compatibility
            [raw_red]='31'
            [raw_green]='32'
            [raw_yellow]='33'
            [raw_blue]='34'
            [raw_magenta]='35'
            [raw_cyan]='36'
            [raw_base0]='37'
            [raw_white]='37' # Do not use this. Just for compatibility

            [raw_base2]='30;90'
            [raw_grey]='30;90' # Do not use this. Just for compatibility
            [raw_light_red]='31;91'
            [raw_light_green]='32;92'
            [raw_light_yellow]='33;93'
            [raw_light_blue]='34;94'
            [raw_light_magenta]='35;95'
            [raw_light_cyan]='36;96'
            [raw_base1]='37;97'
            [raw_light_grey]='37;97' # Do not use this. Just for compatibility

            [raw_bg_default]='49'
            [raw_bg_base3]='40'
            [raw_bg_black]='40'
            [raw_bg_red]='41'
            [raw_bg_green]='42'
            [raw_bg_yellow]='43'
            [raw_bg_blue]='44'
            [raw_bg_magenta]='45'
            [raw_bg_cyan]='46'
            [raw_bg_base0]='47'
            [raw_bg_white]='47'

            [raw_bg_base2]='40;100'
            [raw_bg_grey]='40;100'
            [raw_bg_light_red]='41;101'
            [raw_bg_light_green]='42;102'
            [raw_bg_light_yellow]='43;103'
            [raw_bg_light_blue]='44;104'
            [raw_bg_light_magenta]='45;105'
            [raw_bg_light_cyan]='46;106'
            [raw_bg_base1]='47;107'
            [raw_bg_light_grey]='47;107'
         )
      fi
   else
      export CLICOLOR=0
      export NO_COLOR=1
   fi
}
defineColors

# @description print all 256 colors for testing TERM or for a quick reference
# show numerical values for each of the 256 colors in bash
colors2nums() {
   for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done
}

# @description show color for given number
# @arg $1 int value of the color to show
getColor() {
   echo -e "\e[38;05;$1mColor"
}

# @description displays all 256 possible background colors, using ANSI escape sequences.
# author: Chetankumar Phulpagare
# used in ABS Guide with permission.
colors2() {
   T1=8
   T2=6
   T3=36
   offset=0
   for num1 in {0..7}; do
      {
         for num2 in {0,1}; do
            {
               shownum=$(echo "$offset + $T1 * ${num2} + $num1" | bc)
               echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
            }
         done
         echo
      }
   done
   offset=16
   for num1 in {0..5}; do
      {
         for num2 in {0..5}; do
            {
               for num3 in {0..5}; do
                  {
                     shownum=$(echo "$offset + $T2 * ${num3} \
              + $num2 + $T3 * ${num1}" | bc)
                     echo -en "\E[0;48;5;${shownum}m color ${shownum} \E[0m"
                  }
               done
               echo
            }
         done
      }
   done
   offset=232
   for num1 in {0..23}; do
      {
         shownum=$(expr $offset + $num1)
         echo -en "\E[0;48;5;${shownum}m ${shownum}\E[0m"
      }
   done
   echo
}

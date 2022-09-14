# @file math.sh
# @brief Mathematical functions
# @description helper functions for mathematics and number manipulation

# @description list of numbers with equal width i.e. number with 0-prefixed
# @arg $1 int numbers to print
function nseq()
{
   seq -w 0 "$1"
}

# @description finding the square root of numbers
# @arg $1 int numbers to use for calc
function sqrt()
{
   echo "sqrt ("$1")" | bc -l
}

# @description trigonmetry calculations with angles
function trig-angle()
{
   echo "Enter angle in degree: "
   read deg
   # Note: Pi calculation
   # tan(pi/4) = 1
   # atan(1) = pi/4 and
   # pi = 4*atan(1)
   pi=`echo "4*a(1)" | bc -l`
   rad=`echo "$deg*($pi/180)" | bc -l`
   echo "$deg Degree = $rad Radian"
   echo "Sin($deg): "
   echo "s($rad)" | bc -l
   echo "Cos($deg): "
   echo "c($rad)" | bc -l
   echo "Tan($deg): "
   echo "s($rad)/c($rad)" | bc -l
}

# @description round numerals to whole numbers
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 number number to round
# @arg $2 int digits to round to
function round()
{
   if [[ $1 ]]; then
      if [[ $2 ]]; then
         echo "$(printf %.${2}f $1)"
      else
         echo "$(printf %.0f $1)"
      fi
   fi
}

# @description convert arabic to roman numerals
# Copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int number to convert
function arabic2roman()
{
   echo $1 | sed -e 's/1...$/M&/;s/2...$/MM&/;s/3...$/MMM&/;s/4...$/MMMM&/
   s/6..$/DC&/;s/7..$/DCC&/;s/8..$/DCCC&/;s/9..$/CM&/
   s/1..$/C&/;s/2..$/CC&/;s/3..$/CCC&/;s/4..$/CD&/;s/5..$/D&/
   s/6.$/LX&/;s/7.$/LXX&/;s/8.$/LXXX&/;s/9.$/XC&/
   s/1.$/X&/;s/2.$/XX&/;s/3.$/XXX&/;s/4.$/XL&/;s/5.$/L&/
   s/1$/I/;s/2$/II/;s/3$/III/;s/4$/IV/;s/5$/V/
   s/6$/VI/;s/7$/VII/;s/8$/VIII/;s/9$/IX/
   s/[0-9]//g'
}

# @description Averaging columns of numbers
# Computes a columns average in a file
# @arg $1 int column number
# @arg $2 string optional pattern
function avg()
{
   awk "/$2/{sum += \$$1; lc += 1;} END {printf \"Average over %d lines: %f\n\", lc, sum/lc}"
}

# @description the notorious "hailstone" or Collatz series.
# @arg $1 int seed number
function collatz()
{
   # get the integer "seed" from the command-line to generate the integer "result"
   # if NUMBER is even, divide by 2, or if odd, multiply by 3 and add 1
   # the theory is that every sequence eventually settles down to repeating "4,2,1..." cycles
   MAX_ITERATIONS=200
   # For large seed numbers (>32000), try increasing MAX_ITERATIONS.
   h=${1:-$$}                      #  Seed. #  Use $PID as seed, #+ if not specified as command-line arg.
   echo
   echo "C($h) --- $MAX_ITERATIONS Iterations"
   echo
   for ((i=1; i<=MAX_ITERATIONS; i++))
   do
      COLWIDTH=%7d
      printf $COLWIDTH $h
      let "remainder = h % 2"
      if [ "$remainder" -eq 0 ]   # Even?
         then
         let "h /= 2"              # Divide by 2.
      else
         let "h = h*3 + 1"         # Multiply by 3 and add 1.
      fi
      COLUMNS=10                    # Output 10 values per line.
      let "line_break = i % $COLUMNS"
      if [ "$line_break" -eq 0 ]
         then
           echo
      fi
   done
   echo
}

# @section Randomness
# @description functions dealing with randmoness

# @description This script models Brownian motion:
# random wanderings of tiny particles in fluid, as they are buffeted
# by random currents and collisions (colloquially known as "Drunkard's Walk")
# Author: Mendel Cooper
function brownian()
{
   PASSES=500                  #  Number of particle interactions / marbles.
   ROWS=10                     #  Number of "collisions" (or horiz. peg rows).
   RANGE=3                     #  0 - 2 output range from $RANDOM.
   POS=0                       #  Left/right position.
   RANDOM=$$                   #  Seeds the random number generator from PID of script.
   declare -a Slots            # Array holding cumulative results of passes.
   NUMSLOTS=21                 # Number of slots at bottom of board.
   function Initialize_Slots()
   {    # Zero out all elements of the array.
      for i in $( seq $NUMSLOTS )
      do
      Slots[$i]=0
      done
      echo                        # Blank line at beginning of run.
   }
   function Show_Slots()
   {
      echo -n " "
      for i in $( seq $NUMSLOTS )      # Pretty-print array elements.
      do
      printf "%3d" ${Slots[$i]}      # Allot three spaces per result.
      done
      echo             # Row of slots:
      echo " |__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|__|"
      echo "                                ^^"
      echo             #  Note that if the count within any particular slot exceeds 99,
                     #+ it messes up the display.
                     #  Running only(!) 500 passes usually avoids this.
   }
   function Move()
   {                 # Move one unit right / left, or stay put.
     Move=$RANDOM               # How random is $RANDOM? Well, let's see ...
     let "Move %= RANGE"        # Normalize into range of 0 - 2.
     case "$Move" in
      0 ) ;;                 # Do nothing, i.e., stay in place.
      1 ) ((POS--));;        # Left.
      2 ) ((POS++));;        # Right.
      * ) echo -n "Error ";;      # Anomaly! (Should never occur.)
     esac
   }
   function Play()
   {               # Single pass (inner loop).
   i=0
   while [ "$i" -lt "$ROWS" ]      # One event per row.
   do
     Move
     ((i++));
   done
   SHIFT=11                        # Why 11, and not 10?
   let "POS += $SHIFT"             # Shift "zero position" to center.
   (( Slots[$POS]++ ))             # DEBUG: echo $POS
     }
   function Run()
{                # Outer loop.
   p=0
   while [ "$p" -lt "$PASSES" ]
   do
     Play
     (( p++ ))
     POS=0                         # Reset to zero. Why?
   done
     }
   # main()
   Initialize_Slots
   Run
   Show_Slots
}

# flip a single coin 1000 times and show results
function coin-flip()
{
   SEED=$"(head -1 /dev/urandom | od -N 1 | awk '{ print $2 }')"
   RANDOM=$SEED
   SIDES=2             # A coin has 2 sides.
   MAXTHROWS=1000      # Increase this if you have nothing better to do with your time.
   throw=0            # Throw count.
   heads=0             # Must initialize counts to zero,
   tails=0             # since an uninitialized variable is null, not zero.
   function print_result()
   {
      echo
      echo "heads =   $heads"
      echo "tails =   $tails"
      echo
   }
   function update_count()
   {
      case "$1" in
        0) let "heads += 1";; # Since coin has no "zero", this corresponds to 1.
        1) let "tails += 1";; # And this to 2, etc.
      esac
   }
   echo
   while [ "$throw" -lt "$MAXTHROWS" ]
   do
   let "coin1 = RANDOM % $SIDES"
   update_count $coin1
   let "throw += 1"
   done
   print_result
   echo "Out of a total of "$MAXTHROWS" tosses."
   echo "Change \"MAXTHROWS=1000\" if you want a different number of tosses."
}

# @description random number (out of whatever you input)
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 string [optional] `-L` or `-r` 
# @arg $2 int value
function random()
{
   if [[ $1 == -l ]]; then
      echo $(cat /dev/urandom | tr -cd '[:digit:]' | head -c ${2-5})
   elif [[ $1 == -r ]]; then
      echo $((RANDOM%${2}))
   else
      echo $((RANDOM%${1}))
   fi
}

# @description calculate powers of numerals
# copyright 2007 - 2010 Christopher Bratusek
# @arg $1 int base number
# @arg $2 int optional power (default is 2)
function power()
{ 
   if [[ $1 ]]; then
      if [[ $2 ]]; then
         echo "$1 ^ $2" | bc
      else
         echo "$1 ^ 2" | bc
      fi
   fi
}

# @description calcutale factorial of an integer
function factorial()
{ 
   echo "Enter an integer: "
   read n
   # Below we define the factorial function in bc syntax
   fact="define f (x) {
   i=x
   fact=1
   while (i > 1) {
      fact=fact*i
      i=i-1
      }
         return fact
      }"
   # Below we pass the function defined above, and call it with n as a parameter and pipe it to bc
   factorial=$(echo "$fact;f($n)" | bc -l)
   echo "$n! = $factorial"
}

# @description finding logs for numbers
function math-log()
{ 
   echo "Enter value: "
   read x
   echo "Natural Log: ln($x) :"
   echo "l($x)" | bc -l
   echo "Ten Base Log: log($x) :"
   echo "l($x)/l(10)" | bc -l
}


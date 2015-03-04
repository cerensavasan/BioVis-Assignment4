# BioVis-Assignment4
by Ceren Savasan

##Design of the Visualization
I chose to use letters to just display the alignment as it is, and couple it with a color scheme.
In its current state, the algorithm does not account for data lengthier than 250 characters. I have chosen to shorten any string that would surpass that limit. 

##Source Code
I am using the following fasta files as data input.
sequence.fasta = http://www.ncbi.nlm.nih.gov/protein/CAB93537
given.fasta = http://web.cs.wpi.edu/~matt/courses/bcb4002/data/sequence.fasta

The rest of the script is my original code.

##Biological Significance
Using the algorithm I can align sequences of any size, the only adjustment I'd have to make is when drawing, to limit the length of the drawing and continue onto a line below.  I can also parse any .fasta file into exons that can be compares, which increases the usability of the code.

##Technical Significance
I have the algorithmn in place to iterate through the two exons being compared and for gaps '-' is used, and I can currently find an effective alignment for exons up to 250 characters. I initially used a data table as the matrix that calculations are run on, but switched to an array when I saw that this greatly increased the speed with which a correct alignment is calculated.

##How to Run the Program
Inside the Sequencing folder, open up the Sequencing.pde and run in Processing.

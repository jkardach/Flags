

#Flags
The stateData struct does most of the work.  It's main function is to crate a struct
which loads all of its data from a JSON file loaded in the bundle (see the
"States.json" fle in the navigator).  This file was created by MIT in a civics
project for here: https://github.com/CivilServiceUSA/us-states.  For the
the assigmnet we had to list the largest city in the state also, which I
updated the JSON and added a field for each state for "largest_city".  As it
had all of this wonderful data, I decided to do all 50 states, but some of
the data was stale.  url's to some of the state goverment and constitutions
was bad, so I manually updated these also.

A couple of interesting tricks here.  All of the images are urls, so they are
downloaded.  Some of these images are very large.  So I've defined the image
variables are lazy variables so that they are only loaded (from the web) when
they are used the first time, after that they use the actual png (for lazy
variables only execute the code the first time they are called).  Then some
of the images I resize at the same time, as I don't want to load a huge image
into a small tableview.  So when the first tableview starts, the app can be a
little hesitent the first time as it is downloading the screen full of images,
and more as you scroll.  However this is only done the first time, so the
application speeds up.

The JSON is loaded from the bundle and decoded.  Here I used a bundle extension
to load the sttes.json data (which I obtained from the hacking with Swift
Website).

An UIImageView extension for loading an image from a URL is used to load each
image (which I obtained from the hacking with Swift Website).

Finally I use a UIImage extension to rescale the UIImage downloaded from the
web (which I obtained from an article Robert Pieta did on how to resize a
a UIImage without stretching it.

Otherwise the application is pretty basic.  It loads directly into StatesTVC which creates a
StatesData object which grabs all of the data out of the bundle (states.json) and displays
it in the tableview.  The state flag is displayed on the UIImageView of the basic cell. 

If a state is punched, this loads a detail tableview controller (DetailTVC) which displays in
the following content (by row) over a scenic view image of the state as the tableviews 
background image:
  (image of flag) Flag
  (image of seal) Seal
  (image showing state location) State shape
  (skyline of capital) and capital city name
  largest cities name
  population of the state (and population rank of 50 states)
  statehood year and which order
  a link to the state governments webpage
  a link to the state's constitution
  
The cell's background color was modified to clear to allow you to see the text over the scenic
view, and used a yellow text color as it shows up well on the images.
  
Further if you click on the governments webpage or states constitution, it loads a webkit
(WebVC) and displays the appropriate webpage.

The last part of the assignment was to put another Tab bar and tab-bar items to select
the flags app, and an info to display information about the app.  The tab-bar selects an "info"
icon and then lists the different attributes of the application.
